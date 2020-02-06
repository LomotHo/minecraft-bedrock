[English doc]:https://github.com/LomotHo/minecraft-bedrock
[Older version]:https://github.com/LomotHo/minecraft-bedrock/tree/master/doc/en
[中文文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[旧版文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/
[捐助]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/donation.md
[buy me a coffee]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/en/donation.md
[Docker Pulls]:https://img.shields.io/docker/pulls/lomot/minecraft-bedrock.svg
[How to install Docker]:https://docs.docker.com/install/linux/docker-ce/ubuntu/
[Minecraft server]:https://minecraft.net/en-us/download/server/bedrock/
[Minecraft服务端下载]:https://minecraft.net/en-us/download/server/bedrock/

[English doc] | [Older version] | [中文文档]

![Docker Pulls]

# a bedrock minecraft PE Server on docker
this documentation is for image lomot/minecraft-bedrock:1.14.21.0

## Start a server quickly
#### 1. install docker on your server

```bash
apt install docker.io
```
or you can follow this documentation : [How to install Docker]

#### 2. create folder for server data
this folder is for your map data and some configuration files, it contains ```permissions.json```,```server.properties```,```whitelist.json```,```worlds```, if you use an empty folder, all the file will be created automatically, ```/opt/mcpe-data``` for an example

```bash
mkdir -p /opt/mcpe-data
```

#### 3. deploy the server

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.14.21.0
```

## Upgrade the server
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
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.14.21.0
```


## Manage the server
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

### change the port
~~do NOT change the port configuration of ```server.properties``` file, just change the frist 19132 of parameter```19132:19132/udp```~~

Just change the ```server-port``` in the file```server.properties``` is OK.

using bridge networks will decrease the network performance, it is supposed to use host networks.

### about addon, behavior_packs, resource_packs
there are too many files about addons to configure, so I made another image, to use this image, you need to manage server folder by yourself, such as update and configuration files, you can dowload the server files here [Minecraft server].

how to use:


```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/mcpe \
  lomot/minecraft-bedrock:base
```

## Binary file from
https://minecraft.net/en-us/download/server/bedrock/

## Docker Hub
https://hub.docker.com/r/lomot/minecraft-bedrock

## Github
https://github.com/LomotHo/minecraft-bedrock
