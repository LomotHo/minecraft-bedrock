#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder-dev/minecraft-bedrock:1.16.220.01 -f$PROJECT_ROOT/Dockerfile-dev $PROJECT_ROOT
#docker build -t wilder/minecraft-bedrock:1.16.220.01 -f$PROJECT_ROOT/Dockerfile-dev $PROJECT_ROOT