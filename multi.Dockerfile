##################  for dev  #########################
FROM alpine:latest as builder

# config server
ENV LD_LIBRARY_PATH . \
 SERVER_HOME="/mcpe" \
 SERVER_PATH="/mcpe/server" \
 DEFAULT_CONFIG_PATH="/mcpe/default-config" \
 DATA_PATH="/data"

ADD https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.0.24.zip /opt
# 解压并复制
RUN apk --no-cache add unzip \
  unzip /opt/bedrock-server-1.8.0.24.zip /opt/server

# 未完成
COPY ./server $SERVER_PATH
COPY ./profile/mcpe $DEFAULT_CONFIG_PATH

##################  for relaese  #########################
FROM ubuntu:18.04 as production

# install packages & config docker
COPY ./profile/container/sources.list /etc/apt/
COPY ./profile/container/.tmux.conf /root
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4 tmux && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get clean
###########################################

# config server
ENV LD_LIBRARY_PATH . \
  SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"

# COPY ./server $SERVER_PATH
# COPY ./profile/mcpe $DEFAULT_CONFIG_PATH
WORKDIR $${SERVER_PATH}
COPY --from=0 $SERVER_HOME $SERVER_HOME

EXPOSE 19132/udp

# RUN 
CMD ["/mcpe/server/start.sh"]
