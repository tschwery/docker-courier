FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

RUN apk add --no-cache --virtual .fetch-deps \
        dovecot

ENV GROUPID 1000
ENV USERID 1000
ENV GROUPNAME smtp
ENV USERNAME smtp
ENV USER_HOME /home/smtp

RUN addgroup -g ${GROUPID} -S ${USERNAME}
RUN adduser -S -G ${USERNAME} -u ${USERID} -s /bin/bash -h ${USER_HOME} ${USERNAME}

ADD start.sh /start.sh

COPY conf.d /etc/dovecot/conf.d/

# expose only imap port
EXPOSE 143

ENTRYPOINT ["/start.sh"]
CMD ["dovecot", "-F"]
