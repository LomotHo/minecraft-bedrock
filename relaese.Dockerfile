##################  for relaese  #########################
FROM ubuntu:18.04

# install packages & config docker
COPY ./profile/container/sources.list /etc/apt/
COPY ./profile/container/.tmux.conf /root
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4 vim tmux && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get clean
###########################################

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
