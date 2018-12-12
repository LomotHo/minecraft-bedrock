[English doc](https://github.com/LomotHo/minecraft-bedrock) | [中文文档](https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md) | [旧版文档](https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/readme_1.7.0.md)

# 基于docker的bedrock minecraft PE 服务器
当前服务器核心版本: 1.8.0.24 镜像版本: lomot/minecraft-bedrock:1.8.0-0
---

## 快速开启服务器

### 准备工作
 1. 先在服务器上安装docker

这里仅介绍了Ubuntu14.04以上的版本，其它发行版请自行安装docker
```bash
apt install docker.io
```

 2. 创建服务器数据目录

数据目录用于存放地图资料，配置文件，包括ops.json, permissions.json, server.properties, whitelist.json, worlds, 如果数据目录里面没有旧的数据，后面则会自动创建。 目录可以自定，这里以/opt/mcpe-data为例
```bash
mkdir -p /opt/mcpe-data
```

### 开启服务器
把命令里面的 "/opt/mcpe-data" 换成你自己的目录
```bash
docker run -d -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.8.0-0
```
如果发现目录写错了或者要换目录，可以先执行下面的命令关闭并停止刚刚开启的服务器，然后再重新开启服务器
```bash
docker stop mcpe
docker rm mcpe
```

## 服务器管理

### 进入、退出游戏控制台
```bash
docker attach mcpe
```
按 ctrl + p + q 退出控制台
不要用ctrl+c 或者 ctrl+d，不然服务会关闭

### 手动 关闭/开启/重启/删除 服务器
```bash
docker stop/start/restart/rm mcpe
```
删除服务器后 /opt/mcpe-data里面的数据不会丢失
### 向容器复制文件
```bash
docker cp /path/to/xxx mcpe:/mcpe/server
```
容器内服务器目录为/mcpe/server

### 进入容器
```bash
docker exec -it mcpe /bin/bash
```

### 崩溃自动重启的方式开启服务器
```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.8.0-0
```

执行上面的命令可以进入服务器容器，并且开启一个shell，这个时候就可以编辑文件了
在shell中输入 "exit" 可以退出

## 服务器二进制文件
https://minecraft.net/en-us/download/server/bedrock/

## Docker 地址
https://cloud.docker.com/repository/docker/lomot/minecraft-bedrock

## github 项目地址
https://github.com/LomotHo/minecraft-bedrock
