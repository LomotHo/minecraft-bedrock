#!/bin/bash
SERVER_HOME=${1:-`pwd`}

#docker run -it --rm --name=mcpe --net=host \
#docker run -itd --rm --name=mcpe \
docker run -itd --rm --name=mcpe \
  -v ${SERVER_HOME}/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  wilder/minecraft-bedrock:1.16.220.01 
