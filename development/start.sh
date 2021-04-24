#!/bin/bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /Users/cwilder/docker/wilder-minecraft-bedrock/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  wilder/minecraft-bedrock:1.16.220.01
