##################  for dev  #########################
FROM alpine:latest as builder

# config server
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV CORE_VERSION="1.20.62.02" \
  IMAGE_VERSION="1"
# unzip pack
RUN apk --no-cache add unzip wget && \
  mkdir -p $SERVER_PATH && \
  mkdir -p $DEFAULT_CONFIG_PATH && \
  wget -nv https://minecraft.azureedge.net/bin-linux/bedrock-server-$CORE_VERSION.zip -O /tmp/bedrock.zip
RUN unzip -q /tmp/bedrock.zip -d $SERVER_PATH && \
  rm -rf $SERVER_PATH/bedrock_server_symbols.debug && \
  mv $SERVER_PATH/permissions.json $DEFAULT_CONFIG_PATH/ && \
  mv $SERVER_PATH/server.properties $DEFAULT_CONFIG_PATH/ && \
  mv $SERVER_PATH/allowlist.json $DEFAULT_CONFIG_PATH/ && \
  rm /tmp/bedrock.zip

# COPY ./profile/mcpe $DEFAULT_CONFIG_PATH
COPY ./script $SCRIPT_PATH


##################  for relaese  #########################
# FROM ubuntu:18.04 as production
# FROM debian:10-slim as production
FROM ubuntu:22.04 as production

# install packages & config docker
RUN apt-get update && \
  apt-get -y install libcurl4 && \
  apt-get -y autoremove && \
  apt-get clean

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"

COPY --from=builder $SERVER_HOME $SERVER_HOME

WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp

# RUN
ENTRYPOINT ["/mcpe/script/docker-entrypoint.sh"]
CMD ["/mcpe/server/bedrock_server"]
