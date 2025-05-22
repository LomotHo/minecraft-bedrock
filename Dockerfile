##################  for dev  #########################
FROM alpine:latest as builder

# config server
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV CORE_VERSION="1.21.83.1" \
  IMAGE_VERSION="1"
# unzip pack
RUN apk --no-cache add unzip wget curl && \
  mkdir -p $SERVER_PATH && \
  mkdir -p $DEFAULT_CONFIG_PATH
RUN curl https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-$CORE_VERSION.zip \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36' \
  -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7,zh-TW;q=0.6' \
  -H 'dnt: 1' \
  -H 'priority: u=0, i' \
  -H 'upgrade-insecure-requests: 1' \
  -o /tmp/bedrock.zip
RUN unzip -q /tmp/bedrock.zip -d $SERVER_PATH && \
  rm -rf $SERVER_PATH/bedrock_server_symbols.debug && \
  mv $SERVER_PATH/permissions.json $DEFAULT_CONFIG_PATH/ && \
  mv $SERVER_PATH/server.properties $DEFAULT_CONFIG_PATH/ && \
  mv $SERVER_PATH/allowlist.json $DEFAULT_CONFIG_PATH/ && \
  rm /tmp/bedrock.zip

# COPY ./profile/mcpe $DEFAULT_CONFIG_PATH
COPY ./script $SCRIPT_PATH


##################  for relaese  #########################
FROM ubuntu:22.04 as production

# install packages & config docker
RUN apt-get update && \
  apt-get -y install libcurl4 tzdata && \
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
