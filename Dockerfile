FROM ubuntu:bionic

ARG BUILD_DATE
ARG VCS_REF

ENV BEDROCK_VERSION=1.19.21.01

LABEL maintainer="Dean Holland <speedster@haveacry.com>" \
      bedrock_version=$BEDROCK_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Haveacry/docker-bedrock" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$BEDROCK_VERSION

RUN apt-get update
RUN apt-get install -y unzip curl libcurl4 libssl1.1
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-$BEDROCK_VERSION.zip --output bedrock-server.zip
RUN unzip bedrock-server.zip -d bedrock-server
RUN rm bedrock-server.zip
RUN chmod +x /bedrock-server/bedrock_server

WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=.
CMD ./bedrock_server
