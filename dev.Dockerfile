##################  for dev  #########################
FROM lomot/linuxbase-dev:18.04

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_PATH="/mcpe/server"
ENV DEFAULT_CONFIG_PATH="/mcpe/default-config"
ENV DATA_PATH="/data"

COPY ./server $SERVER_PATH
COPY ./profile/mcpe $DEFAULT_CONFIG_PATH

WORKDIR $SERVER_PATH
EXPOSE 19132/udp

# RUN 
CMD ["/mcpe/server/start.sh"]
