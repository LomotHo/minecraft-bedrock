FROM lomot/linuxbase-dev:18.04

###########################################
# FROM ubuntu:18.04

# # install packages & config docker
# COPY ./profile/sources.list /etc/apt/
# COPY ./profile/.tmux.conf /root
# RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
#   DEBIAN_FRONTEND=noninteractive apt-get -y install libcurl4 vim tmux && \
#   DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
#   DEBIAN_FRONTEND=noninteractive apt-get clean
###########################################

# config server
ENV LD_LIBRARY_PATH .
COPY ./server /mcpe/server
COPY ./profile/mcpe /mcpe/default-config
ENTRYPOINT [ "/mcpe/server/init.sh" ]
WORKDIR /mcpe/server
EXPOSE 19132/udp
# RUN 

CMD ["/mcpe/server/start.sh"]
