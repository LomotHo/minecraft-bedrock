##################  for dev  #########################
FROM alpine:latest as builder

# build config (TODO: Figure out solution to auto-config the server)
#ARG MCPE_SERVER_CONFIG="wilder-creative"

# config server
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV CORE_VERSION="1.16.221.01" \
  IMAGE_VERSION="1"

# unzip pack and download new server
RUN apk --no-cache add unzip wget && \
  mkdir -p $SERVER_PATH && \
  mkdir -p $DEFAULT_CONFIG_PATH && \
  wget -nv https://minecraft.azureedge.net/bin-linux/bedrock-server-$CORE_VERSION.zip -O /tmp/bedrock.zip

# Extract server and backup the configuration
RUN unzip -q /tmp/bedrock.zip -d $SERVER_PATH \
  && mv $SERVER_PATH/permissions.json $DEFAULT_CONFIG_PATH/ \
  && mv $SERVER_PATH/server.properties $DEFAULT_CONFIG_PATH/ \
  && mv $SERVER_PATH/whitelist.json $DEFAULT_CONFIG_PATH/ \
  && chmod +x $SERVER_PATH/bedrock_server \
  && rm /tmp/bedrock.zip


# Add custom entrypoint scripts
# COPY ./profile/mcpe/configs/$MCPE_SERVER_CONFIG $DEFAULT_CONFIG_PATH
# COPY ./profile/mcpe/scripts $SCRIPT_PATH
COPY profile/mcpe/scripts/docker-entrypoint-orig.sh ${SCRIPT_PATH}/docker-entrypoint-nodev.sh
COPY profile/mcpe/scripts/docker-entrypoint-dev.sh ${SCRIPT_PATH}/docker-entrypoint-dev.sh
COPY profile/mcpe/scripts/docker-entrypoint-orig.sh ${SCRIPT_PATH}/docker-entrypoint.sh
RUN chmod +x ${SCRIPT_PATH}/*.sh


##################  for relaese  #########################
# FROM ubuntu:18.04 as production
FROM debian:10-slim as production

# install packages & config docker
# pkgs installed on 1st line of apt installs are required, 2nd line pkgs are admin tools, and 3rd line are development tools.
RUN apt-get update \
  && apt-get -y install libcurl4 \
  && apt-get -y install vim procps file htop \
  && apt-get -y install tree tcpdump sed grep gawk ack \
  && apt-get -y autoremove \
  && apt-get clean

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV SHELL="/bin/bash"

# Copy from builder stage to this stage
COPY --from=builder $SERVER_HOME $SERVER_HOME

# Add shell environment config files
COPY profile/container/.bashrc /root/.bashrc
COPY profile/container/.vimrc /root/.vimrc


WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp

# RUN
CMD ["/mcpe/script/docker-entrypoint.sh", "/mcpe/server/bedrock_server"]