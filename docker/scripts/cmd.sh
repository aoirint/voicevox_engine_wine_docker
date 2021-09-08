#!/bin/bash

set -ex

# /work
rm -f /tmp/.X99-lock

mkdir -p /work/tmp /work/voicevox
chown -R user:user /work

gosu user bash /scripts/user.sh

rm -f /tmp/.X99-lock
cd /work/voicevox
gosu user xvfb-run wine ./run.exe --host 0.0.0.0
