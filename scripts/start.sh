#!/bin/bash

SERVER_HOME=${1:-`pwd`}

docker run -itd --restart=always --name=mcpe \
  -v $SERVER_HOME/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  wilder/minecraft-bedrock:1.16.220.01

# Alternative to the above. Use host networking mode instead of port forwarding.
#docker run -itd --restart=always --name=mcpe --net=host \
#  -v $SERVER_HOME/mcpe-data:/data \
#  wilder/minecraft-bedrock:1.16.220.01


# RUNS WITH WARNING. Port forwarding doesn't work in host networking mode
#docker run -itd --restart=always --name=mcpe --net=host \
#  -v $SERVER_HOME/mcpe-data:/data \
#  -p 0.0.0.0:19132:19132/udp \
#  wilder/minecraft-bedrock:1.16.220.01
