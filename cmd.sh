#!/bin/bash
rm -f /tmp/.X99-lock
cd ./VOICEVOX
gosu user xvfb-run wine ./run.exe --host 0.0.0.0
