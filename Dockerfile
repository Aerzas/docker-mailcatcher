FROM ruby:3.4.3-alpine3.21

RUN set -ex; \
    # Install build dependencies
    apk add --no-cache --virtual .build-deps build-base sqlite-dev; \
    # Install runtime dependencies
    apk add --no-cache libstdc++; \
    # Install dependencies
    mkdir -p "${GEM_HOME}"; \
    gem install sqlite3 --version 1.7.3 --platform=ruby; \
    # Install mailcatcher
    gem install mailcatcher --version 0.10.0; \
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
