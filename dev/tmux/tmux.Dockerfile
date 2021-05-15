##################  for tmux  #########################
FROM wilder/minecraft-bedrock:latest

# todo: are these needed for tmux?
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Add custom entrypoint scripts
COPY dev/tmux/container/scripts/docker-entrypoint.sh ${SCRIPT_PATH}/docker-entrypoint-orig-tmux.sh
COPY dev/tmux/container/scripts/docker-entrypoint-dev.sh ${SCRIPT_PATH}/docker-entrypoint-dev-tmux.sh
COPY dev/tmux/container/scripts/docker-entrypoint-dev-mod.sh ${SCRIPT_PATH}/docker-entrypoint-dev-mod-tmux.sh
COPY dev/tmux/container/scripts/docker-entrypoint.sh ${SCRIPT_PATH}/docker-entrypoint.sh
RUN chmod +x ${SCRIPT_PATH}/*.sh

# install packages & config docker
RUN apt-get update \
  && apt-get -y install tmux \
  && apt-get -y autoremove \
  && apt-get clean


# Add shell environment config files
COPY dev/tmux/container/.tmux.conf /root/.tmux.conf

# RUN
ENTRYPOINT ["bash", "/mcpe/script/docker-entrypoint.sh"]
