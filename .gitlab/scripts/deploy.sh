#!/bin/bash
source .gitlab/scripts/utils.sh
source .gitlab/scripts/common.sh

# 新增配置变量 - 可以根据实际情况调整
CONTAINER_NAME="hk-equipment"  # 容器名称
HOST_PORT=8080                  # 主机端口
CONTAINER_PORT=80               # 容器内部端口
RESTART_POLICY="always"         # 重启策略

function image_deploy() {
    add_ssh_key
    short_sha="${CI_COMMIT_SHA:0:8}"  # 提取前8个字符
    tag="${DOCKER_TAG}_${short_sha}"

    DOCKER_IMAGE_TAG=$DOCKER_IMAGE:$tag
    list=$1

    for element in ${list}; do
        server_conf=($(handle_server $element))
        user=${server_conf[0]}
        ip=${server_conf[1]}
        port=${server_conf[2]}
        
        echo "部署到服务器: $user@$ip:$port"
        
        # 拉取最新镜像
        ssh -n -p ${port} ${user}@${ip} "echo 拉取镜像: $DOCKER_IMAGE_TAG && docker pull $DOCKER_IMAGE_TAG"
        
        # 停止并删除现有容器（如果存在）
        ssh -n -p ${port} ${user}@${ip} "docker rm -f $CONTAINER_NAME > /dev/null 2>&1 || true"
        
        # 启动新容器
        ssh -n -p ${port} ${user}@${ip} "docker run -d \
            --name $CONTAINER_NAME \
            --restart $RESTART_POLICY \
            -p $HOST_PORT:$CONTAINER_PORT \
            $DOCKER_IMAGE_TAG"
            
        # 检查容器状态
        ssh -n -p ${port} ${user}@${ip} "echo 容器状态: && docker ps -f name=$CONTAINER_NAME"
    done
}