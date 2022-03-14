# MailCatcher

Minimalist MailCatcher docker container image that requires no specific user or root permission to function.

Docker Hub image: [https://hub.docker.com/r/aerzas/mailcatcher](https://hub.docker.com/r/aerzas/mailcatcher)

## Docker compose example

```yaml
version: '3.5'
services:
    php:
        image: aerzas/mailcatcher:latest
        ports:
            - '1025:1025'
            - '1080:1080'
        healthcheck:
            test: ["CMD", "/scripts/docker-healthcheck.sh"]
            interval: 30s
            timeout: 1s
            retries: 3
            start_period: 5s
```
