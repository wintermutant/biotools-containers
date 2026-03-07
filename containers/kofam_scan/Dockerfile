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
RUN git clone https://github.com/takaram/kofam_scan.git && \
    cd kofam_scan && \
    chmod +x exec_annotation

# Download KOfam database
WORKDIR /opt/kofam_scan
RUN echo "Downloading KOfam database (this will take a while)..." && \
    mkdir -p db && \
    cd db && \
    wget -q --show-progress ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz && \
    wget -q --show-progress ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz && \
    echo "Extracting database..." && \
    tar xzf profiles.tar.gz && \
    gunzip ko_list.gz && \
    rm profiles.tar.gz && \
    echo "Database download complete"

# Create config.yml
RUN cat > /opt/kofam_scan/config.yml << 'EOF'
# Path to profile database
profile: /opt/kofam_scan/db/profiles

# Path to KO list
ko_list: /opt/kofam_scan/db/ko_list

# Path to hmmsearch executable
hmmsearch: /usr/bin/hmmsearch

# Path to GNU parallel
parallel: /usr/bin/parallel

# Number of CPUs to use (can be overridden at runtime)
cpu: 4

# Temporary directory
tmp_dir: /tmp
EOF

# Set working directory to where users will mount their data
WORKDIR /data

# Add kofam_scan to PATH
ENV PATH="/opt/kofam_scan:${PATH}"

# Set default command to show help
CMD ["exec_annotation", "--help"]
