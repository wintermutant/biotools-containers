FROM eclipse-temurin:17-jre-alpine

LABEL org.opencontainers.image.source=https://github.com/wintermutant/biotools-containers
LABEL org.opencontainers.image.description="PIR PeptideMatch - Peptide sequence matching against protein databases"
LABEL org.opencontainers.image.licenses=GPL-3.0

RUN apk add --no-cache wget

RUN wget -q -O /opt/PeptideMatchCMD.jar \
    https://proteininformationresource.org/download/peptide_match/PeptideMatchCMD_1.1.jar

WORKDIR /data

ENTRYPOINT ["java", "-jar", "/opt/PeptideMatchCMD.jar"]
