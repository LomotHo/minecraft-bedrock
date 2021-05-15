#!/bin/bash
CONTAINER=${1:-mcpe}

docker exec -it $CONTAINER /bin/bash
