#!/bin/bash
#SBATCH --job-name=tennis-clip
#SBATCH --partition=hpg-turin
#SBATCH --gpus=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32gb
#SBATCH --time=02:00:00
#SBATCH --output=logs/%x-%j.out

set -euo pipefail
cd "$SLURM_SUBMIT_DIR"
VIDEO=${1:-samples/clip_1m-4m_sdr.mp4}
OUT=results/$(basename "$VIDEO" .mp4)
mkdir -p "$OUT" logs

nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
PY=.venv/bin/python
export PYTHONPATH=$PWD/tennisvision

time $PY -u tennisvision/scripts/extract_ball_positions.py \
  --video "$VIDEO" --out "$OUT/ball_positions.json" \
  --weights weights/wasb_tennis_best.pth.tar --device cuda

time $PY -u tennisvision/scripts/detect_players.py \
  --video "$VIDEO" --out "$OUT/player_detections.json"
