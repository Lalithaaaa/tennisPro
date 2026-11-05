#!/bin/bash
set -euo pipefail
GROUP=${1:?usage: bash setup.sh <group>}
ROOT=/blue/$GROUP/$USER/tennis
mkdir -p "$ROOT/logs" "$ROOT/results"
cd "$ROOT"

if ! command -v uv >/dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH=$HOME/.local/bin:$PATH
fi

uv venv -q .venv
uv pip install -q -p .venv torch torchvision --index-url https://download.pytorch.org/whl/cu128
uv pip install -q -p .venv "numpy<2" "opencv-python-headless<5" PyYAML catboost scipy "onnx<1.18" onnxscript onnxruntime ultralytics lap

echo "ok: $ROOT"
