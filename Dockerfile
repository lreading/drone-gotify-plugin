FROM        alpine:3.14
ADD         gotify.sh /bin/
RUN         chmod +x /bin/gotify.sh
RUN         apk -Uuv add --no-cache curl ca-certificates
ENTRYPOINT  /bin/gotify.sh
