FROM phusion/baseimage:0.9.16
MAINTAINER Theo Julienne <theo@ninjablocks.com>

RUN apt-get update; apt-get install -y mosquitto redis-server

RUN adduser --disabled-password ninja

RUN mkdir -p /opt/ninjablocks

# sphere-client
ADD sphere-client/ninjapack/root/opt/ninjablocks/sphere-client /opt/ninjablocks/sphere-client
ADD bin-linux-amd64/sphere-client /opt/ninjablocks/sphere-client/

# sphere-go-homecloud
ADD sphere-go-homecloud/ninjapack/root/opt/ninjablocks/sphere-go-homecloud /opt/ninjablocks/sphere-go-homecloud
ADD bin-linux-amd64/sphere-go-homecloud /opt/ninjablocks/sphere-go-homecloud/

# utils
ADD src/bin /opt/ninjablocks/bin
ADD bin-linux-amd64/mqtt-bridgeify /opt/ninjablocks/bin/

ADD sphere-config/config /opt/ninjablocks/config
ADD sphere-schemas /opt/ninjablocks/sphere-schemas

ADD src/system-services /etc/service
ADD src/ninja-services /home/ninja/service
RUN chown -R ninja.ninja /home/ninja/service

RUN mkdir -p /data/etc/avahi/services /data/etc/opt/ninja
RUN chown -R ninja.ninja /data

ADD src/redis.conf /etc/redis/redis.conf

RUN ln -s /opt/ninjablocks/bin/start /usr/sbin/start

VOLUME ["/data"]

CMD ["/sbin/my_init"]
ENV PATH="/opt/ninjablocks/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV NINJA_BOARD_TYPE="sphere"
ENV NINJA_OS_TAG="norelease"
ENV NINJA_OS_BUILD_TARGET="sphere-docker-hacking"
ENV NINJA_OS_BUILD_NAME="ubuntu_docker_trusty_norelease_sphere-hacking"

EXPOSE 1883 8000