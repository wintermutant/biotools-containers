FROM python:3.10-slim

LABEL org.opencontainers.image.source=https://github.com/wintermutant/biotools-containers
LABEL org.opencontainers.image.description="run_dbCAN - CAZyme annotation tool (no database)"
LABEL org.opencontainers.image.licenses=MIT

# Install system dependencies
RUN apt-get update && apt-get install -y \
    hmmer \
    diamond-aligner \
    prodigal \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install run_dbcan via pip
RUN pip install --no-cache-dir dbcan

WORKDIR /data

ENTRYPOINT ["run_dbcan"]
CMD ["--help"]
