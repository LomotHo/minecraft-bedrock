#!/bin/sh

# create file if not exist
if [ ! -f "$DATA_PATH/permissions.json" ]; then
  cp $DEFAULT_CONFIG_PATH/permissions.json $DATA_PATH/permissions.json
fi

if [ ! -f "$DATA_PATH/allowlist.json" ]; then
  cp $DEFAULT_CONFIG_PATH/allowlist.json $DATA_PATH/allowlist.json
fi

if [ ! -f "$DATA_PATH/server.properties" ]; then
  cp $DEFAULT_CONFIG_PATH/server.properties $DATA_PATH/server.properties
fi

if [ ! -d "$DATA_PATH/worlds" ]; then
  mkdir -p $DATA_PATH/worlds
fi

ln -sb $DATA_PATH/permissions.json $SERVER_PATH/permissions.json
ln -sb $DATA_PATH/allowlist.json $SERVER_PATH/allowlist.json
ln -sb $DATA_PATH/server.properties $SERVER_PATH/server.properties
ln -sb $DATA_PATH/worlds $SERVER_PATH/worlds

exec $SERVER_PATH/bedrock_server
