ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION = 0.5.1
CMD=

.PHONY: build
build:
	docker build ./docker \
		-t voicevox_engine_wine \
		--target ubuntu-base

.PHONY: run
run:
	docker run --rm -it \
		-e VERSION="${VERSION}" \
		-v "${ROOT_DIR}/work:/work" \
		-p '127.0.0.1:50021:50021' \
		voicevox_engine_wine ${CMD}

.PHONY: build-gui
build-gui:
	docker build ./docker \
		-t voicevox_engine_wine:gui \
		--target ubuntu-gui \
		--build-arg BASE_IMAGE=nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

.PHONY: run-gui
run-gui:
	docker run --rm -it \
		-e VERSION="${VERSION}" \
		-v "${ROOT_DIR}/work:/work" \
		-e DISPLAY \
		-v "/tmp/.X11-unix:/tmp/.X11-unix" \
		-e LANG=ja_JP.UTF-8 \
		--group-add "$(shell getent group audio | cut -d: -f3)" \
		-e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
		-v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native" \
		-v "${HOME}/.config/pulse/cookie:/pulseaudio/cookie" \
    -e "HOST_UID=$(shell id -u)" \
    -e "HOST_GID=$(shell id -g)" \
		--shm-size 8GB \
		--gpus all \
		voicevox_engine_wine:gui ${CMD}
