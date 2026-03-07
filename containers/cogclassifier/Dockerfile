FROM python:3.11-slim

ARG TARGETARCH
ARG BLAST_VERSION=2.16.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

RUN if [ "$TARGETARCH" = "arm64" ]; then \
        BLAST_ARCH="aarch64"; \
    else \
        BLAST_ARCH="x64"; \
    fi && \
    wget -qO- "https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${BLAST_VERSION}/ncbi-blast-${BLAST_VERSION}+-${BLAST_ARCH}-linux.tar.gz" \
    | tar xz -C /opt && \
    ln -s /opt/ncbi-blast-${BLAST_VERSION}+/bin/* /usr/local/bin/

RUN pip install --no-cache-dir cogclassifier

ENTRYPOINT ["COGclassifier"]
