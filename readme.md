[English doc](https://github.com/LomotHo/minecraft-bedrock) | [中文文档](https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md) | [旧版文档](https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/readme_1.7.0.md)

# a bedrock minecraft PE Server on docker
this is for image lomot/minecraft-bedrock:1.7.0
## run a server
```bash
docker run -d -it --name mcpe \
  -v /path/to/worlds:/mcpe/worlds \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.7.0
```
change "/path/to/worlds" to you own worlds dir

### run with auto restart when the server crashed
```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /path/to/worlds:/mcpe/worlds \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.7.0
```

### stop/start/restart/rm the server 
```bash
docker container stop/start/restart/rm mcpe
```

### enter or quit the console
```bash
docker attach mcpe
```
press ctrl + p + q to quit
do not use ctrl+c or ctrl+d, this wii kill the process

### edit config file
```bash
docker exec -it mcpe /bin/bash
vim /mcpe/server.properties
```
type "exit" to exit the shell

## bin file from 
https://minecraft.net/en-us/download/server/bedrock/

## Docker address
https://cloud.docker.com/repository/docker/lomot/minecraft-bedrock

## github address
https://github.com/LomotHo/minecraft-bedrock
