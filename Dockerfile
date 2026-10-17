FROM nvcr.io/nvidia/pytorch:26.09-py3

WORKDIR /opt/meshy-src
COPY . .

RUN apt update && apt install python3-venv python3-dev build-essential \
    && python3 -m venv /opt/meshy \
    && source /opt/meshy/bin/activate \
    && git clone https://github.com/sgl-project/sglang.git \
    && cd sglang/ \
    && ./scripts/ci/utils/install_rustup.sh \
    && export PATH=/root/.cargo/bin:$PATH \
    && pip install --upgrade pip \
    && pip install -e "python" \
    && pip install torchtitan==0.3.0 \
    && pip install TransferQueue==0.1.9 --no-deps \
    && cd /opt/meshy-src \
    && pip install -e .
