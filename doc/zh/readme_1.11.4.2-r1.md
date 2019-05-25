[English doc]:https://github.com/LomotHo/minecraft-bedrock
[中文文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[旧版文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/
[Docker Pulls]:https://img.shields.io/docker/pulls/lomot/minecraft-bedrock.svg
[How to install Docker]:https://docs.docker.com/install/linux/docker-ce/ubuntu/
[Minecraft服务端下载]:https://minecraft.net/en-us/download/server/bedrock/

[English doc] | [中文文档] | [旧版文档]

![Docker Pulls]

# 基于docker的bedrock minecraft PE 服务器
当前服务器核心版本: 1.11.4.2 镜像版本: lomot/minecraft-bedrock:1.11.4.2-r1, lomot/minecraft-bedrock:1.11.4.2-debian-r1

## 快速开启服务器

#### 1. 先在服务器上安装docker

```bash
curl -sSL https://get.daocloud.io/docker | sh
# 此脚本适用于Ubuntu，Debian,Centos等大部分Linux
systemctl start docker
# 安装完成后记得打开docker
```

<!-- 这里仅介绍了Ubuntu14.04以上的版本，其它发行版请自行安装docker
apt install docker.io
此处附上docker-ce(社区版)官方中文安装文档：
[docker安装文档](https://docs.docker-cn.com/engine/installation/linux/docker-ce/ubuntu/) -->

#### 2. 创建服务器数据目录
数据目录用于存放地图资料，配置文件，包括```ops.json```,``` permissions.json```, ```server.properties```,```whitelist.json```, ```worlds```, 如果数据目录里面没有旧的数据，后面则会自动创建。 目录可以自定，这里以```/opt/mcpe-data```为例

```bash
mkdir -p /opt/mcpe-data
```

#### 3. 部署服务器
把命令里面的```/opt/mcpe-data```换成你自己的目录

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.11.4.2-r1
```
如果发现目录写错了或者要换目录，可以先执行下面的命令关闭并删除刚刚开启的容器，然后再重新开启服务器

```bash
docker stop mcpe
docker rm mcpe
```
如果要更换服务器端口，直接把上面命令里面的```19132:19132/udp```的第一个```19132```换成你自己的端口就行了，不需要改```server.properties```里面的配置。

## 服务器升级

#### 1. 首先备份一下数据
就是将```/opt/mcpe-data```这个文件夹备份一下

```bash
cp -r /opt/mcpe-data /opt/mcpe-data.bak
```

#### 2. 然后退出并删除容器

```bash
docker container stop mcpe
docker container rm mcpe
```

#### 3. 开启新版的容器

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.11.4.2-r1
```
记得把命令里面的```/opt/mcpe-data```换成你自己的目录
结束

## 服务器管理

### 进入、退出游戏控制台

```bash
docker attach mcpe
```
按```ctrl + p + q```退出控制台
不要用```ctrl+c```或者```ctrl+d```，不然容器会退出。

### 手动 关闭/开启/重启/删除 服务器

```bash
docker stop/start/restart/rm mcpe
```
删除服务器后```/opt/mcpe-data```里面的数据不会丢失

### 向容器复制文件
此命令可以用于添加行为包，资源包，或者添加插件（如果有的话）

```bash
docker cp /path/to/xxx mcpe:/mcpe/server
```
```/path/to/xxx```为主机目录，```mcpe:/mcpe/server```为容器内服务器的目录

### 进入容器

```bash
docker exec -it mcpe /bin/bash
```

执行上面的命令可以进入服务器容器，并且开启一个shell，这个时候就可以编辑文件了

在shell中输入```exit```可以退出

## 进阶选项

### 修改端口
如果要更换服务器端口，直接把上面命令里面的```19132:19132/udp```的第一个```19132```换成你自己的端口就行了，不需要改```server.properties```里面的端口配置。

### 关于插件

由于插件涉及到的文件比较多, 我为此做了一个新的镜像, 你需要自己管理服务器文件夹, 可以去minecraft官网下载服务端文件: [Minecraft服务端下载]

用法:

```bash
docker run -d --restart=always -it --name mcpe \
  -v /opt/mcpe-data:/mcpe \
  -p 19132:19132/udp lomot/minecraft-bedrock:base
```

注意: 服务端数据文件夹```/opt/mcpe-data```需要包括完整的数据才能运行, 第一次配置建议从官方网站下载并解压

### 以自动重启的方式开启服务器
加上```--restart=on-failure:5```或者```--restart=always```参数即可

```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.11.4.2-r1
```

如果需要主机开机或重启时自动启动mc容器，将docker设为开机自启即可：
```
systemctl enable docker
```

### 减少网络性能损耗
docker的网络性能损失主要是由于桥接网络造成的，把参数```-p 19132:19132/udp```去掉，加上```--net=host```就能解决问题。

```bash
docker run -d -it --name mcpe -v /opt/mcpe-data:/data --net=host lomot/minecraft-bedrock:1.11.4.2-r1
```

此时如果要更换服务器端口，修改```server.properties```里面的配置即可。

### 安全地退出容器
直接使用```docker stop mcpe```相当于强行退出游戏服务器，有可能损坏数据（但由于mc的数据是区块储存的，一般不会出现这个问题）。

进入游戏控制台：```docker attach mcpe```，然后执行```stop```可以安全地退出容器。

### 如何查看报错日志
执行```docker logs mcpe```，可以查看容器的日志，如果服务器开启失败可以用这个命令查看报错日志。

### 删除无用的镜像

输入 ```docker image ls```查看镜像列表如下
```
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
lomot/minecraft-bedrock   base                 4c0a6be845fd        2 weeks ago         97.4MB
lomot/minecraft-bedrock   1.11.4.2-debian-r1   8cd07241f9b3        2 weeks ago         191MB
lomot/minecraft-bedrock   1.10.0.7-r2          05c48844d328        4 weeks ago         216MB
```
例如要删除旧的镜像```lomot/minecraft-bedrock:1.10.0.7-r2```，执行```docker image rm lomot/minecraft-bedrock:1.10.0.7-r2``` 即可

## 部分报错处理

### Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
这个是docker服务没打开，执行```systemctl start docker```即可

```bash
# 使开启docker开机自启
systemctl enable docker
```

## 问题反馈QQ群
667224193

## 服务器二进制文件
https://minecraft.net/en-us/download/server/bedrock/

## Docker 地址
https://hub.docker.com/r/lomot/minecraft-bedrock

## github 项目地址
https://github.com/LomotHo/minecraft-bedrock
