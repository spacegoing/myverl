set -euo pipefail

apt-get install -y python3.10-dev libpython3.10 libpython3.10-dev

uv venv
source .venv/bin/activate

uv pip install torch==2.4.0 --index-url https://download.pytorch.org/whl/cu124
uv pip install -U pip setuptools wheel packaging psutil
uv pip install flash-attn --no-build-isolation
uv pip install -e .

# ------------- Megatron --------------
uv pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings '"--build-option=--cpp_ext"' --config-settings '"--build-option=--cuda_ext"' \
   git+https://github.com/NVIDIA/apex
uv pip install \
   git+https://github.com/NVIDIA/TransformerEngine.git@stable

# In China github banned
# (
#     mkdir mydeps && cd mydeps && \
#         git clone --depth 1 https://github.com/NVIDIA/apex && \
#         git clone --depth 1 --branch stable https://github.com/NVIDIA/TransformerEngine && \
#         cd TransformerEngine && git submodule update --init --recursive
# )
# uv pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings '"--build-option=--cpp_ext"' --config-settings '"--build-option=--cuda_ext"' \
#    ./mydeps/apex
# uv pip install \
#    ./mydeps/TransformerEngine --no-build-isolation

uv pip install megatron-core==0.11.0
