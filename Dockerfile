# syntax=docker/dockerfile:1.3-labs
FROM python:3.9 AS build-env

ARG VOICEVOX_URL=https://drive.google.com/uc?id=11dY5hkjWQaKK4B3afnd5wyYZbj7fFwtJ

RUN <<EOF
    apt-get update
    apt-get install -y \
        unzip
EOF

#RUN pip3 install \
#        gdown>=3.13.0

WORKDIR /work
#RUN <<EOF
#    gdown -O ./voicevox.zip "${VOICEVOX_URL}"
#    unzip ./voicevox.zip
#EOF

ADD ./voicevox.zip /work/
RUN unzip ./voicevox.zip


FROM aoirint/wine:ubuntu-devel-v20210802a AS runtime-env
COPY --from=build-env /work/VOICEVOX /opt/voicevox

ADD ./cmd.sh /

WORKDIR /opt/voicevox
USER root
ENTRYPOINT []
CMD [ "/cmd.sh" ]

