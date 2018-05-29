FROM library/alpine

MAINTAINER Andy Savage <andy@savage.hk>

LABEL org.label-schema.name="docker-alpine-s6-overlay" \
      org.label-schema.description="Base alpine image with S6 Overlay" \
      org.label-schema.vcs-url="https://github.com/hongkongkiwi/docker-alpine-s6" \
      org.label-schema.license="MIT"

ARG S6_VERSION="1.21.4.0"
ARG S6_ARCH="amd64"
ARG S6_URL="https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz"

ENV PGID=1001
ENV PUID=1001

ENV PS1="$(whoami)@$(hostname):$(pwd)\$ "
ENV HOME="/root"
ENV TERM="xterm"
ENV TZ="Asia/Hong_Kong"

RUN echo "Installing Packages" \
 && apk update \
 && apk add --no-cache \
          bash tar shadow \
 && mkdir -p \
    "/usr/local/include" \
    "/usr/lcoal/bin" \
    "/usr/lcoal/sbin" \
    "/root"

ADD "$S6_URL" "/tmp/s6-overlay-${S6_ARCH}.tar.gz"
RUN echo "Installing S6 Overlay" \
  && tar xzf "/tmp/s6-overlay-${S6_ARCH}.tar.gz" -C /
COPY s6/ /etc/

RUN echo "Adding User/Group" \
 && addgroup -g ${PGID} abc \
 && adduser -D -u ${PUID} -G abc abc

RUN echo "Cleaning Up" \
 && rm -rf /var/cache/apk/* /tmp/*

SHELL ["/bin/bash", "-c"]
WORKDIR ["$HOME"]

ENTRYPOINT ["/init"]
