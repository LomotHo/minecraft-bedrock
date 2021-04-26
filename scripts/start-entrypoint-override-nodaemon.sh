#!/bin/bash
SERVER_HOME=${1:-`pwd`}

docker run -it --rm --name=mcpe --net=host \
  -v ${SERVER_HOME}/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  --entrypoint "/bin/bash" \
  wilder/minecraft-bedrock:1.16.220.01
