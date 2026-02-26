~/AI/
├── python/               # Standalone Python 3.13 (or symlink to system)
├── ComfyUI/
│   ├── .venv/            # Python venv — PyTorch, all deps live here
│   ├── models/           # Checkpoints, LoRAs, etc.
│   ├── custom_nodes/
│   └── ...
├── ACE-Step-1.5/         # (later, ACE.sh territory)
│   └── .venv/            # Its own venv
├── AI.sh                 # ComfyUI installer/launcher
├── ACE.sh                # ACE installer/launcher (later)
└── workspaces/           # Your saved work (survives --nuke)
