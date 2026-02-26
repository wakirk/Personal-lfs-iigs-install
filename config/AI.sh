#!/bin/bash
###############################################################################
# AI.sh — ComfyUI Installer & Launcher for CachyOS
#
# IRON RULE: Everything lives under ~/AI/ except NVIDIA driver & basic tools.
# --nuke wipes everything except ~/AI/workspaces/ and restarts fresh.
#
# Tick system: each completed step drops a file in ~/AI/.ticks/
# On re-run, skips completed steps and resumes where it left off.
###############################################################################

# ~/AI/
# ├── cuda/                 # CUDA Toolkit 13.0 (nvcc, headers, libs)
# ├── python/               # Standalone Python 3.13 (or symlink to system)
# ├── ComfyUI/
# │   ├── .venv/            # Python venv — PyTorch, all deps live here
# │   ├── models/           # Checkpoints, LoRAs, etc.
# │   ├── custom_nodes/
# │   └── ...
# ├── .ticks/
# │   ├── 01_cuda_toolkit        # CUDA 13.0 installed to ~/AI/cuda/
# │   ├── 02_python              # Python 3.13 installed to ~/AI/python/
# │   ├── 03_comfyui_clone       # ComfyUI repo cloned
# │   ├── 04_comfyui_venv        # venv created with CUDA_HOME wired up
# │   ├── 05_pytorch             # PyTorch cu130 installed in venv
# │   ├── 06_comfyui_deps        # ComfyUI requirements.txt installed
# │   ├── 07_flash_attn          # flash-attn compiled & installed
# │   ├── 08_sageattention       # SageAttention compiled & installed
# │   ├── 09_triton              # Triton installed
# │   ├── 10_custom_nodes        # Custom nodes installed
# │   ├── 11_models              # Models downloaded/linked
# │   └── 12_verified            # Smoke test passed
# ├── ACE-Step-1.5/         # (later, ACE.sh territory)
# │   └── .venv/            # Its own venv
# ├── AI.sh                 # ComfyUI installer/launcher
# ├── ACE.sh                # ACE installer/launcher (later)
# └── workspaces/           # Your saved work (survives --nuke)

# 12 functions, called in sequence from main():
# Step	Function	                What it does
# 01	install_cuda_toolkit    	Downloads & installs CUDA 13.0 to ~/AI/cuda/ (no root)
# 02	install_python	            Builds Python 3.13.2 from source to ~/AI/python/
# 03	install_comfyui_clone    	Clones ComfyUI repo
# 04	install_comfyui_venv	    Creates venv, wires CUDA_HOME into activation
# 05	install_pytorch	Installs    PyTorch cu130 via pip
# 06	install_comfyui_deps	    Installs ComfyUI's requirements.txt
# 07	install_flash_attn	        Compiles flash-attn against our CUDA
# 08	install_sageattention	    Compiles SageAttention against our CUDA
# 09	install_triton	            Installs Triton
# 10	install_custom_nodes	    Clones ComfyUI-Manager + installs node deps
# 11	install_models	            Creates model directory structure
# 12	install_verify	            Smoke test — imports everything, checks CUDA

set -euo pipefail

# ─── Configuration ───────────────────────────────────────────────────────────
AI_HOME="$HOME/AI"
TICKS_DIR="$AI_HOME/.ticks"
WORKSPACES_DIR="$AI_HOME/workspaces"

CUDA_VERSION="13.0"
CUDA_RUNFILE_URL="https://developer.download.nvidia.com/compute/cuda/13.0.0/local_installers/cuda_13.0.0_575.51.03_linux.run"
CUDA_RUNFILE="cuda_13.0.0_575.51.03_linux.run"
CUDA_DIR="$AI_HOME/cuda"

PYTHON_VERSION="3.13.2"
PYTHON_URL="https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz"
PYTHON_DIR="$AI_HOME/python"
PYTHON_BIN="$PYTHON_DIR/bin/python3"

COMFYUI_DIR="$AI_HOME/ComfyUI"
COMFYUI_REPO="https://github.com/comfyanonymous/ComfyUI.git"
COMFYUI_VENV="$COMFYUI_DIR/.venv"

PYTORCH_INDEX="https://download.pytorch.org/whl/cu130"

# ─── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ─── Helpers ─────────────────────────────────────────────────────────────────
info()  { echo -e "${CYAN}[INFO]${NC} $*"; }
ok()    { echo -e "${GREEN}[OK]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
die()   { echo -e "${RED}[FATAL]${NC} $*"; exit 1; }

tick_exists() { [[ -f "$TICKS_DIR/$1" ]]; }
drop_tick()   { mkdir -p "$TICKS_DIR" && touch "$TICKS_DIR/$1" && ok "Tick: $1"; }

# ─── Nuke ────────────────────────────────────────────────────────────────────
nuke() {
    warn "NUKE MODE: Wiping everything under $AI_HOME EXCEPT workspaces/"
    echo ""
    echo "This will delete:"
    echo "  - $CUDA_DIR"
    echo "  - $PYTHON_DIR"
    echo "  - $COMFYUI_DIR"
    echo "  - $TICKS_DIR"
    echo "  - All other files/dirs under $AI_HOME"
    echo ""
    echo "PRESERVED: $WORKSPACES_DIR"
    echo ""
    read -rp "Type YES to confirm: " confirm
    [[ "$confirm" == "YES" ]] || { info "Nuke cancelled."; exit 0; }

    # Copy ourselves out before we delete our own home
    local self_script="$(realpath "$0")"
    local tmp_dir="$(mktemp -d)"
    cp "$self_script" "$tmp_dir/AI.sh"

    # Move workspaces out temporarily
    local tmp_ws=""
    if [[ -d "$WORKSPACES_DIR" ]]; then
        mv "$WORKSPACES_DIR" "$tmp_dir/workspaces"
    fi

    # Wipe everything
    rm -rf "$AI_HOME"
    mkdir -p "$AI_HOME"

    # Restore workspaces
    if [[ -d "$tmp_dir/workspaces" ]]; then
        mv "$tmp_dir/workspaces" "$WORKSPACES_DIR"
    fi

    # Restore ourselves
    cp "$tmp_dir/AI.sh" "$AI_HOME/AI.sh"
    chmod +x "$AI_HOME/AI.sh"
    rm -rf "$tmp_dir"

    ok "Nuke complete. Run AI.sh again to reinstall."
    exit 0
}

# ─── Step 01: CUDA Toolkit ──────────────────────────────────────────────────
install_cuda_toolkit() {
    if tick_exists "01_cuda_toolkit"; then return; fi
    info "Step 01: Installing CUDA Toolkit $CUDA_VERSION to $CUDA_DIR"

    mkdir -p "$AI_HOME/downloads"
    local runfile="$AI_HOME/downloads/$CUDA_RUNFILE"

    if [[ ! -f "$runfile" ]]; then
        info "Downloading CUDA Toolkit runfile..."
        wget -O "$runfile" "$CUDA_RUNFILE_URL" || die "Failed to download CUDA runfile"
    fi

    chmod +x "$runfile"
    info "Installing CUDA Toolkit (no root, toolkit only)..."
    "$runfile" --silent --toolkit --toolkitpath="$CUDA_DIR" --defaultroot="$CUDA_DIR" \
        || die "CUDA Toolkit installation failed"

    # Verify nvcc exists
    [[ -x "$CUDA_DIR/bin/nvcc" ]] || die "nvcc not found after install"
    info "nvcc version: $($CUDA_DIR/bin/nvcc --version | tail -1)"

    drop_tick "01_cuda_toolkit"
}

# ─── Step 02: Python ────────────────────────────────────────────────────────
install_python() {
    if tick_exists "02_python"; then return; fi
    info "Step 02: Building Python $PYTHON_VERSION to $PYTHON_DIR"

    mkdir -p "$AI_HOME/downloads"
    local tarball="$AI_HOME/downloads/Python-${PYTHON_VERSION}.tar.xz"
    local srcdir="$AI_HOME/downloads/Python-${PYTHON_VERSION}"

    if [[ ! -f "$tarball" ]]; then
        info "Downloading Python $PYTHON_VERSION..."
        wget -O "$tarball" "$PYTHON_URL" || die "Failed to download Python"
    fi

    info "Extracting..."
    cd "$AI_HOME/downloads"
    tar xf "$tarball"

    info "Configuring..."
    cd "$srcdir"
    ./configure --prefix="$PYTHON_DIR" --enable-optimizations --with-lto \
        --with-ensurepip=install 2>&1 | tail -5

    info "Building (this takes a few minutes)..."
    make -j"$(nproc)" 2>&1 | tail -3
    make install 2>&1 | tail -3

    # Verify
    [[ -x "$PYTHON_BIN" ]] || die "Python binary not found after install"
    info "Python version: $($PYTHON_BIN --version)"

    # Upgrade pip
    "$PYTHON_BIN" -m pip install --upgrade pip 2>&1 | tail -1

    drop_tick "02_python"
}

# ─── Step 03: Clone ComfyUI ─────────────────────────────────────────────────
install_comfyui_clone() {
    if tick_exists "03_comfyui_clone"; then return; fi
    info "Step 03: Cloning ComfyUI"

    git clone "$COMFYUI_REPO" "$COMFYUI_DIR" || die "Failed to clone ComfyUI"

    drop_tick "03_comfyui_clone"
}

# ─── Step 04: Create venv ───────────────────────────────────────────────────
install_comfyui_venv() {
    if tick_exists "04_comfyui_venv"; then return; fi
    info "Step 04: Creating ComfyUI venv with CUDA_HOME wired up"

    "$PYTHON_BIN" -m venv "$COMFYUI_VENV" || die "Failed to create venv"

    # Wire CUDA_HOME into venv activation script
    local activate="$COMFYUI_VENV/bin/activate"
    cat >> "$activate" << 'CUDA_ENV'

# ── AI.sh: CUDA environment ──
export CUDA_HOME="$HOME/AI/cuda"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:${LD_LIBRARY_PATH:-}"
CUDA_ENV

    # Verify
    source "$activate"
    info "CUDA_HOME=$CUDA_HOME"
    info "venv python: $(which python3)"

    drop_tick "04_comfyui_venv"
}

# ─── Step 05: PyTorch ────────────────────────────────────────────────────────
install_pytorch() {
    if tick_exists "05_pytorch"; then return; fi
    info "Step 05: Installing PyTorch cu130"

    source "$COMFYUI_VENV/bin/activate"

    pip install torch torchvision torchaudio --index-url "$PYTORCH_INDEX" \
        || die "Failed to install PyTorch"

    # Verify CUDA is available
    python3 -c "import torch; assert torch.cuda.is_available(), 'CUDA not available'; print(f'PyTorch {torch.__version__}, CUDA {torch.version.cuda}')" \
        || die "PyTorch CUDA verification failed"

    drop_tick "05_pytorch"
}

# ─── Step 06: ComfyUI deps ──────────────────────────────────────────────────
install_comfyui_deps() {
    if tick_exists "06_comfyui_deps"; then return; fi
    info "Step 06: Installing ComfyUI requirements"

    source "$COMFYUI_VENV/bin/activate"
    cd "$COMFYUI_DIR"

    pip install -r requirements.txt || die "Failed to install ComfyUI requirements"

    drop_tick "06_comfyui_deps"
}

# ─── Step 07: flash-attn ────────────────────────────────────────────────────
install_flash_attn() {
    if tick_exists "07_flash_attn"; then return; fi
    info "Step 07: Compiling flash-attn (this takes a while)"

    source "$COMFYUI_VENV/bin/activate"

    # Ensure CUDA_HOME is set (should be from venv activation)
    [[ -x "$CUDA_HOME/bin/nvcc" ]] || die "CUDA_HOME/bin/nvcc not found — CUDA_HOME=$CUDA_HOME"

    pip install flash-attn --no-build-isolation || die "Failed to install flash-attn"

    python3 -c "import flash_attn; print(f'flash-attn {flash_attn.__version__}')" \
        || die "flash-attn import failed"

    drop_tick "07_flash_attn"
}

# ─── Step 08: SageAttention ─────────────────────────────────────────────────
install_sageattention() {
    if tick_exists "08_sageattention"; then return; fi
    info "Step 08: Installing SageAttention"

    source "$COMFYUI_VENV/bin/activate"

    pip install sageattention --no-build-isolation || die "Failed to install SageAttention"

    python3 -c "import sageattention; print('SageAttention OK')" \
        || die "SageAttention import failed"

    drop_tick "08_sageattention"
}

# ─── Step 09: Triton ────────────────────────────────────────────────────────
install_triton() {
    if tick_exists "09_triton"; then return; fi
    info "Step 09: Installing Triton"

    source "$COMFYUI_VENV/bin/activate"

    pip install triton || die "Failed to install Triton"

    python3 -c "import triton; print(f'Triton {triton.__version__}')" \
        || die "Triton import failed"

    drop_tick "09_triton"
}

# ─── Step 10: Custom Nodes ──────────────────────────────────────────────────
install_custom_nodes() {
    if tick_exists "10_custom_nodes"; then return; fi
    info "Step 10: Installing custom nodes"

    source "$COMFYUI_VENV/bin/activate"
    local nodes_dir="$COMFYUI_DIR/custom_nodes"
    mkdir -p "$nodes_dir"

    # ComfyUI Manager
    if [[ ! -d "$nodes_dir/ComfyUI-Manager" ]]; then
        git clone https://github.com/ltdrdata/ComfyUI-Manager.git "$nodes_dir/ComfyUI-Manager"
    fi

    # Install any requirements from custom nodes
    for req in "$nodes_dir"/*/requirements.txt; do
        if [[ -f "$req" ]]; then
            info "Installing deps for $(dirname "$req" | xargs basename)"
            pip install -r "$req" || warn "Some deps failed for $req"
        fi
    done

    drop_tick "10_custom_nodes"
}

# ─── Step 11: Models ────────────────────────────────────────────────────────
install_models() {
    if tick_exists "11_models"; then return; fi
    info "Step 11: Setting up models directory"

    # Create standard model directories
    local models_dir="$COMFYUI_DIR/models"
    mkdir -p "$models_dir"/{checkpoints,clip,clip_vision,controlnet,diffusers,embeddings}
    mkdir -p "$models_dir"/{gligen,hypernetworks,loras,style_models,unet,upscale_models,vae}

    # TODO: Add model downloads here as needed
    # For now, just ensure the directory structure exists
    info "Model directories created. Add models manually or extend this step."

    drop_tick "11_models"
}

# ─── Step 12: Verify ────────────────────────────────────────────────────────
install_verify() {
    if tick_exists "12_verified"; then return; fi
    info "Step 12: Running smoke test"

    source "$COMFYUI_VENV/bin/activate"
    cd "$COMFYUI_DIR"

    # Check all critical imports
    python3 << 'SMOKE_TEST'
import sys
errors = []

try:
    import torch
    assert torch.cuda.is_available(), "CUDA not available"
    print(f"  PyTorch {torch.__version__} | CUDA {torch.version.cuda} | GPU: {torch.cuda.get_device_name(0)}")
except Exception as e:
    errors.append(f"PyTorch: {e}")

try:
    import flash_attn
    print(f"  flash-attn {flash_attn.__version__}")
except Exception as e:
    errors.append(f"flash-attn: {e}")

try:
    import sageattention
    print("  SageAttention OK")
except Exception as e:
    errors.append(f"SageAttention: {e}")

try:
    import triton
    print(f"  Triton {triton.__version__}")
except Exception as e:
    errors.append(f"Triton: {e}")

if errors:
    print("\nFAILED checks:")
    for e in errors:
        print(f"  ✗ {e}")
    sys.exit(1)
else:
    print("\n  All checks passed ✓")
SMOKE_TEST

    [[ $? -eq 0 ]] || die "Smoke test failed"

    drop_tick "12_verified"
}

# ─── Run ComfyUI ─────────────────────────────────────────────────────────────
run_comfyui() {
    info "Starting ComfyUI..."
    source "$COMFYUI_VENV/bin/activate"
    cd "$COMFYUI_DIR"
    python3 main.py --listen 0.0.0.0 --port 8188 "$@"
}

# ─── Main ────────────────────────────────────────────────────────────────────
main() {
    echo ""
    echo "============================================"
    echo "  AI.sh — ComfyUI Installer & Launcher"
    echo "  Everything under ~/AI/ — sealed box."
    echo "============================================"
    echo ""

    # Handle --nuke
    if [[ "${1:-}" == "--nuke" ]]; then
        nuke
    fi

    # Ensure base dirs exist
    mkdir -p "$AI_HOME" "$TICKS_DIR" "$WORKSPACES_DIR"

    # Run install steps in sequence
    install_cuda_toolkit
    install_python
    install_comfyui_clone
    install_comfyui_venv
    install_pytorch
    install_comfyui_deps
    install_flash_attn
    install_sageattention
    install_triton
    install_custom_nodes
    install_models
    install_verify

    echo ""
    ok "All 12 steps complete. Launching ComfyUI..."
    echo ""

    # Pass any remaining args to ComfyUI (skip --nuke if present)
    run_comfyui "$@"
}

main "$@"
