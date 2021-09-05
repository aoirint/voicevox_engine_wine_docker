#!/bin/bash

set -ex

# /work
rm -f /tmp/.X99-lock

if [ ! -d "/opt/VOICEVOX/" ]; then
    TMPROOT="/work/tmp/"
    VERSION="0.4.1"

    FILENAME_INSTALLER="VOICEVOX.Web.Setup.${VERSION}.exe"
    FILENAME_ARCHIVE0="voicevox-${VERSION}-x64.nsis.7z.0"
    FILENAME_ARCHIVE1="voicevox-${VERSION}-x64.nsis.7z.1"
    FILENAME_ARCHIVE2="voicevox-${VERSION}-x64.nsis.7z.2"

    URL_INSTALLER="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_INSTALLER}"
    URL_ARCHIVE0="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE0}"
    URL_ARCHIVE1="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE1}"
    URL_ARCHIVE2="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE2}"

    DEST_INSTALLER="${TMPROOT}/${FILENAME_INSTALLER}"
    DEST_ARCHIVE0="${TMPROOT}/${FILENAME_ARCHIVE0}"
    DEST_ARCHIVE1="${TMPROOT}/${FILENAME_ARCHIVE1}"
    DEST_ARCHIVE2="${TMPROOT}/${FILENAME_ARCHIVE2}"

    mkdir -p "${TMPROOT}"

    if [ ! -f "${DEST_INSTALLER}" ]; then
        echo "Downloading VOICEVOX ${VERSION} Installer..."
        wget -nv -O "${DEST_INSTALLER}" "${URL_INSTALLER}"
    fi
    # if [ ! -f "${DEST_ARCHIVE0}" ]; then
    #     echo "Downloading VOICEVOX Archive 0..."
    #     wget -nv -O "${DEST_ARCHIVE0}" "${URL_ARCHIVE0}"
    # fi
    # if [ ! -f "${DEST_ARCHIVE1}" ]; then
    #     echo "Downloading VOICEVOX Archive 1..."
    #     wget -nv -O "${DEST_ARCHIVE1}" "${URL_ARCHIVE1}"
    # fi
    # if [ ! -f "${DEST_ARCHIVE2}" ]; then
    #     echo "Downloading VOICEVOX Archive 2..."
    #     wget -nv -O "${DEST_ARCHIVE2}" "${URL_ARCHIVE2}"
    # fi

    # WINTMPROOT="/home/user/.wine/drive_c/users/user/Temp/"
    # cp "${DEST_ARCHIVE0}" "${WINTMPROOT}"
    # cp "${DEST_ARCHIVE1}" "${WINTMPROOT}"
    # cp "${DEST_ARCHIVE2}" "${WINTMPROOT}"

    echo "Installing VOICEVOX..."
    # WINEDEBUG=-all
    gosu user wine "${DEST_INSTALLER}"
fi

rm -f /tmp/.X99-lock
cd ./VOICEVOX
gosu user xvfb-run wine ./run.exe --host 0.0.0.0
