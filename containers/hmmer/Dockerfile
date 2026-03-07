FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz && \
    tar xzf hmmer-3.4.tar.gz && \
    cd hmmer-3.4 && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && \
    make install

FROM debian:bookworm-slim

LABEL org.opencontainers.image.source=https://github.com/wintermutant/biotools-containers
LABEL org.opencontainers.image.description="HMMER - Lightweight container for Hidden Markov Models"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /usr/local/bin/hmm* /usr/local/bin/
COPY --from=builder /usr/local/bin/alimask /usr/local/bin/

WORKDIR /data
