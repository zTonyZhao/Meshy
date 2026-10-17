FROM nvcr.io/nvidia/pytorch:26.09-py3
ARG DEBIAN_FRONTEND=noninteractive
ARG SGLANG_VERSION=0.5.18
ENV VIRTUAL_ENV=/opt/meshy PATH=/opt/meshy/bin:$PATH PIP_DISABLE_PIP_VERSION_CHECK=1 PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /workspace/meshy
RUN apt-get update && apt-get install -y --no-install-recommends git python3-dev python3-venv && rm -rf /var/lib/apt/lists/* && python3 -m venv "$VIRTUAL_ENV" && pip install --upgrade pip
COPY third_party/torchtitan-*.whl /tmp/
RUN pip install "sglang==${SGLANG_VERSION}" && pip install /tmp/torchtitan-*.whl && pip install "TransferQueue==0.1.9" --no-deps && rm -f /tmp/torchtitan-*.whl
COPY . .
RUN pip install --no-cache-dir -e .
ENTRYPOINT ["python"]
CMD ["-c", "import meshy; print('Meshy environment is ready')"]

