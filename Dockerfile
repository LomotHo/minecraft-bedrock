# FROM lomot/linuxbase-dev:18.04
FROM ubuntu:18.04

# install packages & config docker
COPY ./profile/sources.list /etc/apt/
RUN apt-get update && \
  apt-get install libcurl4 vim tmux -y
COPY ./profile/.tmux.conf /root

# config server
ENV LD_LIBRARY_PATH .
COPY ./server /mcpe
WORKDIR /mcpe
EXPOSE 19132/udp
# RUN 

CMD ["/mcpe/start.sh"]
