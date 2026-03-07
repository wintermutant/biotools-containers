# KOfam Scan Container

This container packages KOfam Scan with the complete KOfam database for KEGG Orthology assignment.

## What's Included

- KOfam Scan tool (from https://github.com/takaram/kofam_scan)
- Complete KOfam database (profiles + ko_list)
- All dependencies (Ruby, HMMER, GNU Parallel)
- Pre-configured config.yml

## Building the Container

### Local build (single architecture)
```bash
docker build -t kofam_scan:latest .
```

### Multi-architecture build (for GHCR)
```bash
# First, create buildx builder
docker buildx create --use --name multiarch

# Build and push
./build.sh v1.0
```

## Using the Container

### With Docker
```bash
docker run --rm -v $(pwd):/data kofam_scan:latest exec_annotation -o result.txt input.fasta
```

### With Apptainer/Singularity
```bash
# Pull from GHCR
apptainer pull kofam_scan.sif docker://ghcr.io/wintermutant/kofam_scan:latest

# Run
apptainer exec kofam_scan.sif exec_annotation -o result.txt input.fasta
```

### With Snakemake

Add to your Snakefile:

```python
rule kofam_scan:
    input:
        "input.fasta"
    output:
        "output/kofam_results.txt"
    container:
        "docker://ghcr.io/wintermutant/kofam_scan:latest"
    shell:
        """
        exec_annotation -o {output} {input}
        """
```

Then run with:
```bash
snakemake --use-apptainer
```

## Container Details

- **Database location**: `/opt/kofam_scan/db/`
- **Config file**: `/opt/kofam_scan/config.yml`
- **Working directory**: `/data` (mount your data here)
- **Default CPUs**: 4 (can override with `-c` flag in exec_annotation)

## Advanced Usage

### Override CPU count
```bash
apptainer exec kofam_scan.sif exec_annotation -c 8 -o result.txt input.fasta
```

### Use custom options
```bash
apptainer exec kofam_scan.sif exec_annotation \
  -f detail-tsv \
  -o result.txt \
  input.fasta
```

## Database Version

The database is downloaded during build from:
- ftp://ftp.genome.jp/pub/db/kofam/

To rebuild with an updated database, simply rebuild the container.

## Size Warning

This container is large (~2-3GB) because it includes the complete KOfam database. The initial pull/build will take time.
