FROM moby/buildkit:v0.30.0-rootless

USER root

LABEL maintainer="dev.binhtt@vietcredit.com.vn"

RUN apk add --no-cache \
    git \
    bash \
    make \
    openssh-client \
    ca-certificates \
    curl

ENV BUILDKITD_FLAGS=--oci-worker-no-process-sandbox
ENV HOME=/home/appuser
ENV XDG_RUNTIME_DIR=/tmp/xdg-runtime

RUN mkdir -p /home/appuser \
             /home/user/.local/tmp \
             /home/user/.local/share/buildkit \
             /tmp/xdg-runtime \
    && chown -R 1000:1000 /home/appuser /home/user /tmp/xdg-runtime

USER 1000

WORKDIR $HOME

CMD ["sh"]
