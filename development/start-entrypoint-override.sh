#!/bin/bash
docker run -itd --name=mcpe --net=host \
  -v /Users/cwilder/docker/lomot-minecraft-bedrock/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  --entrypoint "/bin/bash" \
  cwilder/minecraft-bedrock:1.16.210.05
