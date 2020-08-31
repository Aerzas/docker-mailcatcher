FROM ruby:2.7.1-alpine3.12

RUN set -ex; \
    # Install dependencies
    apk add --no-cache libstdc++ sqlite-libs; \
    # Install build dependencies
    apk add --no-cache --virtual .build-deps build-base sqlite-dev; \
    # Install mailcatcher
    mkdir -p "${GEM_HOME}"; \
    gem install mailcatcher --version 0.7.1; \
    # Cleanup
    gem sources --clear-all; \
    apk del .build-deps; \
    # Execute gems as any user
    chgrp -R 0 "${GEM_HOME}"; \
    chmod -R g+rwX "${GEM_HOME}"

USER 1001

COPY scripts/*.sh /scripts/

WORKDIR "${GEM_HOME}"

EXPOSE 1025
EXPOSE 1080

CMD ["mailcatcher", "--no-quit", "--foreground", "--ip=0.0.0.0"]
