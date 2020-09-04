FROM alpine:3.12

RUN apk update && apk add tini bash mc git rsync nano mosquitto-clients dropbear-ssh  dropbear-scp   \
    dropbear openssh-sftp-server screen docker docker-compose monit e2fsprogs e2fsprogs-extra lsblk \
    lsof strace 
RUN echo root:harcpass | chpasswd && mkdir /data

COPY daemon.json /etc/docker/
COPY start.sh /
RUN chmod +x /start.sh
ENV DOCKER_HOST="unix:///var/run/docker.sock"
RUN touch /data/test
VOLUME [ "/data" ]

ENV GITSTACK="https://github.com/fcasarsa/harc"
ENV EXT_STORAGE="/dev/sdc1"

ENTRYPOINT ["/sbin/tini", "--"]
CMD /start.sh


