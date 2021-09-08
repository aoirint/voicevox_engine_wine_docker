ARG BASE_IMAGE=ubuntu:bionic
FROM ${BASE_IMAGE} AS ubuntu-base

ARG DEBIAN_FRONTEND=noninteractive
ARG WINE_BRANCH=stable
ARG WINEARCH=win64

ARG FAUDIO_X86=https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/i386/libfaudio0_19.07-0~bionic_i386.deb
ARG FAUDIO_X64=https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/amd64/libfaudio0_19.07-0~bionic_amd64.deb

# Install FAudio
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wget && \
    wget "${FAUDIO_X86}" -O /tmp/faudio_x86.deb && \
    wget "${FAUDIO_X64}" -O /tmp/faudio_x64.deb && \
    apt-get --fix-broken install -y /tmp/faudio_x86.deb /tmp/faudio_x64.deb && \
    rm /tmp/faudio_x86.deb /tmp/faudio_x64.deb

# Install Wine HQ
RUN apt-get update && apt-get install -y software-properties-common && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key -O - | apt-key add && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt-get install -y \
        winehq-${WINE_BRANCH}

# Install Winetricks
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P /usr/local/bin/ && \
    chmod +x /usr/local/bin/winetricks

RUN apt-get update && \
    apt-get install -y \
        gosu \
        libvulkan1 \
        binutils \
        cabextract \
        unzip \
        lsof \
        xvfb \
        winbind \
        p7zip && \
    useradd -m user

RUN gosu user winetricks win10

RUN gosu user xvfb-run \
        sh -c 'wineboot && winetricks -q dotnet472; wineserver -w'

ADD ./scripts/cmd.sh /scripts/cmd.sh
ADD ./scripts/user.sh /scripts/user.sh

WORKDIR /work

USER root
ENTRYPOINT []
CMD [ "/scripts/cmd.sh" ]


FROM ubuntu-base AS ubuntu-gui

RUN apt-get update && \
    apt-get install -y \
        pulseaudio \
        wait-for-it

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get install -y \
        language-pack-ja \
        fontconfig \
        fonts-noto-cjk \
        ttf-mscorefonts-installer && \
    fc-cache -fv && \
    update-locale LANG=ja_JP.UTF-8

RUN rm -f /tmp/.X99-lock && \
    gosu user winetricks msxml6 mfc40

ADD ./scripts/gui.sh /scripts/gui.sh

CMD [ "/scripts/gui.sh" ]
