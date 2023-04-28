FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
        curl \
        jq

ENV OPENAI_API_KEY TBD

COPY create-image.sh /usr/local/bin