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

ln -sb $DATA_PATH/permissions.json $SERVER_PATH/permissions.json
ln -sb $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json
ln -sb $DATA_PATH/server.properties $SERVER_PATH/server.properties
ln -sb $DATA_PATH/worlds $SERVER_PATH/worlds

#exec "$@"
echo "Running $@"
echo "$(tmux --help)"
echo ""
echo "$(/usr/bin/tmux --help)"
#exec tmux new -d -s mcpe "$@" || tmux new -d -s mcpe "exec $@" || exec tmux new -d -s mcpe "exec $@" ||  /usr/bin/tmux new -d -s mcpe "/bin/bash -c $@"

# echo "Attempt 1" \
# && exec tmux new -d -s mcpe1 "$@" \
# && echo "Attempt 1: exit code $?" \
# || echo "Attempt 2" \
# && tmux new -d -s mcpe2 "exec $@" \
# && echo "Attempt 2: exit code $?" \
# || echo "Attempt 3" \
# && exec tmux new -d -s mcpe3 "exec $@" \
# && echo "Attempt 3: exit code $?" \
# || echo "Attempt 4" \
# && /usr/bin/tmux new -d -s mcpe4 "/bin/bash -c $@" \
# && echo "Attempt 4: exit code $?"

tmux new -d -s mcpe2 "exec $@"