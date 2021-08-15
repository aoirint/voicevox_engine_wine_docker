# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:focal AS build-env

ARG VOICEVOX_URL=https://drive.google.com/uc?id=11dY5hkjWQaKK4B3afnd5wyYZbj7fFwtJ

RUN <<EOF
    apt-get update
    apt-get install -y \
        unzip \
        language-pack-ja-base
EOF

#RUN pip3 install \
#        gdown>=3.13.0

WORKDIR /work
#RUN <<EOF
#    gdown -O ./VOICEVOX.zip "${VOICEVOX_URL}"
#    unzip ./VOICEVOX.zip
#EOF

ADD ./VOICEVOX.zip /work/
RUN LANG=ja_JP.UTF-8 unzip -O cp932 -d /opt/VOICEVOX -j -o ./VOICEVOX.zip


FROM aoirint/wine:ubuntu-devel-v20210802a AS runtime-env
COPY --from=build-env /opt/VOICEVOX /opt/VOICEVOX

ADD ./cmd.sh /

WORKDIR /opt/VOICEVOX
USER root
ENTRYPOINT []
CMD [ "/cmd.sh" ]
