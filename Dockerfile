FROM ubuntu:jammy

ARG BUILD_DATE
ARG VCS_REF

ENV BEDROCK_VERSION=1.21.84.1

LABEL maintainer="Dean Holland <speedster@haveacry.com>" \
      bedrock_version=$BEDROCK_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Haveacry/docker-bedrock" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$BEDROCK_VERSION

RUN apt-get update && \
    apt-get install -y unzip curl libcurl4 && \
    curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.2792.65" https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-$BEDROCK_VERSION.zip --output bedrock-server.zip && \
    unzip bedrock-server.zip -d bedrock-server && \
    rm bedrock-server.zip && \
    chmod +x /bedrock-server/bedrock_server

WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=.
CMD ./bedrock_server
