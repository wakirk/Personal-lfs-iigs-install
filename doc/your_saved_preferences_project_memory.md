## What I currently remember (you can edit inline)
_Last updated: 2025-10-16_

1. **Project focus**: You’re building a custom LFS/BLFS system for the IIgs Linux‑from‑Scratch Build on a retro “C64‑style” PC.
2. **Code style prefs**:
   - Prefer explicit, readable code.
   - For Bash: use `source` instead of `.`, avoid punctuation‑golf/one‑liners.
   - Keep initialization blocks verbose with comments.
   - Make the smallest necessary changes that preserve your style.
3. **Output & refactor prefs**:
   - Don’t silence output or hide errors by default.
   - Avoid unsolicited refactors or “cleanup.”
   - Preserve existing paths/tooling (e.g., Batch over PowerShell, `D:\LFS`, `%~dp0`).
   - If correctness requires a change, explain why and show a concise change log and (when applicable) a unified diff.
   - Do not change or introduce shell options (e.g., `set -e`, `set -u`, `set -o pipefail`) unless explicitly asked.
4. **Review modes** (match your ask):
   - Basic check — “does this work at all?”
   - Critical issues only — “any critical issues?”
   - Improvements — “any improvements?”
5. **Shebang preference**: Always keep `#!/bin/bash` in scripts; don’t suggest changing it.
6. **LFS progress snapshot** (historical): binutils complete; GCC building (from 2025‑09‑28).
7. **Guidance style**: No promises; careful breakdowns; step‑by‑step diagnosis and fixes.
8. **Interaction style**: Wait for explicit direction before acting—no jumping ahead.
9. **LFS install paths & build norms**:
	- Do not propose `/usr/local` or `/opt` for system packages; use `/usr` (LFS style).
    - Configs in `/etc`; state in `/var`.
    - OpenSSL configure: `./Configure --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared`.
    - Prefer autotools where available
	- Be explicit about inside-vs-outside chroot, if unsure, ask.
    - Don’t assume `pkg-config`; pass explicit flags if needed.
    - Flag any build that defaults to `/usr/local` and keep paths consistent with LFS.
10. **Code creation rules**
    - Follow Code creation precisely; don’t introduce unasked-for features (guards, “protections”) unless requested.
    - If a request doesn’t make sense (e.g., “remove a directory with `cd`”), pause and ask for clarification.