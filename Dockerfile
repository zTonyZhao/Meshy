FROM nvcr.io/nvidia/pytorch:26.09-py3

WORKDIR /opt/meshy-src
COPY . .

RUN apt update && apt install python3-venv python3-dev build-essential \
    && python3 -m venv /opt/meshy \
    && source /opt/meshy/bin/activate \
    && pip install --upgrade pip \
    && pip install sglang==0.5.22 \
    && pip install torchtitan==0.3.0 \
    && pip install TransferQueue==0.1.9 --no-deps \
    && pip install -e .
