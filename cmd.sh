#!/bin/bash
rm /tmp/.X99-lock || true
gosu user xvfb-run wine ./run.exe --host 0.0.0.0

