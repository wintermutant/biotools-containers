FROM ubuntu:22.04

LABEL org.opencontainers.image.source=https://github.com/wintermutant/biotools-containers
LABEL org.opencontainers.image.description="KOfam Scan - KEGG Orthology assignment tool"
LABEL org.opencontainers.image.licenses=MIT

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ruby \
    ruby-dev \
    parallel \
    wget \
    gzip \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install HMMER from source
RUN wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz && \
    tar xzf hmmer-3.4.tar.gz && \
    cd hmmer-3.4 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd .. && \
    rm -rf hmmer-3.4 hmmer-3.4.tar.gz

# Verify versions
RUN ruby --version && hmmsearch -h | head -2 && parallel --version | head -1

# Set up working directory
WORKDIR /opt

# Clone kofam_scan repository
RUN git clone https://github.com/wintermutant/kofam_scan_bsp && \
    cd kofam_scan_bsp && \
    chmod +x exec_annotation

# Set working directory to where users will mount their data
WORKDIR /data

# Add kofam_scan_bsp to PATH
ENV PATH="/opt/kofam_scan_bsp:${PATH}"

# Set default command to show help
CMD ["exec_annotation", "--help"]
