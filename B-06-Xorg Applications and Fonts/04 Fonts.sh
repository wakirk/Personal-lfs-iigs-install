#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.x.org/pub/individual/font/
	# Download size: 3.0 MB
	# Estimated disk space required: 8.8 MB
	# Estimated build time: 0.1 SBU
	echoR "G6 Xorg Applications and Fonts"

	echoL "Downloading External Fonts..."
	sleep 2

	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	rm -fR /sources/Makefonts
	mkdir -p /sources/Makefonts/extract
	# Deja vu
	# https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-2.37.tar.bz2/download
	../bash/Download.sh https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-2.37.tar.bz2/download dejavu-fonts-2.37.tar.bz2
	cp -v ../Packages/dejavu-fonts-2.37.tar.bz2 /sources/Makefonts/extract
	# https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-lgc-fonts-ttf-2.37.tar.bz2/download
	../bash/Download.sh https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-lgc-fonts-ttf-2.37.tar.bz2/download dejavu-lgc-fonts-ttf-2.37.tar.bz2
	cp -v ../Packages/dejavu-lgc-fonts-ttf-2.37.tar.bz2 /sources/Makefonts/extract
	# https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2/download
	../bash/Download.sh https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2/download dejavu-fonts-ttf-2.37.tar.bz2
	cp -v ../Packages/dejavu-fonts-ttf-2.37.tar.bz2 /sources/Makefonts/extract

	# Moto (google fonts)
	# https://github.com/google/fonts/archive/main.zip  over 3000 fonts!!! 
	../bash/Download.sh https://github.com/google/fonts/archive/main.zip motofonts-google-main.zip
	cp -v ../Packages/motofonts-google-main.zip /sources/Makefonts/extract

	# Source-code mono fonts
	# https://github.com/adobe-fonts/source-code-pro/archive/refs/heads/release.zip
	../bash/Download.sh https://github.com/adobe-fonts/source-code-pro/archive/refs/heads/release.zip source-code-pro.zip
	cp -v ../Packages/source-code-pro.zip /sources/Makefonts/extract

	# Open Desktop
	# https://sources.archlinux.org/other/opendesktop-fonts/opendesktop-fonts-1.4.2.tar.gz
	../bash/Download.sh https://sources.archlinux.org/other/opendesktop-fonts/opendesktop-fonts-1.4.2.tar.gz opendesktop-fonts-1.4.2.tar.gz
	cp -v ../Packages/opendesktop-fonts-1.4.2.tar.gz /sources/Makefonts/extract

	# Adwaita 
	# https://download.gnome.org/sources/adwaita-fonts/48/adwaita-fonts-48.2.tar.xz
	../bash/Download.sh https://download.gnome.org/sources/adwaita-fonts/48/adwaita-fonts-48.2.tar.xz adwaita-fonts-48.2.tar.xz
	cp -v ../Packages/adwaita-fonts-48.2.tar.xz /sources/Makefonts/extract

	# GNU FreeFont
	# https://mirror.us-midwest-1.nexcess.net/gnu/freefont/freefont-otf-20120503.tar.gz
	../bash/Download.sh https://mirror.us-midwest-1.nexcess.net/gnu/freefont/freefont-otf-20120503.tar.gz freefont-otf-20120503.tar.gz
	cp -v ../Packages/freefont-otf-20120503.tar.gz /sources/Makefonts/extract

	# Liberation Fonts
	# https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-2.1.5.tar.gz
	../bash/Download.sh https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-2.1.5.tar.gz liberation-fonts-ttf-2.1.5.tar.gz
	cp -v ../Packages/liberation-fonts-ttf-2.1.5.tar.gz /sources/Makefonts/extract
	# https://github.com/liberationfonts/liberation-sans-narrow/files/2579431/liberation-narrow-fonts-ttf-1.07.6.tar.gz
	../bash/Download.sh https://github.com/liberationfonts/liberation-sans-narrow/files/2579431/liberation-narrow-fonts-ttf-1.07.6.tar.gz liberation-narrow-fonts-ttf-1.07.6.tar.gz
	cp -v ../Packages/liberation-narrow-fonts-ttf-1.07.6.tar.gz /sources/Makefonts/extract

	cd /sources/Makefonts/extract
	echoL "Unpacking Fonts..."

	tar -vxsf dejavu-fonts-2.37.tar.bz2
	tar -vxsf dejavu-fonts-ttf-2.37.tar.bz2
	tar -vxsf dejavu-lgc-fonts-ttf-2.37.tar.bz2
	unzip -d ./motofonts-google-main motofonts-google-main.zip
	tar -vxsf opendesktop-fonts-1.4.2.tar.gz
	unzip -d ./source-code-pro source-code-pro.zip
	tar -vxsf adwaita-fonts-48.2.tar.xz
	tar -vxsf freefont-otf-20120503.tar.gz
	tar -vxsf liberation-fonts-ttf-2.1.5.tar.gz
	tar -vxsf liberation-narrow-fonts-ttf-1.07.6.tar.gz

	SRC="/sources/Makefonts/extract"
	STAGE="/sources/Makefonts/fonts"

	echoL "Organizing Fonts..."

	mkdir -p -- "$STAGE"/{TTF,OTF,TTC,Type1,PCF,BDF}

	# TTF / OTF / TTC
	find "$SRC" -type f -iname '*.ttf' -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/TTF/"
	find "$SRC" -type f -iname '*.otf' -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/OTF/"
	find "$SRC" -type f -iname '*.ttc' -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/TTC/"

	# Type 1 + metrics
	find "$SRC" -type f \( -iname '*.pfb' -o -iname '*.pfa' \) -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/Type1/"
	find "$SRC" -type f \( -iname '*.afm' -o -iname '*.pfm' \) -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/Type1/"

	# PCF/BDF (keep compression if present)
	find "$SRC" -type f \( -iname '*.pcf' -o -iname '*.pcf.gz' \) -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/PCF/"
	find "$SRC" -type f \( -iname '*.bdf' -o -iname '*.bdf.gz' \) -print0 | xargs -0 -I{} cp -v -- "{}" "$STAGE/BDF/"

#	# Docs
#	find "$SRC" -type f \( -iname 'license*' -o -iname 'copying*' -o -iname 'readme*' -o -iname 'news*' -o -iname 'authors*' \) -print0 \
#	| xargs -0 -I{} cp -v -- "{}" "$STAGE/doc/"

#	# Odd formats → Misc
#	find "$SRC" -type f \( -iname '*.dfont' -o -iname '*.ttx' -o -iname '*.svg' \) -print0 \
#	| xargs -0 -I{} cp -v -- "{}" "$STAGE/Misc/" || true

	# Summary
	echo "Staged counts:"
	for d in TTF OTF TTC Type1 PCF BDF Misc doc; do
		printf "  %-6s : " "$d"
		find "$STAGE/$d" -type f | wc -l
	done

	# Location of your staging root (mirror of /usr/share/fonts under staging)
	STAGE="/sources/Makefonts/fonts"
	# Bins to process (others are left alone)
	BINS=("TTF" "OTF" "Type1")
	OUT="./group-fonts.pl"

	cat > "$OUT" <<'PERL'
#!/usr/bin/perl
	use strict;
	use warnings;
	use File::Basename;
	use File::Copy;

	# Usage: ./group-fonts.pl /sources/Makefonts/fonts [TTF OTF Type1 ...]
	my $STAGE = shift(@ARGV) // "/sources/Makefonts/fonts";
	my @BINS  = @ARGV ? @ARGV : qw(TTF OTF Type1);

	# Files we consider per bin
	my $PAT = qr/\.(ttf|otf|pfb|pfa|afm|pfm)\z/i;

	sub pre_token {
		my ($name) = @_;
		$name =~ s/$PAT//;          # drop extension
		$name =~ s/[-\[].*$//;      # keep before first '-' or '['
		return $name;
	}

	sub camel_boundaries {
		my ($s) = @_;
		$s =~ s/_+//g;
		my @idx = (0);
		for (my $i = 1; $i < length($s); $i++) {
			my $p = substr($s, $i-1, 1);
			my $c = substr($s, $i,   1);
			# boundary on lower/digit -> Upper
			if ($p =~ /[a-z0-9]/ && $c =~ /[A-Z]/) { push @idx, $i; }
		}
		return @idx;
	}

	# Candidate roots are successive prefixes at CamelCase boundaries + full pre-token
	sub candidates_for {
		my ($pre) = @_;
		my @cuts = camel_boundaries($pre);
		my %seen; my @cand;
		for my $i (@cuts) {
			my $p = substr($pre, 0, $i);
			next if $p eq '';
			next if $seen{$p}++;
			push @cand, $p;
		}
		push @cand, $pre unless $seen{$pre}++;
		return @cand;
	}

	# Pick the longest candidate for this base whose global count >= 2
	sub pick_root {
		my ($base, $counts) = @_;
		my $pre = pre_token($base);
		# If no '-' or '[', likely a simple name; still allow CamelCase-based grouping:
		# we keep it eligible by not early-returning here.
		my @cand = candidates_for($pre);
		my @ok   = grep { ($counts->{$_} // 0) >= 2 } @cand;
		return undef unless @ok;
		@ok = sort { length($b) <=> length($a) || $a cmp $b } @ok;
		return $ok[0];
	}

	for my $bin (@BINS) {
		my $dir = "$STAGE/$bin";
		next unless -d $dir;

		opendir(my $dh, $dir) or next;
		my @files = grep { -f "$dir/$_" && /$PAT/ } readdir($dh);
		closedir($dh);

		my %counts;        # candidate_root -> count
		my %bases;         # base_without_ext -> filename
		my %pre_by_base;   # cache pre_token per base

		# Pass 1: count all candidate roots seen in this bin
		for my $f (@files) {
			(my $base = $f) =~ s/$PAT//;
			$bases{$base} = $f;

			my $pre = pre_token($base);
			$pre_by_base{$base} = $pre;

			for my $cand (candidates_for($pre)) {
				$counts{$cand}++;
			}
		}

		# Pass 2: decide root for each base from global counts (longest qualifying)
		my %root_for;      # base -> chosen root
		for my $base (keys %bases) {
			my $root = pick_root($base, \%counts);
			next unless defined $root;
			$root_for{$base} = $root;
		}

		# Form groups: only create a directory if a root has >= 2 members
		my %root_members;  # root -> [bases...]
		for my $base (keys %root_for) {
			push @{ $root_members{ $root_for{$base} } }, $base;
		}

		for my $root (keys %root_members) {
			next unless @{ $root_members{$root} } >= 2;
			my $target = "$dir/$root";
			mkdir $target unless -d $target;

			# Move immediate files whose pre-token starts with this root
			opendir(my $d2, $dir) or next;
			my @binfiles = grep { -f "$dir/$_" } readdir($d2);
			closedir($d2);

			for my $f (@binfiles) {
				(my $base = $f) =~ s/$PAT//;
				my $pre = $pre_by_base{$base};
				$pre = pre_token($base) unless defined $pre;

				next unless defined $pre;
				next unless index($pre, $root) == 0;

				move("$dir/$f", "$target/$f") or warn "move $f -> $target: $!";
			}
		}

		# Bin summary
		opendir(my $d3, $dir) or next;
		my @top = sort grep { $_ ne '.' && $_ ne '..' } readdir($d3);
		closedir($d3);
		print "== $bin ==\n";
		print join("\n", @top), "\n\n";
	}
PERL

	chmod +x "$OUT"
	# Run in place against your staging root/bins
	"./$OUT" "$STAGE" "${BINS[@]}"
	find "$STAGE" -depth -type d -empty -print -delete

	# Normalize ownership and permissions in staging
	chown -vhR root:root "$STAGE"
	find "$STAGE" -type d -exec chmod -v 0755 {} +
	find "$STAGE" -type f -exec chmod -v 0644 {} +

	# Quick counts for review
	echo "Dirs:  $(find "$STAGE" -type d | wc -l)"
	echo "Files: $(find "$STAGE" -type f | wc -l)"

	rm -rf /usr/share/fonts
	install -d -m 0755 /usr/share/fonts
	cp -va /sources/Makefonts/fonts/. /usr/share/fonts/

#	cd /usr/share/fonts/
#	/bin/bash

	install -d -m 0755 /var/cache/fontconfig

	echoL "Cleaning up external Fonts..."
	cd /sources
	rm -fR /sources/Makefonts  # clean up indemendent fonts

	echoL "Downloading Xorg Fonts..."
	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	cd /sources
	rm -fR Xfonts
	mkdir Xfonts
	cd Xfonts

	cat > Xfonts.md5 << "EOF"
a6541d12ceba004c0c1e3df900324642  font-util-1.4.1.tar.xz
a56b1a7f2c14173f71f010225fa131f1  encodings-1.1.0.tar.xz
79f4c023e27d1db1dfd90d041ce89835  font-alias-1.0.5.tar.xz
546d17feab30d4e3abcf332b454f58ed  font-adobe-utopia-type1-1.0.5.tar.xz
063bfa1456c8a68208bf96a33f472bb1  font-bh-ttf-1.0.4.tar.xz
51a17c981275439b85e15430a3d711ee  font-bh-type1-1.0.4.tar.xz
00f64a84b6c9886040241e081347a853  font-ibm-type1-1.0.4.tar.xz
fe972eaf13176fa9aa7e74a12ecc801a  font-misc-ethiopic-1.0.5.tar.xz
3b47fed2c032af3a32aad9acc1d25150  font-xfree86-type1-1.0.5.tar.xz
EOF

	while read -r checksum filename; do
		# strip archive extension
		basename="${filename%.tar.*}"
		# get display name: everything before last '-' and everything after
		name_part="${basename%-*}"
		ver_part="${basename##*-}"
		display_name="${name_part} (${ver_part})"

		echoL "Downloading $display_name..."
		sleep 2
		cd "/root/lfs/B-05-Xorg Libraries and Mesa"
		../bash/Download.sh  https://www.x.org/pub/individual/font/$filename $filename
		cp ../Packages/$filename /sources
		cd /sources/Xfonts
		cp ../$filename .

		echoL "Verfiying $display_name..."
		sleep 2
		
		got="$(md5sum "$filename" | awk '{print $1}')"
		if [[ "$got" == "$checksum" ]]; then
			echo "OK  $filename"
		else
			echo "FAIL  $filename (expected $checksum, got $got)"
			/bin/bash
		fi

		echoL "Unpack $display_name..."
		sleep 2

		cd /sources/Xfonts
		rm -fR $basename
		tar -vxsf $filename
		cd $basename

		echoL "Configuring $display_name..."
		sleep 2

		# I left the case statment in case something changs later.
		# packagedir=${package%.tar.?z*} replaced by $basename
		docdir="--docdir=$XORG_PREFIX/share/doc/$basename"
		install_mode=0
		case $basename in #was $packagedir
			* )
				./configure $XORG_CONFIG $docdir
				install_mode=1
			;;
		esac
		
		echoL "Building $display_name..."
		sleep 2
		case "$install_mode" in
			1)
				make
			;;
			*)
				echo "Build system fail."
				/bin/bash
			;;
		esac

		echoL "Testing $display_name..."
		sleep 2
		case "$install_mode" in
			1)
				make check
			;;
			*)
				echo "Build system fail."
				/bin/bash
			;;
		esac

		echoL "Installing $display_name..."
		sleep 2
		case "$install_mode" in
			1)
				make install
			;;
			*)
				echo "Build system fail."
				/bin/bash
			;;
		esac
		rm -f $XORG_PREFIX/bin/xkeystone

		# cleanup.
		echoL "Cleaning up $display_name..."
		sleep 2
		cd /sources/Xfonts
		rm -fR $basename

	done < <(grep -v '^#' Xfonts.md5)
	fc-cache -f
	fc-list

	echoL "Finished Fonts"
	sleep 2

	cd /sources
	rm -fR Xfonts
	echoL "Exiting..."
	sleep 2
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
