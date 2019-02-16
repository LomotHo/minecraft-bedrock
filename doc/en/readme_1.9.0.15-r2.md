[English-doc]:https://github.com/LomotHo/minecraft-bedrock
[中文文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[previous-doc]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/en/

[English-doc] | [中文文档] | [previous-doc] 

# a bedrock minecraft PE Server on docker
this doc is for image lomot/minecraft-bedrock:1.9.0.15-r2

## start a server quickly
### prepare
 1. install docker

```bash
apt install docker.io
```

 2. create dir for server data

it contains ops.json, permissions.json, server.properties, whitelist.json, worlds, if you have an empty folder, all the file will be created automatically, "/opt/mcpe-data" for an example
```bash
mkdir -p /opt/mcpe-data
```

### start the server
```bash
docker run -d -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.9.0.15-r2
```

## manage the server
### enter or quit the game console
```bash
docker attach mcpe
```
press ctrl + p + q to quit
do not use ctrl+c or ctrl+d, this wii kill the process

### stop/start/restart/rm the server 
```bash
docker container stop/start/restart/rm mcpe
```

### run the container with auto restart when the server crashed
```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.9.0.15-r2
```

## bin file from 
https://minecraft.net/en-us/download/server/bedrock/

## Docker address
https://cloud.docker.com/repository/docker/lomot/minecraft-bedrock

## github address
https://github.com/LomotHo/minecraft-bedrock
