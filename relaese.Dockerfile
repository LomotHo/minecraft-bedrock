# FROM lomot/linuxbase-dev:18.04
FROM ubuntu:18.04

# install packages & config docker
COPY ./profile/container/sources.list /etc/apt/
COPY ./profile/container/.tmux.conf /root
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4 vim tmux && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get clean

# config server
ENV LD_LIBRARY_PATH .
COPY ./server /mcpe
WORKDIR /mcpe
EXPOSE 19132/udp
# RUN 

CMD ["/mcpe/start.sh"]
