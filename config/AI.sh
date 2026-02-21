#!/bin/bash

set -euo pipefail

#set -x

#1.7B Model
#all 3 models:
#    Base
#    Voice Design
#    Custom Voice
#
#UI Interface  "Comfy UI"  (with repo for Quent3 control)
Startup_check() {
    # --- PREFLIGHT: Ensure Python 3.13, git, curl are available ---
    if [ -f ~/AI/.preflight.complete ]; then
        # Still need to export PYTHON_BIN for this session
        if command -v python3.13 &> /dev/null; then
            export PYTHON_BIN="python3.13"
        elif command -v python3.12 &> /dev/null; then
            export PYTHON_BIN="python3.12"
        else
            export PYTHON_BIN="python3"
        fi
        return
    fi

    echo ">>> Running startup checks..."

    # Install git and curl if missing
    for pkg in git curl; do
        if ! command -v "$pkg" &> /dev/null; then
            echo ">>> Installing $pkg..."
            sudo pacman -S --noconfirm "$pkg"
        fi
    done

    # Find or install suitable Python (3.13 preferred, 3.12 fallback)
    if command -v python3.13 &> /dev/null; then
        export PYTHON_BIN="python3.13"
    elif command -v python3.12 &> /dev/null; then
        export PYTHON_BIN="python3.12"
    else
        # Check if system python3 is 3.12 or 3.13
        if command -v python3 &> /dev/null; then
            PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.minor}')")
            if [[ "$PY_VER" == "12" || "$PY_VER" == "13" ]]; then
                export PYTHON_BIN="python3"
            fi
        fi
    fi

    # If still no suitable Python, install python313 from AUR
    if [ -z "${PYTHON_BIN:-}" ]; then
        echo ">>> No Python 3.12/3.13 found. Installing python313 from AUR..."
        if command -v paru &> /dev/null; then
            paru -S --noconfirm python313
        elif command -v yay &> /dev/null; then
            yay -S --noconfirm python313
        else
            echo "ERROR: No AUR helper (paru/yay) found. Install python313 manually."
            exit 1
        fi
        export PYTHON_BIN="python3.13"
    fi

    # Verify venv module works
    if ! "$PYTHON_BIN" -m venv --help &> /dev/null; then
        echo "ERROR: $PYTHON_BIN is missing the venv module."
        sudo pacman -S python-virtualenv
    fi

    echo ">>> Preflight OK: $PYTHON_BIN ($($PYTHON_BIN --version))"
    touch ~/AI/.preflight.complete
}

select_gpu_target() {
    # --- GPU TARGET: NVIDIA / AMD / CPU ---
    if [ -f ~/AI/.gpu_target ]; then
        export GPU_TARGET=$(cat ~/AI/.gpu_target)
        echo ">>> GPU target already set: $GPU_TARGET"
        return
    fi

    echo -e "\n\e[1;34m======================================\e[0m"
    echo -e "\e[1;32m       SELECT YOUR GPU TARGET          \e[0m"
    echo -e "\e[1;34m======================================\e[0m"
    echo -e "  \e[1m1\e[0m) NVIDIA  (CUDA 13.0)"
    echo -e "  \e[1m2\e[0m) AMD     (ROCm 6.4)"
    echo -e "  \e[1m3\e[0m) CPU only (no GPU)"
    echo -e "\e[1;34m======================================\e[0m"

    while true; do
        read -rp "  Choice [1/2/3]: " gpu_choice
        case "$gpu_choice" in
            1)
                export GPU_TARGET="cuda"
                echo "cuda" > ~/AI/.gpu_target
                echo ">>> Set: NVIDIA (CUDA 13.0)"
                break
                ;;
            2)
                export GPU_TARGET="rocm"
                echo "rocm" > ~/AI/.gpu_target
                echo ">>> Set: AMD (ROCm 6.4)"
                break
                ;;
            3)
                export GPU_TARGET="cpu"
                echo "cpu" > ~/AI/.gpu_target
                echo ">>> Set: CPU only"
                break
                ;;
            *)
                echo ">>> Invalid choice. Enter 1, 2, or 3."
                ;;
        esac
    done
}

install_ComfyUI() {
    # Check if the hidden marker file exists to skip installation
    if [ -f ~/AI/.comfyui.installed ]; then
        echo "ComfyUI already installed. Skipping to launch..."
        return
    fi

    # Source:
    # https://github.com/Comfy-Org/ComfyUI
    # --- AI STUDIO BUILD LOG: CACHYOS VM TEST ---
    # 1. TOP-LEVEL DIRECTORY CREATED: ~/AI
    # 2. MODEL WAREHOUSE SKELETON BUILT: ~/AI/models/{checkpoints,qwen3_tts,music}
    # 3. OUTPUT DIRECTORY INITIALIZED: ~/AI/outputs
    # 4. COMFYUI ENGINE CLONED: ~/AI/ComfyUI (Source: Comfy-Org/ComfyUI)
    # 5. PYTHON SANDBOX CREATED: ~/AI/ComfyUI/venv (Python 3.12)
    # 6. ENVIRONMENT ACTIVATED & PIP UPDATED
    # 7. STATUS: CLEAN INSTALL BASE - NO AI LIBRARIES INSTALLED YET
    # --------------------------------------------

    mkdir -p ~/AI/models/{checkpoints,qwen3_tts,music}
    mkdir -p ~/AI/outputs
    cd ~/AI
    git clone https://github.com/Comfy-Org/ComfyUI.git
    cd ComfyUI

    "$PYTHON_BIN" -m venv venv
    source venv/bin/activate
    pip install -U pip

    # INSTALL STEP 1: PYTORCH (CUDA 13.0 - NVIDIA GPU SUPPORT)
    # - Installs torch, torchvision, torchaudio with CUDA 13.0 bindings
    # - In VM: This will install but won't use GPU (testing install process only)
    # - On bare metal: Requires NVIDIA drivers compatible with CUDA 13.0+
    # INSTALL STEP 1: PYTORCH (ROCm 6.2 - AMD GPU SUPPORT)
    # - Installs torch with AMD ROCm bindings
    # - This is what allows CachyOS to use your AMD GPU for AI
    case "$GPU_TARGET" in
        cuda)
            pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
            ;;
        rocm)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.4
            ;;
        cpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
            ;;
    esac

    # INSTALL STEP 2: COMFYUI CORE DEPENDENCIES
    # - Installs all base requirements for ComfyUI engine
    # - Includes: diffusers, transformers, accelerate, safetensors, etc.
    # - This is where most dependency conflicts will surface if they exist
    pip install -r requirements.txt

    # INSTALL STEP 3: COMFYUI-MANAGER DEPENDENCIES
    # - Installs extension manager for custom nodes (Voice, Music, Image generators)
    # - Allows one-click install of additional AI systems from the UI
    # - Required to enable manager with: python main.py --enable-manager
    # Guard: manager_requirements.txt may not exist in all versions
    if [ -f manager_requirements.txt ]; then
        pip install -r manager_requirements.txt
    else
        echo ">>> manager_requirements.txt not found, skipping (manager will self-install deps)"
    fi

     # Create the marker file so we don't re-install next time
     touch ~/AI/.comfyui.installed
}

configure_model_paths() {
    # --- STAGE: CONFIGURE MODEL PATHS ---
    # Creates extra_model_paths.yaml to point ComfyUI at ~/AI/models warehouse
    if [ -f ~/AI/.model_paths_configured ]; then
        return
    fi

    echo ">>> Configuring ComfyUI model paths..."

    # Get the actual username (in case script is run with sudo)
    ACTUAL_USER=$(whoami)
    MODEL_BASE_PATH="/home/${ACTUAL_USER}/AI/models"

    # Create the config file
    cat > ~/AI/ComfyUI/extra_model_paths.yaml <<EOF
# ComfyUI Extra Model Paths Configuration
# Auto-generated by AI.sh installer

comfyui:
    base_path: ${MODEL_BASE_PATH}/
    checkpoints: checkpoints/
    vae: vae/
    loras: loras/
    upscale_models: upscale_models/
    controlnet: controlnet/
    embeddings: embeddings/
    clip: clip/
    clip_vision: clip_vision/
    style_models: style_models/
    diffusers: diffusers/
    unet: unet/

qwen-tts: ${MODEL_BASE_PATH}/qwen3_tts
EOF

    # Create any missing model subdirectories
    mkdir -p ~/AI/models/{vae,loras,upscale_models,controlnet,embeddings,clip,clip_vision,style_models,diffusers,unet}

    touch ~/AI/.model_paths_configured
    echo ">>> Model paths configured successfully."
}

HFqwen317bBase() {
    # Source: https://huggingface.co/Qwen/Qwen3-TTS-12Hz-1.7B-Base
    if [ -f ~/AI/.HFqwen317bBase.complete ]; then
        return
    fi

    source ~/AI/ComfyUI/venv/bin/activate
    pip install -U huggingface_hub

    python - << 'EOF'
import os
from huggingface_hub import snapshot_download

base = os.path.expanduser("~/AI/models/qwen3_tts")
os.makedirs(base, exist_ok=True)

snapshot_download(
    repo_id="Qwen/Qwen3-TTS-12Hz-1.7B-Base",
    local_dir=os.path.join(base, "Qwen/Qwen3-TTS-12Hz-1.7B-Base"),
    local_dir_use_symlinks=False
)
EOF

    touch ~/AI/.HFqwen317bBase.complete
}

HFqwen317bVoiceDesign() {
    # Source: https://huggingface.co/Qwen/Qwen3-TTS-12Hz-1.7B-VoiceDesign
    if [ -f ~/AI/.HFqwen317bVoiceDesign.complete ]; then
        return
    fi

    source ~/AI/ComfyUI/venv/bin/activate

    python - << 'EOF'
import os
from huggingface_hub import snapshot_download

base = os.path.expanduser("~/AI/models/qwen3_tts")

snapshot_download(
    repo_id="Qwen/Qwen3-TTS-12Hz-1.7B-VoiceDesign",
    local_dir=os.path.join(base, "Qwen/Qwen3-TTS-12Hz-1.7B-VoiceDesign"),
    local_dir_use_symlinks=False
)
EOF

    touch ~/AI/.HFqwen317bVoiceDesign.complete
}

HFqwen317bCustomVoice() {
    # Source: https://huggingface.co/Qwen/Qwen3-TTS-12Hz-1.7B-CustomVoice
    if [ -f ~/AI/.HFqwen317bCustomVoice.complete ]; then
        return
    fi

    source ~/AI/ComfyUI/venv/bin/activate

    python - << 'EOF'
import os
from huggingface_hub import snapshot_download

base = os.path.expanduser("~/AI/models/qwen3_tts")

snapshot_download(
    repo_id="Qwen/Qwen3-TTS-12Hz-1.7B-CustomVoice",
    local_dir=os.path.join(base, "Qwen/Qwen3-TTS-12Hz-1.7B-CustomVoice"),
    local_dir_use_symlinks=False
)
EOF

    touch ~/AI/.HFqwen317bCustomVoice.complete
}

GHqwen31ComfyUI() {
    if [ -f ~/AI/.GHqwen31ComfyUI.complete ]; then
        return
    fi

    cd ~/AI/ComfyUI/custom_nodes
    git clone https://github.com/DarioFT/ComfyUI-Qwen3-TTS.git
    cd ComfyUI-Qwen3-TTS
    source ../../venv/bin/activate
    pip install -r requirements.txt

    touch ~/AI/.GHqwen31ComfyUI.complete
}

show_model_guide() {
    echo -e "\n\e[1;34m----------------------------------------------------------------------\e[0m"
    echo -e "\e[1;32m  AI STUDIO MODEL PLACEMENT GUIDE (Civitai Reference) \e[0m"
    echo -e "\e[1;34m----------------------------------------------------------------------\e[0m"
    echo -e "  \e[1mFILE TYPE\e[0m          |  \e[1mEXTENSION\e[0m        |  \e[1mDIRECTORY PATH\e[0m"
    echo -e "  -------------------|-------------------|----------------------------"
    echo -e "  \e[33mCheckpoints\e[0m        |  .safetensors     |  ~/AI/models/checkpoints/"
    echo -e "  \e[33mLoRAs\e[0m              |  .safetensors     |  ~/AI/models/loras/"
    echo -e "  \e[33mVAEs\e[0m               |  .safetensors     |  ~/AI/models/vae/"
    echo -e "  \e[33mControlNets\e[0m        |  .safetensors     |  ~/AI/models/controlnet/"
    echo -e "  \e[33mEmbeddings\e[0m         |  .pt / .bin       |  ~/AI/models/embeddings/"
    echo -e "  \e[33mUpscalers\e[0m          |  .pth / .bin      |  ~/AI/models/upscale_models/"
    echo -e "  ----------------------------------------------------------------------"
    echo -e "  \e[1mModel Source:\e[0m      https://civitai.com/models"
    echo -e "\e[1;34m----------------------------------------------------------------------\e[0m\n"
}

HFqwen3Tokenizer() {
    # Source: https://huggingface.co/Qwen/Qwen3-TTS-Tokenizer-12Hz
    if [ -f ~/AI/.HFqwen3Tokenizer.complete ]; then
        return
    fi

    source ~/AI/ComfyUI/venv/bin/activate

    python - << 'EOF'
import os
from huggingface_hub import snapshot_download

base = os.path.expanduser("~/AI/models/qwen3_tts")

snapshot_download(
    repo_id="Qwen/Qwen3-TTS-Tokenizer-12Hz",
    local_dir=os.path.join(base, "Qwen/Qwen3-TTS-Tokenizer-12Hz"),
    local_dir_use_symlinks=False
)
EOF

    touch ~/AI/.HFqwen3Tokenizer.complete
}

ACEStep15() {
    # Source: https://github.com/ace-step/ACE-Step-1.5
    if [ -f ~/AI/.ACEStep15.installed ]; then
        return
    fi

    # Ensure uv is installed
    if ! command -v uv &> /dev/null; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
        source ~/.local/bin/env
    fi

    cd ~/AI
    git clone https://github.com/ace-step/ACE-Step-1.5.git
    cd ACE-Step-1.5
    uv sync

    touch ~/AI/.ACEStep15.installed
}

launch_menu() {
    # Read GPU target for launch flags
    local gpu_flag=""
    if [ -f ~/AI/.gpu_target ]; then
        local target=$(cat ~/AI/.gpu_target)
        if [ "$target" = "cpu" ]; then
            gpu_flag="--cpu"
        fi
        # cuda and rocm: no flag needed, PyTorch handles it
    fi

    while true; do
        echo -e "\n\e[1;34m======================================\e[0m"
        echo -e "\e[1;32m        AI STUDIO LAUNCHER             \e[0m"
        echo -e "\e[1;34m======================================\e[0m"
        echo -e "  \e[1m1\e[0m) ComfyUI (Voice + Image)"
        echo -e "  \e[1m2\e[0m) ACE-Step 1.5 (Music)"
        echo -e "  \e[1mx\e[0m) Exit"
        echo -e "\e[1;34m======================================\e[0m"
        read -rp "  Choice: " choice

        case "$choice" in
            1)
                echo -e "\e[1;32m>>> Launching ComfyUI...\e[0m"
                cd ~/AI/ComfyUI
                source venv/bin/activate
                python main.py --enable-manager $gpu_flag || true
                echo -e "\e[1;33m>>> ComfyUI stopped. Returning to menu...\e[0m"
                ;;
            2)
                echo -e "\e[1;32m>>> Launching ACE-Step 1.5...\e[0m"
                cd ~/AI/ACE-Step-1.5
                uv run acestep || true
                echo -e "\e[1;33m>>> ACE-Step stopped. Returning to menu...\e[0m"
                ;;
            x|X)
                echo -e "\e[1;32m>>> Goodbye!\e[0m"
                exit 0
                ;;
            *)
                echo -e "\e[1;31m>>> Invalid choice. Try again.\e[0m"
                ;;
        esac
    done
}

main
    # --- EXECUTION FLOW ---

    # 1. Run the install function (will skip if .installed exists)
    preflight_check
    select_gpu_target
    install_ComfyUI

#   configure_model_paths

    # GitHub first (UI code)
#    GHqwen31ComfyUI

    # Then the Tokenizer (Critical Dependency)
#    HFqwen3Tokenizer

    # Then the 1.7B Models
#    HFqwen317bBase
#    HFqwen317bVoiceDesign
#    HFqwen317bCustomVoice
#    ACEStep15

    # 2. Enter the directory and activate the environment for launch
    cd ~/AI/ComfyUI
    source venv/bin/activate

    # 3. Launch ComfyUI with the Manager enabled
    # Note: Use --cpu flag here if the VM crashes on GPU detection
    # python main.py --enable-manager     # Will run Nvidia.
    echo "Model source site:    https://civitai.com/models"
    echo "Model rankings site:  https://imgsys.org/"
    echo "Tutorial: https://www.youtube.com/watch?v=g74Cq9Ip2ik"
    echo "Voice:    https://www.youtube.com/watch?v=eC8mZceIy5k"

    show_model_guide
#    python main.py --enable-manager --cpu
    launch_menu

    #Command Line Options
    #   Flag         Description
    #   --enable-manager
    #                Enable ComfyUI-Manager
    #   --enable-manager-legacy-ui
    #               Use the legacy manager UI instead of the new UI (requires --enable-manager)
    #   --disable-manager-ui
    #               Disable the manager UI and endpoints while keeping background features like
    #               security checks and scheduled installation completion (requires --enable-manager)
}

main

