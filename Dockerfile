# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:bionic AS build-env

ARG VOICEVOX_URL=https://drive.google.com/uc?export=download&id=11dY5hkjWQaKK4B3afnd5wyYZbj7fFwtJ

RUN <<EOF
    apt-get update
    apt-get install -y \
        unzip \
        wget
EOF

WORKDIR /work
RUN <<EOF
    wget -O /dev/null --save-cookies ./cookie "${VOICEVOX_URL}"
    CONFIRM="$(awk '/_warning_/ {print $NF}' ./cookie)"
    echo $CONFIRM
    wget -O ./voicevox.zip --load-cookies ./cookie "${VOICEVOX_URL}&confirm=${CONFIRM}"
    rm ./cookie
EOF

RUN unzip ./voicevox.zip

FROM aoirint/wine:nvidia-devel-v20210804a AS runtime-env
COPY --from=build-env /work/voicevox /opt/voicevox

