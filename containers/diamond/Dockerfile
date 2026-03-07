FROM condaforge/miniforge3:latest

 RUN conda install -y -c bioconda -c conda-forge diamond && conda clean -afy

 ENTRYPOINT ["diamond"]
