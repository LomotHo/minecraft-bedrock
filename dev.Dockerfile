##################  for dev  #########################
# FROM ubuntubase-dev:18.04 
FROM lomot/ubuntubase-dev:18.04 

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV CORE_VERSION="1.9.0.15" \
  CONTAINER_VERSION="1.9.0.15-r0"

RUN mkdir -p $SERVER_PATH

RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-$CORE_VERSION.zip -O /tmp/bedrock.zip 2>/dev/null && \
  unzip /tmp/bedrock.zip -d $SERVER_PATH && \
  rm $SERVER_PATH/permissions.json $SERVER_PATH/server.properties $SERVER_PATH/whitelist.json


COPY ./profile/mcpe $DEFAULT_CONFIG_PATH
COPY ./script $SCRIPT_PATH

# ENTRYPOINT ["/mcpe/script/init.sh"]
WORKDIR $SERVER_PATH
EXPOSE 19132/udp

# RUN 
# CMD ["/mcpe/server/bedrock_server"]
# CMD ["sh", "-c", "/mcpe/script/start.sh"]
CMD ["/mcpe/script/start-dev0.sh"]

