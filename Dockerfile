# syntax=docker/dockerfile:1.3-labs
FROM python:3.9 AS build-env

ARG VOICEVOX_URL=https://drive.google.com/uc?id=11dY5hkjWQaKK4B3afnd5wyYZbj7fFwtJ

RUN <<EOF
    apt-get update
    apt-get install -y \
        unzip
EOF

RUN pip3 install \
        gdown>=3.13.0

WORKDIR /work
#RUN <<EOF
#    wget -O /dev/null --save-cookies ./cookie "${VOICEVOX_URL}"
#    CONFIRM="$(awk '/_warning_/ {print $NF}' ./cookie)"
#    echo $CONFIRM
#    wget -O ./voicevox.zip --load-cookies ./cookie "${VOICEVOX_URL}&confirm=${CONFIRM}"
#    rm ./cookie
#EOF

RUN <<EOF
    gdown -O ./voicevox.zip "${VOICEVOX_URL}"
    unzip ./voicevox.zip
EOF

FROM aoirint/wine:nvidia-devel-v20210804a AS runtime-env
COPY --from=build-env /work/voicevox /opt/voicevox

