FROM        alpine:3.14
RUN         apk -Uuv add --no-cache curl ca-certificates
ADD         gotify.sh /bin/
RUN         chmod +x /bin/gotify.sh
ENTRYPOINT  /bin/gotify.sh
