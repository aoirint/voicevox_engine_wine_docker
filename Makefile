ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION=0.5.1
CMD=

build:
	docker build ./docker -t voicevox_engine_wine

run:
	docker run --rm -it \
		-e VERSION="${VERSION}" \
		-v "${ROOT_DIR}/work:/work" \
		-p '127.0.0.1:50021:50021' \
		voicevox_engine_wine ${CMD}
