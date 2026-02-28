#!/bin/bash

Version="Version 2.0"
echo "$Version"

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
# ├── cuda/                 # CUDA Toolkit 12.8 (nvcc, headers, libs)
# ├── python/               # Standalone Python 3.13.2
# ├── ComfyUI/
# │   ├── .venv/            # Python venv — PyTorch 2.9.1 cu128, all deps
# │   ├── models/           # Checkpoints, LoRAs, etc.
# │   ├── custom_nodes/
# │   └── ...
# ├── ComfyUI/qwen3-tts-env/  # Isolated venv for Qwen3-TTS (transformers 4.57.3)
# ├── .ticks/
# │   ├── 01_cuda_toolkit        # CUDA 12.8 installed to ~/AI/cuda/
# │   ├── 02_python              # Python 3.13.2 installed to ~/AI/python/
# │   ├── 03_comfyui_clone       # ComfyUI repo cloned & pinned to v0.15.1
# │   ├── 04_comfyui_venv        # venv created with CUDA_HOME wired up
# │   ├── 05_pytorch             # PyTorch 2.9.1 cu128 installed in venv
# │   ├── 06_comfyui_deps        # ComfyUI requirements.txt installed
# │   ├── 07_aifc_sunau          # standard-aifc 3.13.0 + standard-sunau 3.13.0
# │   ├── 08_numba_shim          # numba shim (no-op decorators for librosa)
# │   ├── 09                     # (removed — real numba broken on Python 3.13)
# │   ├── 10_librosa             # librosa 0.11.0
# │   ├── 11_soxr                # soxr 1.0.0
# │   ├── 12_flash_attn          # flash-attn 2.8.3 (prebuilt wheel)
# │   ├── 13_comfyui_app         # ComfyUI 0.15.1 verified
# │   ├── 14_comfy_env           # comfy-env installed
# │   ├── 15_transformers        # transformers (ComfyUI default)
# │   ├── 16_transformers_qwen   # transformers 4.57.3 (Qwen3-TTS isolated)
# │   ├── 17_models              # Model directory structure created
# │   └── 18_verified            # Full smoke test passed
# ├── ACE-Step-1.5/         # (later, ACE.sh territory)
# │   └── .venv/            # Its own venv
# ├── AI.sh                 # ComfyUI installer/launcher
# ├── ACE.sh                # ACE installer/launcher (later)
# └── workspaces/           # Your saved work (survives --nuke)

# 18 functions, called in sequence from main():
# Step  Function                    What it does
# 01    install_cuda_toolkit        Downloads & installs CUDA 12.8 to ~/AI/cuda/ (no root)
# 02    install_python              Builds Python 3.13.2 from source to ~/AI/python/
# 03    install_comfyui_clone       Clones ComfyUI repo, pins to v0.15.1
# 04    install_comfyui_venv        Creates venv, wires CUDA_HOME into activation
# 05    install_pytorch             Installs PyTorch 2.9.1 cu128 via pip
# 06    install_comfyui_deps        Installs ComfyUI's requirements.txt
# 07    install_aifc_sunau          Installs standard-aifc 3.13.0 + standard-sunau 3.13.0
# 08    install_numba_shim          Installs numba shim (no-op decorators for librosa)
# 09    (removed)                   Real numba 0.64.0 broken on Python 3.13
# 10    install_librosa             Installs librosa 0.11.0
# 11    install_soxr                Installs soxr 1.0.0
# 12    install_flash_attn          Installs flash-attn 2.8.3 (prebuilt wheel)
# 13    install_comfyui_app         Verifies ComfyUI 0.15.1 is ready
# 14    install_comfy_env           Installs comfy-env
# 15    install_transformers        Verifies transformers (ComfyUI default from deps)
# 16    install_transformers_qwen   Installs transformers 4.57.3 in isolated Qwen3-TTS venv
# 17    install_models              Creates model directory structure
# 18    install_verify              Full smoke test — imports everything, checks CUDA

set -euo pipefail

# ─── Configuration ───────────────────────────────────────────────────────────
AI_HOME="$HOME/AI"
TICKS_DIR="$AI_HOME/.ticks"
WORKSPACES_DIR="$AI_HOME/workspaces"

CUDA_VERSION="12.8"
CUDA_RUNFILE_URL="https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda_12.8.0_570.86.10_linux.run"
CUDA_RUNFILE="cuda_12.8.0_570.86.10_linux.run"
CUDA_DIR="$AI_HOME/cuda"

PYTHON_VERSION="3.13.2"
PYTHON_URL="https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz"
PYTHON_DIR="$AI_HOME/python"
PYTHON_BIN="$PYTHON_DIR/bin/python3"

COMFYUI_DIR="$AI_HOME/ComfyUI"
COMFYUI_REPO="https://github.com/comfyanonymous/ComfyUI.git"
COMFYUI_TAG="v0.15.1"
COMFYUI_VENV="$COMFYUI_DIR/.venv"

QWEN_VENV="$COMFYUI_DIR/qwen3-tts-env"

PYTORCH_INDEX="https://download.pytorch.org/whl/cu128"

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
    warn "NUKE MODE: Removing only what AI.sh created"
    echo ""
    echo "This will delete:"
    echo "  - $CUDA_DIR          (CUDA Toolkit)"
    echo "  - $PYTHON_DIR        (Python)"
    echo "  - $COMFYUI_DIR       (ComfyUI + venv + Qwen3-TTS venv)"
    echo "  - $AI_HOME/downloads (downloaded archives)"
    echo "  - $TICKS_DIR         (tick files)"
    echo ""
    echo "PRESERVED:"
    echo "  - $WORKSPACES_DIR"
    echo "  - $AI_HOME/AI.sh     (this script)"
    echo ""
    read -rp "Type YES to confirm: " confirm
    [[ "$confirm" == "YES" ]] || { info "Nuke cancelled."; exit 0; }

    # Only remove what we know we created
    rm -rf "$CUDA_DIR"
    rm -rf "$PYTHON_DIR"
    rm -rf "$COMFYUI_DIR"
    rm -rf "$AI_HOME/downloads"
    rm -rf "$TICKS_DIR"

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
    "$runfile" --silent --no-man-page --override --toolkit --toolkitpath="$CUDA_DIR" --defaultroot="$CUDA_DIR" \
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
        --with-ensurepip=install

    info "Building (this takes a few minutes)..."
    make -j4
    make install

    # Verify
    [[ -x "$PYTHON_BIN" ]] || die "Python binary not found after install"
    info "Python version: $($PYTHON_BIN --version)"

    # Upgrade pip
    "$PYTHON_BIN" -m pip install --upgrade pip

    drop_tick "02_python"
}

# ─── Step 03: Clone ComfyUI ─────────────────────────────────────────────────
install_comfyui_clone() {
    if tick_exists "03_comfyui_clone"; then return; fi
    info "Step 03: Cloning ComfyUI and pinning to $COMFYUI_TAG"

    git clone "$COMFYUI_REPO" "$COMFYUI_DIR" || die "Failed to clone ComfyUI"

    cd "$COMFYUI_DIR"
    git checkout "$COMFYUI_TAG" || die "Failed to checkout $COMFYUI_TAG"
    info "ComfyUI pinned to $(git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD)"

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
    info "Step 05: Installing PyTorch 2.9.1 cu128"

    source "$COMFYUI_VENV/bin/activate"

    pip install torch==2.9.1 torchvision torchaudio --index-url "$PYTORCH_INDEX" \
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

# ─── Step 07: standard-aifc + standard-sunau ─────────────────────────────────
install_aifc_sunau() {
    if tick_exists "07_aifc_sunau"; then return; fi
    info "Step 07: Installing standard-aifc 3.13.0 + standard-sunau 3.13.0"

    source "$COMFYUI_VENV/bin/activate"

    pip install standard-aifc==3.13.0 || die "Failed to install standard-aifc"
    pip install standard-sunau==3.13.0 || die "Failed to install standard-sunau"

    python3 -c "import aifc; print('standard-aifc OK')" || die "standard-aifc import failed"
    python3 -c "import sunau; print('standard-sunau OK')" || die "standard-sunau import failed"

    drop_tick "07_aifc_sunau"
}

# ─── Step 08: llvmlite ───────────────────────────────────────────────────────
#install_llvmlite() {
#    if tick_exists "08_llvmlite"; then return; fi
#    info "Step 08: Installing llvmlite 0.46.0"
#
#    source "$COMFYUI_VENV/bin/activate"
#
#    pip install llvmlite==0.46.0 || die "Failed to install llvmlite"
#
#    python3 -c "import llvmlite; print(f'llvmlite {llvmlite.__version__}')" \
#        || die "llvmlite import failed"
#
#    drop_tick "08_llvmlite"
#}

# ─── Step 09: numba ──────────────────────────────────────────────────────────
#install_numba() {
#    if tick_exists "09_numba"; then return; fi
#    info "Step 09: Installing numba 0.64.0"
#
#    source "$COMFYUI_VENV/bin/activate"
#
#    pip install numba==0.64.0 || die "Failed to install numba"
#
#    python3 -c "import numba; print(f'numba {numba.__version__}')" \
#        || die "numba import failed"
#
#    drop_tick "09_numba"
#}

# ─── Step 08: numba shim ────
# numba 0.64.0 has a Python 3.13 bug (@guvectorize broken).
# librosa hard-imports numba, so we provide a fake shim with no-op decorators.
# Actual resampling is handled by soxr — numba is never called.
install_numba_shim() {
    if tick_exists "08_numba_shim"; then return; fi
    info "Step 08: Installing numba shim (no-op decorators for librosa)"

    source "$COMFYUI_VENV/bin/activate"

    # Remove real numba/llvmlite if present
    pip uninstall numba llvmlite -y 2>/dev/null || true

    local shim_dir
    shim_dir="$(python3 -c 'import site; print(site.getsitepackages()[0])')/numba"
    mkdir -p "$shim_dir"

    cat > "$shim_dir/__init__.py" << 'SHIM'
"""Fake numba shim — provides no-op decorators so librosa imports cleanly.
librosa.resample() will fall back to soxr when JIT is unavailable."""

def jit(*args, **kwargs):
    if args and callable(args[0]):
        return args[0]
    def wrapper(fn):
        return fn
    return wrapper

def stencil(*args, **kwargs):
    if args and callable(args[0]):
        return args[0]
    def wrapper(fn):
        return fn
    return wrapper

def guvectorize(*args, **kwargs):
    if args and callable(args[0]):
        return args[0]
    def wrapper(fn):
        return fn
    return wrapper

def vectorize(*args, **kwargs):
    if args and callable(args[0]):
        return args[0]
    def wrapper(fn):
        return fn
    return wrapper
SHIM

    python3 -c "import numba; print('numba shim OK')" \
        || die "numba shim import failed"

    drop_tick "08_numba_shim"
}

# ─── Step 10: librosa ────────────────────────────────────────────────────────
install_librosa() {
    if tick_exists "10_librosa"; then return; fi
    info "Step 10: Installing librosa 0.11.0"

    source "$COMFYUI_VENV/bin/activate"

    pip install librosa==0.11.0 --no-deps || die "Failed to install librosa"

    python3 -c "import librosa; print(f'librosa {librosa.__version__}')" \
        || die "librosa import failed"

    drop_tick "10_librosa"
}

# ─── Step 11: soxr ───────────────────────────────────────────────────────────
install_soxr() {
    if tick_exists "11_soxr"; then return; fi
    info "Step 11: Installing soxr 1.0.0"

    source "$COMFYUI_VENV/bin/activate"

    pip install soxr==1.0.0 || die "Failed to install soxr"

    python3 -c "import soxr; print(f'soxr {soxr.__version__}')" \
        || die "soxr import failed"

    drop_tick "11_soxr"
}

# ─── Step 12: flash-attn ────────────────────────────────────────────────────
install_flash_attn() {
    if tick_exists "12_flash_attn"; then return; fi
    info "Step 12: Source build with gcc-14"

    source "$COMFYUI_VENV/bin/activate"

    # ── Clean build environment ──
    pip cache purge 2>/dev/null || true
    pip uninstall flash-attn -y 2>/dev/null || true

    # ── Patch glibc 2.41 vs CUDA 12.8 header mismatch ──
    # CachyOS glibc declares cospi/sinpi/rsqrt with noexcept(true)
    # but CUDA 12.8 math_functions.h does not — nvcc chokes on the conflict.
    # Line numbers are pinned to CUDA 12.8 runfile.
    local _mf="$CUDA_HOME/include/crt/math_functions.h"
    if [ -f "$_mf" ] && ! sed -n '597p' "$_mf" | grep -q 'noexcept(true)'; then
        info "Patching CUDA math_functions.h for glibc 2.41 compatibility"
        sed -i \
          -e '597s/);$/) noexcept(true);/' \
          -e '621s/);$/) noexcept(true);/' \
          -e '2556s/);$/) noexcept(true);/' \
          -e '2579s/);$/) noexcept(true);/' \
          -e '2601s/);$/) noexcept(true);/' \
          -e '2623s/);$/) noexcept(true);/' \
          "$_mf" || die "Failed to patch math_functions.h"
    fi

    # ── Build deps + compile ──
    pip install ninja packaging wheel setuptools || die "Failed to install flash-attn build deps"
    export NVCC_PREPEND_FLAGS="--compiler-bindir=/usr/bin/gcc-14"
    MAX_JOBS=1 pip install flash-attn==2.8.3 --no-build-isolation || die "Failed to install flash-attn"

    python3 -c "import flash_attn; print(f'flash-attn {flash_attn.__version__}')" \
        || die "flash-attn import failed"

    drop_tick "12_flash_attn"
}


# ─── Step 13: ComfyUI app verify ────────────────────────────────────────────
install_comfyui_app() {
    if tick_exists "13_comfyui_app"; then return; fi
    info "Step 13: Verifying ComfyUI 0.15.1 is ready"

    source "$COMFYUI_VENV/bin/activate"
    cd "$COMFYUI_DIR"

    # Verify we're on the right tag
    local current_tag
    current_tag=$(git describe --tags --exact-match 2>/dev/null || echo "unknown")
    info "ComfyUI tag: $current_tag"
    [[ "$current_tag" == "$COMFYUI_TAG" ]] || warn "Expected $COMFYUI_TAG but got $current_tag"

    # Quick import test
    python3 -c "import comfy; print('ComfyUI core import OK')" \
        || die "ComfyUI core import failed"

    drop_tick "13_comfyui_app"
}

# ─── Step 14: comfy-env ─────────────────────────────────────────────────────
install_comfy_env() {
    if tick_exists "14_comfy_env"; then return; fi
    info "Step 14: Installing comfy-env"

    source "$COMFYUI_VENV/bin/activate"

    pip install comfy-env || die "Failed to install comfy-env"

    python3 -c "import comfy_env; print('comfy-env OK')" \
        || die "comfy-env import failed"

    drop_tick "14_comfy_env"
}

# NEW CODE
# ─── Step 14b: comfyui-manager ──────────────────────────────────────────────
install_comfyui_manager() {
    if tick_exists "14b_comfyui_manager"; then return; fi
    info "Step 14b: Installing comfyui-manager"

    source "$COMFYUI_VENV/bin/activate"

    pip install --pre comfyui_manager || die "Failed to install comfyui-manager"

    drop_tick "14b_comfyui_manager"
}

# ─── Step 15: transformers (ComfyUI default) ────────────────────────────────
install_transformers() {
    if tick_exists "15_transformers"; then return; fi
    info "Step 15: Verifying transformers (ComfyUI default)"

    source "$COMFYUI_VENV/bin/activate"

    # transformers should already be installed via ComfyUI deps or we install it now
    pip install transformers || die "Failed to install transformers"

    python3 -c "import transformers; print(f'transformers {transformers.__version__}')" \
        || die "transformers import failed"

    drop_tick "15_transformers"
}

# ─── Step 16: transformers 4.57.3 (Qwen3-TTS isolated venv) ─────────────────
install_transformers_qwen() {
    if tick_exists "16_transformers_qwen"; then return; fi
    info "Step 16: Creating isolated Qwen3-TTS venv with transformers 4.57.3"

    # Create a separate venv for Qwen3-TTS
    "$PYTHON_BIN" -m venv "$QWEN_VENV" || die "Failed to create Qwen3-TTS venv"

    # Wire CUDA_HOME into Qwen venv activation script
    local activate="$QWEN_VENV/bin/activate"
    cat >> "$activate" << 'CUDA_ENV'

# ── AI.sh: CUDA environment (Qwen3-TTS) ──
export CUDA_HOME="$HOME/AI/cuda"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:${LD_LIBRARY_PATH:-}"
CUDA_ENV

    source "$activate"

    pip install --upgrade pip || die "Failed to upgrade pip in Qwen3-TTS venv"
    pip install torch==2.9.1 torchvision torchaudio --index-url "$PYTORCH_INDEX" \
        || die "Failed to install PyTorch in Qwen3-TTS venv"
    pip install transformers==4.57.3 || die "Failed to install transformers 4.57.3"

    python3 -c "import transformers; assert transformers.__version__ == '4.57.3', f'Got {transformers.__version__}'; print('transformers 4.57.3 OK')" \
        || die "transformers 4.57.3 verification failed"

    deactivate
    info "Qwen3-TTS isolated venv ready at $QWEN_VENV"

    drop_tick "16_transformers_qwen"
}

# ─── Step 17: Models ────────────────────────────────────────────────────────
install_models() {
    if tick_exists "17_models"; then return; fi
    info "Step 17: Setting up models directory"

    # Create standard model directories
    local models_dir="$COMFYUI_DIR/models"
    mkdir -p "$models_dir"/{checkpoints,clip,clip_vision,controlnet,diffusers,embeddings}
    mkdir -p "$models_dir"/{gligen,hypernetworks,loras,style_models,unet,upscale_models,vae}

    info "Model directories created. Add models manually or extend this step."

    drop_tick "17_models"
}

# ─── Step 18: Verify ────────────────────────────────────────────────────────
install_verify() {
    if tick_exists "18_verified"; then return; fi
    info "Step 18: Running full smoke test"

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
    import aifc
    print("  standard-aifc OK")
except Exception as e:
    errors.append(f"standard-aifc: {e}")

try:
    import sunau
    print("  standard-sunau OK")
except Exception as e:
    errors.append(f"standard-sunau: {e}")

try:
    import numba
    print("  numba shim OK")
except Exception as e:
    errors.append(f"numba shim: {e}")

try:
    import librosa
    print(f"  librosa {librosa.__version__}")
except Exception as e:
    errors.append(f"librosa: {e}")

try:
    import soxr
    print(f"  soxr {soxr.__version__}")
except Exception as e:
    errors.append(f"soxr: {e}")

try:
    import transformers
    print(f"  transformers {transformers.__version__}")
except Exception as e:
    errors.append(f"transformers: {e}")

try:
    import comfy
    print("  ComfyUI core OK")
except Exception as e:
    errors.append(f"ComfyUI: {e}")

try:
    import comfy_env
    print("  comfy-env OK")
except Exception as e:
    errors.append(f"comfy-env: {e}")

if errors:
    print("\nFAILED checks:")
    for e in errors:
        print(f"  ✗ {e}")
    sys.exit(1)
else:
    print("\n  All checks passed ✓")
SMOKE_TEST

    [[ $? -eq 0 ]] || die "Smoke test failed"

    # Also verify Qwen3-TTS venv
    info "Checking Qwen3-TTS isolated venv..."
    source "$QWEN_VENV/bin/activate"
    python3 -c "import transformers; assert transformers.__version__ == '4.57.3'; print(f'  Qwen3-TTS venv: transformers {transformers.__version__} ✓')" \
        || die "Qwen3-TTS venv verification failed"
    deactivate

    # Re-activate main venv for launch
    source "$COMFYUI_VENV/bin/activate"

    drop_tick "18_verified"
}

# ─── Run ComfyUI ─────────────────────────────────────────────────────────────
run_comfyui() {
    info "Starting ComfyUI..."
    source "$COMFYUI_VENV/bin/activate"
    cd "$COMFYUI_DIR"
    export NUMBA_DISABLE_JIT=1
    python3 main.py --listen 127.0.0.1 --port 8188 --enable-manager --use-flash-attention "$@"
}

# ─── Main ────────────────────────────────────────────────────────────────────
main() {
    echo ""
    echo "============================================"
    echo "  AI.sh v2.0 — ComfyUI Installer & Launcher"
    echo "  Everything under ~/AI/ — sealed box."
    echo "============================================"
    echo ""

    # Handle --nuke
    if [[ "${1:-}" == "--nuke" ]]; then
        nuke
    fi

    # Ensure base dirs exist
    mkdir -p "$AI_HOME" "$TICKS_DIR" "$WORKSPACES_DIR"

    # Run install steps in sequence (18 steps)
    install_cuda_toolkit        # 01 — CUDA 12.8
    install_python              # 02 — Python 3.13.2
    install_comfyui_clone       # 03 — ComfyUI 0.15.1 (pinned)
    install_comfyui_venv        # 04 — venv + CUDA_HOME
    install_pytorch             # 05 — PyTorch 2.9.1 cu128
    install_comfyui_deps        # 06 — ComfyUI requirements.txt
    install_aifc_sunau          # 07 — standard-aifc + standard-sunau
#    install_llvmlite            # 08 — llvmlite 0.46.0
#    install_numba               # 09 — numba 0.64.0
    install_numba_shim          # 08 — numba shim (no-op, soxr does resampling)
    install_librosa             # 10 — librosa 0.11.0
    install_soxr                # 11 — soxr 1.0.0
    install_flash_attn          # 12 — flash-attn 2.8.3 !!!
    install_comfyui_app         # 13 — ComfyUI verify
    install_comfy_env           # 14 — comfy-env
    install_comfyui_manager     # 14b — comfyui-manager   NEW CODE
    install_transformers        # 15 — transformers (default)
    install_transformers_qwen   # 16 — transformers 4.57.3 (Qwen3-TTS)
    install_models              # 17 — model directories
    install_verify              # 18 — full smoke test

    echo ""
    #ok "All 18 steps complete. Launching ComfyUI..."
    echo ""

    # Pass any remaining args to ComfyUI (skip --nuke if present)
    run_comfyui "$@"

}

main "$@"

exit 0

# Installer notes:
# sudo pacman -S libxml2
# sudo ln -s /usr/lib/libxml2.so.16 /usr/lib/libxml2.so.2
# sudo pacman -S gcc14
# https://github.com/Comfy-Org/ComfyUI
# https://github.com/QwenLM/Qwen3-TTS
# https://qwen.ai/blog?id=qwen3tts-0115
# https://github.com/wakirk/Personal-lfs-iigs-install
# https://apps.abacus.ai/chatllm/?appId=97fe78a64&convoId=b2d41fdc1
