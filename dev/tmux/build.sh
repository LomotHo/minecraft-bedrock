#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/tmux-minecraft-bedrock:1.16.220.01 -f$PROJECT_ROOT/dev/tmux/tmux.Dockerfile $PROJECT_ROOT