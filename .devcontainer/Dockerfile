FROM mcr.microsoft.com/devcontainers/cpp:1-ubuntu-24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        less \
        python3 \
        python3-pip \
        python3-venv \
        tree \
        vim \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/course-requirements.txt

RUN python3 -m venv /opt/course-venv \
    && /opt/course-venv/bin/python -m pip install --no-cache-dir --upgrade pip \
    && /opt/course-venv/bin/python -m pip install --no-cache-dir -r /tmp/course-requirements.txt

ENV PATH="/opt/course-venv/bin:${PATH}"
