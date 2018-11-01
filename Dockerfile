FROM alpine

ENV ORGANISATION_NAME "Example Ltd"
ENV SUFFIX "dc=example,dc=com"
ENV ROOT_USER "admin"
ENV ROOT_PW "password"
ENV USER_UID "test"
ENV USER_GIVEN_NAME "test"
ENV USER_SURNAME "测试"
ENV USER_EMAIL "test@example.com"
ENV ACCESS_CONTROL "access to * by * read"
ENV LOG_LEVEL "stats"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk add --update openldap openldap-back-mdb openldap-clients openldap-back-monitor   bash tzdata ca-certificates   sudo && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    echo "Asia/Shanghai" > /etc/timezone && \
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    rm -rf /var/cache/apk/*   /tmp/*  

COPY scripts/* /etc/openldap/
COPY docker-entrypoint.sh /

EXPOSE 389
EXPOSE 636

VOLUME ["/ldif", "/var/lib/openldap/openldap-data"]

ENTRYPOINT ["/docker-entrypoint.sh"]
