#!/bin/bash

set -ex

if [ ! -f "/work/voicevox/run.exe" ]; then
    TMPROOT="/work/tmp"
    INSTALLROOT="/work/voicevox"
    VERSION="0.5.0"

    FILENAME_ARCHIVE0="voicevox-${VERSION}-x64.nsis.7z.0"
    FILENAME_ARCHIVE1="voicevox-${VERSION}-x64.nsis.7z.1"
    FILENAME_ARCHIVE2="voicevox-${VERSION}-x64.nsis.7z.2"
    FILENAME_ARCHIVE_CAT="voicevox-${VERSION}-x64.7z"

    URL_ARCHIVE0="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE0}"
    URL_ARCHIVE1="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE1}"
    URL_ARCHIVE2="https://github.com/Hiroshiba/voicevox/releases/download/${VERSION}/${FILENAME_ARCHIVE2}"

    DEST_ARCHIVE0="${TMPROOT}/${FILENAME_ARCHIVE0}"
    DEST_ARCHIVE1="${TMPROOT}/${FILENAME_ARCHIVE1}"
    DEST_ARCHIVE2="${TMPROOT}/${FILENAME_ARCHIVE2}"
    DEST_ARCHIVE_CAT="${TMPROOT}/${FILENAME_ARCHIVE_CAT}"

    mkdir -p "${TMPROOT}"

    if [ ! -f "${DEST_ARCHIVE0}" ]; then
        echo "Downloading VOICEVOX archive 0..."
        wget -nv -c --show-progress  -O "${DEST_ARCHIVE0}.tmp" "${URL_ARCHIVE0}"
        mv "${DEST_ARCHIVE0}.tmp" "${DEST_ARCHIVE0}"
    fi
    if [ ! -f "${DEST_ARCHIVE1}" ]; then
        echo "Downloading VOICEVOX archive 1..."
        wget -nv -c --show-progress -O "${DEST_ARCHIVE1}.tmp" "${URL_ARCHIVE1}"
        mv "${DEST_ARCHIVE1}.tmp" "${DEST_ARCHIVE1}"
    fi
    if [ ! -f "${DEST_ARCHIVE2}" ]; then
        echo "Downloading VOICEVOX archive 2..."
        wget -nv -c --show-progress -O "${DEST_ARCHIVE2}.tmp" "${URL_ARCHIVE2}"
        mv "${DEST_ARCHIVE2}.tmp" "${DEST_ARCHIVE2}"
    fi

    echo "Concatenating archives..."
    cat "${DEST_ARCHIVE0}" "${DEST_ARCHIVE1}" "${DEST_ARCHIVE2}" > "${DEST_ARCHIVE_CAT}"

    echo "Extracting archives..."
    7zr x -o"${INSTALLROOT}" "${DEST_ARCHIVE_CAT}"
fi
