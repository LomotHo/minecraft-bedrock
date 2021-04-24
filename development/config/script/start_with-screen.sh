#!/bin/sh

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

ln -sb $DATA_PATH/permissions.json $SERVER_PATH/permissions.json
ln -sb $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json
ln -sb $DATA_PATH/server.properties $SERVER_PATH/server.properties
ln -sb $DATA_PATH/worlds $SERVER_PATH/worlds

#exec $SERVER_PATH/bedrock_server
screen -s /bin/bash -dmS mcpe_session "$SERVER_PATH/bedrock_server"