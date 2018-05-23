FROM library/alpine

MAINTAINER Andy Savage <andy@savage.hk>

LABEL org.label-schema.name="docker-alpine-s6-overlay" \
      org.label-schema.description="Base alpine image with S6 Overlay" \
      org.label-schema.vcs-url="https://github.com/hongkongkiwi/docker-alpine-s6" \
      org.label-schema.license="MIT"

ARG S6_VERSION="1.21.4.0"
ARG S6_ARCH="amd64"

RUN echo "Installing Packages" \
 && apk update \
 && apk add --no-cache \
          bash tar

ADD "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" /tmp/
RUN echo "Installing S6 Overlay" \
  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN echo "Cleaning Up" \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/*

ENTRYPOINT ["/init"]
