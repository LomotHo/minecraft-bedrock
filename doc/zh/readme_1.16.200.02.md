[english doc]: https://github.com/LomotHo/minecraft-bedrock
[older version]: https://github.com/LomotHo/minecraft-bedrock/tree/master/doc/en
[中文文档]: https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[旧版文档]: https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/
[捐助]: https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/donation.md
[buy me a coffee]: https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/en/donation.md
[docker pulls]: https://img.shields.io/docker/pulls/lomot/minecraft-bedrock?style=flat-square
[how to install docker]: https://docs.docker.com/install/linux/docker-ce/ubuntu/
[minecraft server]: https://minecraft.net/en-us/download/server/bedrock/
[minecraft服务端下载]: https://minecraft.net/en-us/download/server/bedrock/

[中文文档] | [旧版文档] | [English doc]

![Docker Pulls]

# 基于 docker 的 bedrock minecraft PE 服务器

当前服务器核心版本: 1.16.200.02 镜像版本: lomot/minecraft-bedrock:1.16.200.02

## 快速开启服务器

#### 1. 先在服务器上安装 docker

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

数据目录用于存放地图资料，配置文件，包括`permissions.json`, `server.properties`, `whitelist.json`, `worlds`, 如果数据目录里面没有旧的数据，后面则会自动创建。 目录可以自定，这里以`/opt/mcpe-data`为例

```bash
mkdir -p /opt/mcpe-data
```

#### 3. 部署服务器

把命令里面的`/opt/mcpe-data`换成你自己的目录

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.16.200.02
```

如果发现目录写错了或者要换目录，可以先执行下面的命令关闭并删除刚刚开启的容器，然后再重新开启服务器

```bash
docker stop mcpe
docker rm mcpe
```

~~如果要更换服务器端口，直接把上面命令里面的`19132:19132/udp`的第一个`19132`换成你自己的端口就行了，不需要改`server.properties`里面的端口配置。~~

如果要更换服务器端口，修改 `server.properties` 里面的 `server-port` 并执行 `docker restart mcpe` 重启服务器即可。

## 服务器升级

#### 1. 备份一下数据

就是将`/opt/mcpe-data`这个文件夹备份一下

```bash
cp -r /opt/mcpe-data /opt/mcpe-data.bak
```

#### 2. 退出并删除容器

```bash
docker stop mcpe
docker rm mcpe
```

#### 3. 开启新版的容器

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.16.200.02
```

记得把命令里面的`/opt/mcpe-data`换成你自己的目录

## 服务器管理

### 进入、退出游戏控制台

```bash
docker attach mcpe
```

按`ctrl + p + q`退出控制台
不要用`ctrl+c`或者`ctrl+d`，不然容器会退出。

### 手动 关闭/开启/重启/删除 服务器

```bash
docker stop/start/restart/rm mcpe
```

删除服务器后`/opt/mcpe-data`里面的数据不会丢失

## 进阶选项

### 进入容器

```bash
docker exec -it mcpe /bin/bash
```

执行上面的命令可以进入服务器容器，并且开启一个 shell，这个时候就可以编辑文件了

在 shell 中输入`exit`可以退出

### 向容器复制文件

此命令可以用于添加行为包，资源包，或者添加插件（如果有的话）

```bash
docker cp /path/to/xxx mcpe:/mcpe/server
```

`/path/to/xxx`为主机目录，`mcpe:/mcpe/server`为容器内服务器的目录

### 关于行为包，资源包，插件

由于插件涉及到的文件比较多, 我为此做了一个新的镜像, 这个镜像需要你自己管理服务器文件夹, 可以去 minecraft 官网下载服务端文件: [Minecraft 服务端下载]

用法:

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/mcpe \
  lomot/minecraft-bedrock:base
```

注意: 服务端数据文件夹`/opt/mcpe-data`需要包括完整的服务器文件才能运行, 第一次配置建议从官方网站下载并解压

### 关于网络性能和端口配置

由于桥接模式会损失一定的性能，因此本文档的案例默认使用 host 网络连接模式 `--net=host`，当然也可以使用桥接模式，把`--net=host`替换为`-p 12345:19132/udp`即可

```
docker run -itd --restart=always --name=mcpe -p 12345:19132/udp \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.16.200.02
```

使用桥接模式时如果要更换服务器端口，直接把上面命令里面的 `12345:19132/udp` 的第一个端口号`12345`换成自己的端口就行了，`server.properties`里面的端口配置需要为`19132`。

### 安全地退出容器

直接使用`docker stop mcpe`相当于强行退出游戏服务器，有可能损坏数据（但由于 mc 的数据是区块储存的，一般不会出现这个问题）。

进入游戏控制台：`docker attach mcpe`，然后执行`stop`可以安全地退出容器。

### 如何查看报错日志

执行`docker logs mcpe`，可以查看容器的日志，如果服务器开启失败可以用这个命令查看报错日志。

### 删除无用的镜像

输入 `docker image ls`查看镜像列表如下

```
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
lomot/minecraft-bedrock   base                 4c0a6be845fd        2 weeks ago         97.4MB
lomot/minecraft-bedrock   1.11.4.2-debian-r1   8cd07241f9b3        2 weeks ago         191MB
lomot/minecraft-bedrock   1.10.0.7-r2          05c48844d328        4 weeks ago         216MB
```

例如要删除旧的镜像`lomot/minecraft-bedrock:1.10.0.7-r2`，执行`docker image rm lomot/minecraft-bedrock:1.10.0.7-r2` 即可

### 主机重启自动启动 minecraft 服务

将 docker 设为开机自启即可：

```
systemctl enable docker
```

## 部分报错/问题处理

### Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?

这个是 docker 服务没打开，执行`systemctl start docker`即可

```bash
# 使开启docker开机自启
systemctl enable docker
```

### 日志时间不正确 时区错误

日志时间错误一般是容器内时区错误，在命令中加上`-v /etc/localtime:/etc/localtime`即可，具体如下

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  -v /etc/localtime:/etc/localtime \
  lomot/minecraft-bedrock:1.16.200.02
```

## 问题反馈 QQ 群

667224193

## 服务器二进制文件

https://minecraft.net/en-us/download/server/bedrock/

## Docker 地址

https://hub.docker.com/r/lomot/minecraft-bedrock

## github 项目地址

https://github.com/LomotHo/minecraft-bedrock
