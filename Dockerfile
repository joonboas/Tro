# 使用更小的基础镜像
FROM debian:buster-slim

# 安装 Tor 和 nginx，并清理缓存
RUN apt-get update && \
    apt-get install -y tor nginx && \
    rm -rf /var/lib/apt/lists/*

# 复制配置文件和网站内容
COPY /home/newbe/2/torrc /etc/tor/torrc
COPY /home/newbe/1/wordpress/ /var/www/html/

# 暴露 nginx 运行的端口
EXPOSE 80

# 添加非root用户并切换
RUN useradd -m newbe
USER newbe

# 启动 Tor 和 nginx
CMD tor & nginx -g 'daemon off;'
