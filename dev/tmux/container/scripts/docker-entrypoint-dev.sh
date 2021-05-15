#!/bin/bash

# create file if not exist
if [ ! -f "$DATA_PATH/permissions.json" ]; then
  cp $DEFAULT_CONFIG_PATH/permissions.json $DATA_PATH/permissions.json
fi

if [ ! -f "$DATA_PATH/whitelist.json" ]; then
  cp $DEFAULT_CONFIG_PATH/whitelist.json $DATA_PATH/whitelist.json
fi

if [ ! -f "$DATA_PATH/server.properties" ]; then
  cp $DEFAULT_CONFIG_PATH/server.properties $DATA_PATH/server.properties
fi

if [ ! -d "$DATA_PATH/worlds" ]; then
  mkdir -p $DATA_PATH/worlds
fi

# extra
if [ ! -d "$DATA_PATH/extra" ]; then
  mkdir -p $DATA_PATH/extra
fi

# behavior_packs & resource_packs
if [ ! -d "$DATA_PATH/extra/$CORE_VERSION" ]; then
  mkdir -p $DATA_PATH/extra/$CORE_VERSION
  mv $SERVER_PATH/behavior_packs $DATA_PATH/extra/$CORE_VERSION
  mv $SERVER_PATH/resource_packs $DATA_PATH/extra/$CORE_VERSION
fi

ln -sb $DATA_PATH/permissions.json $SERVER_PATH/permissions.json
ln -sb $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json
ln -sb $DATA_PATH/server.properties $SERVER_PATH/server.properties
ln -sb $DATA_PATH/worlds $SERVER_PATH/worlds

ln -sb $DATA_PATH/extra/$CORE_VERSION/behavior_packs $SERVER_PATH/behavior_packs
ln -sb $DATA_PATH/extra/$CORE_VERSION/resource_packs $SERVER_PATH/resource_packs

# Modding this file so that I can run the "start-dev.sh" script. Should make a new Dockerfile and redefine CMD, but doing it here instead.
echo "Running development server"

if [ $# -gt 0 ];then
  exec "$@"
else
  # NOTE: Must call "tmux attach" or else the container will immediate terminate after starting up.
  #tmux new-session -d -x "80" -y "35" -s "mcpe" "/mcpe/server/bedrock_server" && \
  tmux new-session -d -s "mcpe" "/mcpe/server/bedrock_server" && \
  tmux attach
fi