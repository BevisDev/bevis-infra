FROM alpine:3.23

ENV TZ=Asia/Ho_Chi_Minh

RUN apk add --no-cache tzdata \
 && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone
