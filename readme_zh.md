( [English doc](README.md) )|( [中文文档](README_zh.md) )


## 运行服务器
<!-- 
 - 先在服务区上安装docker
```bash
apt install docker
```

 - 运行服务器 -->
```bash
docker run -d -it --name mcpe \
  -v /path/to/worlds:/mcpe/worlds \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.7.0
```

把命令里面的 "/path/to/worlds" 换成你自己的目录
用于存放世界数据

### 崩溃自动重启的方式开启服务器
```bash
docker run -d --restart=on-failure:5 -it --name mcpe \
  -v /path/to/worlds:/mcpe/worlds \
  -p 19132:19132/udp lomot/minecraft-bedrock:1.7.0
```

### 手动 关闭/开启/重启/删除 服务器
```bash
docker container stop/start/restart/rm mcpe
```

### 进入、退出游戏控制台
```bash
docker attach mcpe
```
按 ctrl + p + q 退出控制台
不要用ctrl+c 或者 ctrl+d，不然服务会关闭

### 如何编辑游戏配置文件
```bash
docker exec -it mcpe /bin/bash
vim /mcpe/server.properties
```
执行上面的命令可以进入服务器容器，并且开启一个shell，这个时候就可以编辑配置文件了
在shell中输入 "exit" 可以退出

## 服务器二进制文件
https://minecraft.net/en-us/download/server/bedrock/

## Docker 地址
https://cloud.docker.com/repository/docker/lomot/minecraft-bedrock

## github 项目地址
https://github.com/LomotHo/minecraft-bedrock
