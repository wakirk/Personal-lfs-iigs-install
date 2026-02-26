~/AI/
├── cuda/                 # CUDA Toolkit 13.0 (nvcc, headers, libs)
├── python/               # Standalone Python 3.13 (or symlink to system)
├── ComfyUI/
│   ├── .venv/            # Python venv — PyTorch, all deps live here
│   ├── models/           # Checkpoints, LoRAs, etc.
│   ├── custom_nodes/
│   └── ...
├── .ticks/
│   ├── 01_cuda_toolkit        # CUDA 13.0 installed to ~/AI/cuda/
│   ├── 02_python              # Python 3.13 installed to ~/AI/python/
│   ├── 03_comfyui_clone       # ComfyUI repo cloned
│   ├── 04_comfyui_venv        # venv created with CUDA_HOME wired up
│   ├── 05_pytorch             # PyTorch cu130 installed in venv
│   ├── 06_comfyui_deps        # ComfyUI requirements.txt installed
│   ├── 07_flash_attn          # flash-attn compiled & installed
│   ├── 08_sageattention       # SageAttention compiled & installed
│   ├── 09_triton              # Triton installed
│   ├── 10_custom_nodes        # Custom nodes installed
│   ├── 11_models              # Models downloaded/linked
│   └── 12_verified            # Smoke test passed
├── ACE-Step-1.5/         # (later, ACE.sh territory)
│   └── .venv/            # Its own venv
├── AI.sh                 # ComfyUI installer/launcher
├── ACE.sh                # ACE installer/launcher (later)
└── workspaces/           # Your saved work (survives --nuke)

