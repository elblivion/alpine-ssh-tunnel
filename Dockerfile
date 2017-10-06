FROM alpine:3.3
MAINTAINER Anthony Stanton <anthony.stanton@gmail.com>
LABEL Description="Easy to use SSH Tunnel based in the Alpine Linux docker image"

ENV EXTRA_FLAGS="-nNT" \
    SSH_PORT=22

RUN apk --update add openssh-client \
    && rm -f /var/cache/apk/*

# Security fix for CVE-2016-0777 and CVE-2016-0778
RUN echo -e 'Host *\nUseRoaming no' >> /etc/ssh/ssh_config

ADD start.sh app/

RUN chmod +x /app/start.sh

RUN adduser -h /home/sshuser -u 2000 -D sshuser
ENV ID_FILE=/home/sshuser/.ssh/id_rsa
USER sshuser
RUN mkdir $HOME/.ssh

ENTRYPOINT ["/app/start.sh"]
