#!/bin/bash
set -euo pipefail
U=${1:?usage: bash push.sh <gatorlink> <group>}
GROUP=${2:?usage: bash push.sh <gatorlink> <group>}
HERE=$(cd "$(dirname "$0")" && pwd)
TV=$HOME/projects/tennisvision
DEST=$U@hpg.rc.ufl.edu:/blue/$GROUP/$U/tennis
export RSYNC_RSH="ssh -o ControlMaster=auto -o ControlPath=$HOME/.ssh/cm-%r@%h -o ControlPersist=10m"
sync() { rsync -az --mkpath --info=progress2 "$@"; }

sync --exclude={.venv,results,samples,weights,.git} "$TV/" "$DEST/tennisvision/"
sync "$TV/weights/wasb_tennis_best.pth.tar" "$DEST/weights/"
sync "$TV/samples/yt/clip_1m-4m_sdr.mp4" "$DEST/samples/"
sync "$HERE/setup.sh" "$HERE/run_clip.sbatch" "$DEST/"
