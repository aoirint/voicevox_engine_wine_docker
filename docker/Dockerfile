ARG BASE_IMAGE=ubuntu:bionic
FROM ${BASE_IMAGE} AS ubuntu-base

ARG DEBIAN_FRONTEND=noninteractive

ARG FAUDIO_X86=https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/i386/libfaudio0_19.07-0~bionic_i386.deb
ARG FAUDIO_X64=https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/amd64/libfaudio0_19.07-0~bionic_amd64.deb

# Install FAudio
RUN apt-get update && \
    apt-get install -y \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget "${FAUDIO_X86}" -O /tmp/faudio_x86.deb && \
    wget "${FAUDIO_X64}" -O /tmp/faudio_x64.deb && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get --fix-broken install -y \
        /tmp/faudio_x86.deb \
        /tmp/faudio_x64.deb && \
    rm /tmp/faudio_x86.deb /tmp/faudio_x64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
        software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG WINE_BRANCH=devel
ARG WINE_VERSION=6.16~bionic-1

# Install Wine HQ
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key -O - | apt-key add && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt-get install -y \
        winehq-${WINE_BRANCH}=${WINE_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Winetricks
ARG WINETRICK_VERSION=20210825
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/${WINETRICK_VERSION}/src/winetricks -P /usr/local/bin/ && \
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
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m user

ARG WINEARCH=win64

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
        wait-for-it && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /tmp/.X99-lock && \
    gosu user xvfb-run \
        sh -c 'wineboot && winetricks -q vcrun2019; wineserver -w'

RUN rm -f /tmp/.X99-lock && \
    gosu user winetricks \
        fakejapanese

# RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
#     apt-get update && \
#     apt-get install -y \
#         language-pack-ja \
#         fontconfig \
#         fonts-noto-cjk \
#         ttf-mscorefonts-installer && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* && \
#     fc-cache -fv && \
#     update-locale LANG=ja_JP.UTF-8

# RUN rm -f /tmp/.X99-lock && \
#     gosu user winetricks msxml6 mfc40

ADD ./scripts/gui.sh /scripts/gui.sh

CMD [ "/scripts/gui.sh" ]
