FROM python:3.11-slim

# システムパッケージ
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    unzip \
    fonts-noto-cjk \
    iputils-ping \
    net-tools \
    curl \
    locales \
    tzdata \
    procps \
    && rm -rf /var/lib/apt/lists/*

# --- requirements.txtをコピー ---
COPY requirements.txt /tmp/requirements.txt

# --- Pythonパッケージをインストール ---
RUN pip install --upgrade pip \
    && pip install -r /tmp/requirements.txt \
    && rm -rf /root/.cache/pip 


# ワーキングディレクトリ
WORKDIR /workspace

# Jupyter起動用
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--ServerApp.token=''","--ServerApp.password=''","--ServerApp.quit_button=False"]

