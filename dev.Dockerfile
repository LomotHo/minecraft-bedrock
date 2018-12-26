##################  for dev  #########################
FROM lomot/linuxbase-dev:18.04

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"

COPY ./profile/container/sources.list /etc/apt/
COPY ./profile/container/.tmux.conf /root
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4 tmux unzip wget && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get clean && \
  mkdir -p $SERVER_PATH && \
  wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.0.24.zip -O /tmp/bedrock.zip 2>/dev/null && \
  unzip /tmp/bedrock.zip -d $SERVER_PATH && \
  rm $SERVER_PATH/permissions.json $SERVER_PATH/server.properties $SERVER_PATH/whitelist.json

COPY ./profile/mcpe $DEFAULT_CONFIG_PATH
COPY ./script $SCRIPT_PATH

WORKDIR $SERVER_PATH
EXPOSE 19132/udp

# RUN 
CMD ["/mcpe/server/start.sh"]
