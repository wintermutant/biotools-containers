FROM python:3.10-slim

LABEL org.opencontainers.image.source=https://github.com/wintermutant/biotools-containers
LABEL org.opencontainers.image.description="pfam_scan - Pfam protein domain search (no database)"
LABEL org.opencontainers.image.licenses=MIT

# Install HMMER
RUN apt-get update && apt-get install -y \
    hmmer \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone pfam_scan
RUN git clone https://github.com/aziele/pfam_scan.git /opt/pfam_scan \
    && chmod +x /opt/pfam_scan/pfam_scan.py

ENV PATH="/opt/pfam_scan:${PATH}"

WORKDIR /data

CMD ["pfam_scan.py", "--help"]
