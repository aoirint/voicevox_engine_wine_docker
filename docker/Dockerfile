FROM aoirint/wine:ubuntu-devel-v20210802a AS runtime-env

# TODO: wine install

RUN apt-get update && \
    apt-get install -y \
      p7zip

ADD ./scripts /scripts

WORKDIR /work

USER root
ENTRYPOINT []
CMD [ "/scripts/cmd.sh" ]
