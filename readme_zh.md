[English-doc]:https://github.com/LomotHo/minecraft-bedrock
[中文文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/readme_zh.md
[旧版文档]:https://github.com/LomotHo/minecraft-bedrock/blob/master/doc/zh/

[English-doc] | [中文文档] | [旧版文档] 

# 基于docker的bedrock minecraft PE 服务器
当前服务器核心版本: 1.9.0.15 镜像版本: lomot/minecraft-bedrock:1.9.0.15-r2

## 快速开启服务器

1. 先在服务器上安装docker

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
	
2. 创建服务器数据目录

	数据目录用于存放地图资料，配置文件，包括```ops.json```,``` permissions.json```, ```server.properties```,```whitelist.json```, ```world```, 如果数据目录里面没有旧的数据，后面则会自动创建。 目录可以自定，这里以/opt/mcpe-data为例
	
	```bash
	mkdir -p /opt/mcpe-data
	```

3. 部署服务器
	把命令里面的```/opt/mcpe-data```换成你自己的目录
	
	```bash
	docker run -d -it --name mcpe -v /opt/mcpe-data:/data -p 19132:19132/udp lomot/minecraft-bedrock:1.9.0.15-r2
	```
	如果发现目录写错了或者要换目录，可以先执行下面的命令关闭并删除刚刚开启的容器，然后再重新开启服务器
	
	```bash
	docker stop mcpe
	docker rm mcpe
	```

## 服务器升级

1. 首先备份一下数据
  就是将```/opt/mcpe-data```这个文件夹备份一下
	
  ```bash
  cp /opt/mcpe-data /opt/mcpe-data.bak
  ```

2. 然后退出并删除容器

  ```bash
  docker container stop mcpe
  docker container rm mcpe
  ```
3. 开启新版的容器

  ```bash
  docker run -d -it --name mcpe -v /opt/mcpe-data:/data -p 19132:19132/udp lomot/minecraft-bedrock:1.9.0.15-r2
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

### 以自动重启的方式开启服务器
加上```--restart=on-failure:5```或者```--restart=always```参数即可

```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /opt/mcpe-data:/data \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.9.0.15-r2
```

如果需要主机开机或重启时自动启动mc容器，将docker设为开机自启即可：
```
systemctl enable docker
```

### 减少网络性能损耗
docker的网络性能损失主要是由于桥接网络造成的，把参数```-p 19132:19132/udp```去掉，加上```--net=host```就能解决问题。

```bash
docker run -d -it --name mcpe -v /opt/mcpe-data:/data --net=host lomot/minecraft-bedrock:1.9.0.15-r2
```

### 安全地退出容器
直接使用```docker stop mcpe```相当于强行退出游戏服务器，有可能损坏数据（但由于mc的数据是区块储存的，一般不会出现这个问题）。

进入游戏控制台：```docker attach mcpe```，然后执行```stop```可以安全地退出容器。

### 如何查看报错日志
执行```docker logs mcpe```，可以查看容器的日志，如果服务器开启失败可以用这个命令查看报错日志。

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
https://cloud.docker.com/repository/docker/lomot/minecraft-bedrock

## github 项目地址
https://github.com/LomotHo/minecraft-bedrock
