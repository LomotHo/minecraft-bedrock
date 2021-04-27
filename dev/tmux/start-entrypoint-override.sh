#!/bin/bash
SERVER_HOME=${1:-`pwd`}

#docker run -itd --name=mcpe --net=host \
docker run -itd --name=mcpe --hostname=mcpe \
  -v ${SERVER_HOME}/dev/tmux/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  --entrypoint "/bin/bash" \
  wilder/tmux-minecraft-bedrock:1.16.220.01
