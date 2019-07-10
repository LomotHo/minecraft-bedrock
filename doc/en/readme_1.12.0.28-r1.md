[English doc]:https://github.com/LomotHo/minecraft-bedrock
[中文文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[旧版文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/
[Docker Pulls]:https://img.shields.io/docker/pulls/lomot/minecraft-bedrock.svg
[How to install Docker]:https://docs.docker.com/install/linux/docker-ce/ubuntu/
[Minecraft server]:https://minecraft.net/en-us/download/server/bedrock/

[English doc] | [中文文档] | [旧版文档]

![Docker Pulls]

# a bedrock minecraft PE Server on docker
this documentation is for image lomot/minecraft-bedrock:1.12.0.28-r1, lomot/minecraft-bedrock:1.12.0.28-debian-r1

## start a server quickly
#### 1. install docker on your server

```bash
apt install docker.io
```
or you can follow this documentation : [How to install Docker]

#### 2. create folder for server data
this folder is for your map data and some configuration files, it contains ```ops.json```,``` permissions.json```,```server.properties```,```whitelist.json```,```worlds```, if you use an empty folder, all the file will be created automatically, ```/opt/mcpe-data``` for an example

```bash
mkdir -p /opt/mcpe-data
```

#### 3. deploy the server

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.12.0.28-r1
```

## upgrade the server
#### 1. backup you data

just backup the folder ```/opt/mcpe-data```

```bash
cp -r /opt/mcpe-data /opt/mcpe-data.bak
```

#### 2. exit and delete the old server

```bash
docker container stop mcpe
docker container rm mcpe
```
#### 3. start a new version server

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.12.0.28-r1
```

## manage the server
### enter or quit the game console
```bash
docker attach mcpe
```
press ```ctrl + p + q``` to quit
do not use ```ctrl+c``` or ```ctrl+d```, this wii kill the process

### stop/start/restart/rm the server
```bash
docker container stop/start/restart/rm mcpe
```

### automatically restart when the server crashed
```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.12.0.28-r1
```
### change the port
do NOT change the port configuration of ```server.properties``` file, just change the frist 19132 of parameter```19132:19132/udp```

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 12345:19132/udp lomot/minecraft-bedrock:1.12.0.28-r1
```

### about addon, behavior_packs, resource_packs
there are too many files about addons to configure, so I made another image, to use this image, you need to manage server folder by yourself, such as update and configuration files, you can dowload the server files here [Minecraft server].

how tu use:

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/mcpe \
  -p 19132:19132/udp lomot/minecraft-bedrock:base
```

## Binary file from
https://minecraft.net/en-us/download/server/bedrock/

## Docker Hub
https://hub.docker.com/r/lomot/minecraft-bedrock

## Github
https://github.com/LomotHo/minecraft-bedrock
