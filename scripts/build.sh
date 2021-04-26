#!/bin/bash


PROJECT_ROOT=${1:-.}

docker build -t wilder/minecraft-bedrock:1.16.220.01 $PROJECT_ROOT
