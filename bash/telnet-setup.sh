#!/usr/bin/env bash
set -euo pipefail

# --- helpers ---
need_root() { [[ $EUID -eq 0 ]] || { echo "Please run as root." >&2; exit 1; }; }
have_cmd() { command -v "$1" >/dev/null 2>&1; }
unit_exists() { systemctl list-unit-files --type=service --type=socket | awk '{print $1}' | grep -qx "$1"; }
ensure_pkg() {
  local pkg="$1"
  pacman -Q "$pkg" >/dev/null 2>&1 || pacman -Sy --noconfirm "$pkg"
}
enable_now() { systemctl enable --now "$1"; }

ip_v4() {
  local ip=""
  if have_cmd ip; then
    ip=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if ($i=="src"){print $(i+1); exit}}' || true)
  fi
  [[ -z "${ip}" ]] && ip=$(hostname -I 2>/dev/null | awk '{print $1}')
  echo "${ip:-unknown}"
}

ensure_user() {
  local user="$1" pass="$2"
  if ! id -u "$user" >/dev/null 2>&1; then
    getent group wheel >/dev/null || groupadd wheel
    useradd -m -s /bin/bash -G wheel "$user"
  fi
  echo "${user}:${pass}" | chpasswd
}

ensure_sudo_env() {
  ensure_pkg sudo
  # Preserve LFS env during sudo -E and allow passwordless for wheel (RAM-only lab box)
  if [[ ! -f /etc/sudoers.d/lfs ]]; then
    cat >/etc/sudoers.d/lfs <<'EOF'
Defaults:wakirk env_keep += "LFS LFS_TGT MAKEFLAGS TESTSUITEFLAGS CONFIG_SITE PATH"
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
    chmod 440 /etc/sudoers.d/lfs
  fi
}

start_telnet() {
  # inetutils provides telnetd
  ensure_pkg inetutils
  if unit_exists telnet.socket; then
    enable_now telnet.socket
  else
    # Fallback: simple service running inetutils telnetd in foreground (-debug)
    cat >/etc/systemd/system/telnetd.service <<'UNIT'
[Unit]
Description=Simple Telnet Server (inetutils telnetd)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/telnetd -debug -p 23 -l /bin/login
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT
    systemctl daemon-reload
    enable_now telnetd.service
  fi
}

open_firewall_port23() {
  # Prefer iptables on this SystemRescue (INPUT policy DROP)
  if have_cmd iptables; then
    iptables -C INPUT -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT 2>/dev/null \
      || iptables -I INPUT 1 -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT
    if have_cmd ip6tables; then
      ip6tables -C INPUT -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT 2>/dev/null \
        || ip6tables -I INPUT 1 -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT || true
    fi
    # Persist (harmless on RAM-only; useful if you keep the session up)
    mkdir -p /etc/iptables
    have_cmd iptables-save && iptables-save  >/etc/iptables/iptables.rules
    have_cmd ip6tables-save && ip6tables-save >/etc/iptables/ip6tables.rules 2>/dev/null || true
    unit_exists iptables.service && enable_now iptables.service || true
    echo "Firewall: opened 23/tcp via iptables."
    return
  fi

  # nftables
  if have_cmd nft; then
    unit_exists nftables.service && enable_now nftables.service || true
    nft list tables 2>/dev/null | grep -q 'inet filter' || {
      nft add table inet filter
      nft add chain inet filter input '{ type filter hook input priority 0; policy accept; }'
    }
    nft list chain inet filter input 2>/dev/null | grep -q 'tcp dport 23' || \
      nft add rule inet filter input tcp dport 23 accept
    nft list ruleset >/etc/nftables.conf
    unit_exists nftables.service && systemctl restart nftables.service || true
    echo "Firewall: opened 23/tcp via nftables."
    return
  fi

  # ufw
  if have_cmd ufw; then
    ufw status >/dev/null 2>&1 || true
    yes | ufw enable >/dev/null 2>&1 || true
    ufw allow 23/tcp >/dev/null
    echo "Firewall: opened 23/tcp via ufw."
    return
  fi

  # firewalld
  if have_cmd firewall-cmd && systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-port=23/tcp
    firewall-cmd --reload
    echo "Firewall: opened 23/tcp via firewalld."
    return
  fi

  echo "Firewall: no supported tool found; skipped opening port 23." >&2
}

main() {
  need_root
  ensure_user "wakirk" "wakirk"
  ensure_sudo_env
  start_telnet
  open_firewall_port23
  echo "Telnet Address: $(ip_v4)"
  echo "Note: SystemRescue is RAM-only. Reboot to clear all changes."
}

main "$@"


exit 0

#!/usr/bin/env bash

set -euo pipefail

# --- helpers ---
need_root() { [[ $EUID -eq 0 ]] || { echo "Please run as root." >&2; exit 1; }; }
have_cmd() { command -v "$1" >/dev/null 2>&1; }
unit_exists() { systemctl list-unit-files --type=service --type=socket | awk '{print $1}' | grep -qx "$1"; }
ensure_pkg() {
  local pkg="$1"
  pacman -Q "$pkg" >/dev/null 2>&1 || pacman -Sy --noconfirm "$pkg"
}
enable_now() { systemctl enable --now "$1"; }
ip_v4() {
  local ip=""
  if have_cmd ip; then
    ip=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if ($i=="src") {print $(i+1); exit}}' || true)
  fi
  [[ -z "${ip}" ]] && ip=$(hostname -I 2>/dev/null | awk '{print $1}')
  echo "${ip:-unknown}"
}

ensure_user() {
  local user="$1" pass="$2"
  if ! id -u "$user" >/devnull 2>&1; then
    useradd -m -s /bin/bash "$user"
  fi
  echo "${user}:${pass}" | chpasswd
}

start_telnet() {
  # Prefer socket activation if present
  if unit_exists telnet.socket; then
    enable_now telnet.socket
  else
    # Fallback: simple service running inetutils telnetd in foreground (-debug)
    cat >/etc/systemd/system/telnetd.service <<'UNIT'
[Unit]
Description=Simple Telnet Server (inetutils telnetd)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/telnetd -debug -p 23 -l /bin/login
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT
    systemctl daemon-reload
    enable_now telnetd.service
  fi
}

open_firewall_port23() {
  # 1) firewalld
  if have_cmd firewall-cmd && systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-port=23/tcp
    firewall-cmd --reload
    echo "Firewall: opened 23/tcp via firewalld."
    return
  fi

  # 2) ufw
  if have_cmd ufw; then
    # Ensure ufw is enabled without prompting
    ufw status >/dev/null 2>&1 || true
    yes | ufw enable >/dev/null 2>&1 || true
    ufw allow 23/tcp >/dev/null
    echo "Firewall: opened 23/tcp via ufw."
    return
  fi

  # 3) nftables (preferred on modern systems)
  if have_cmd nft; then
    # make sure service is available
    unit_exists nftables.service && enable_now nftables.service || true
    # Ensure inet filter/input exist
    if ! nft list tables 2>/dev/null | grep -q 'inet filter'; then
      nft add table inet filter
      nft add chain inet filter input '{ type filter hook input priority 0; policy accept; }'
    fi
    # Add rule if missing
    if ! nft list chain inet filter input 2>/dev/null | grep -q 'tcp dport 23'; then
      nft add rule inet filter input tcp dport 23 accept
    fi
    # Persist rules
    nft list ruleset >/etc/nftables.conf
    unit_exists nftables.service && systemctl restart nftables.service || true
    echo "Firewall: opened 23/tcp via nftables."
    return
  else
    # If nothing else, install nftables and use it
    ensure_pkg nftables
    systemctl enable --now nftables.service
    cat >/etc/nftables.conf <<'NFT'
#!/usr/sbin/nft -f
flush ruleset
table inet filter {
  chain input {
    type filter hook input priority 0;
    policy accept;
    ct state established,related accept
    iif lo accept
    tcp dport 23 accept
  }
}
NFT
    systemctl restart nftables.service
    echo "Firewall: installed and configured nftables, opened 23/tcp."
    return
  fi

  # 4) iptables (legacy fallback)
  if have_cmd iptables; then
    iptables -C INPUT -p tcp --dport 23 -j ACCEPT 2>/dev/null || iptables -A INPUT -p tcp --dport 23 -j ACCEPT
    # Persist if iptables-save exists
    if have_cmd iptables-save; then
      mkdir -p /etc/iptables
      iptables-save >/etc/iptables/iptables.rules
      # Enable persistence service if available
      if unit_exists iptables.service; then
        enable_now iptables.service
      fi
    fi
    echo "Firewall: opened 23/tcp via iptables."
    return
  fi

  echo "Firewall: no supported firewall tool found; skipped opening port 23." >&2
}

main() {
  need_root

  # 1) Ensure telnet server present
  ensure_pkg inetutils

  # 2) Ensure user
  ensure_user "wakirk" "wakirk"

  # 3) Start telnet without reboot
  start_telnet

  # 4) Open firewall for TCP/23
  open_firewall_port23

  # 5) Show address
  echo "Telnet Address: $(ip_v4)"
}

# 1) Allow NEW TCP connections to port 23 (insert at top so it matches before LOGDROP)
iptables -I INPUT 1 -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT

# (Optional but recommended) also open IPv6 if your LAN uses it
ip6tables -I INPUT 1 -p tcp --dport 23 -m conntrack --ctstate NEW -j ACCEPT

# 2) Verify the rule is first
iptables -L INPUT -n --line-numbers | sed -n '1,10p'
ip6tables -L INPUT -n --line-numbers | sed -n '1,10p'

# 3) Persist across reboots (Arch/SystemRescue style)
mkdir -p /etc/iptables
iptables-save   > /etc/iptables/iptables.rules
ip6tables-save  > /etc/iptables/ip6tables.rules

# 4) Ensure the iptables service loads saved rules on boot (no reboot needed)
systemctl enable --now iptables.service 2>/dev/null || true

main "$@"

