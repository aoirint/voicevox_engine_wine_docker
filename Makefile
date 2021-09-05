ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
CMD=

build:
	docker build ./docker -t voicevox_engine_wine:lite

run:
	docker run --rm -it \
		-v "${ROOT_DIR}/tmp:/work/tmp" \
		-v "/tmp/.X11-unix:/tmp/.X11-unix" \
		-e DISPLAY \
		voicevox_engine_wine:lite ${CMD}

# .PHONY: build
# build:
# 	docker buildx build . \
# 		-t voicevox_engine_wine \
# 		--target runtime-env

# .PHONY: run
# run:
# 	docker run --rm -it \
# 		-p '127.0.0.1:50021:50021' \
# 		voicevox_engine_wine $(CMD)


# .PHONY: build-simple
# build-simple:
# 	docker buildx build . \
# 		-t voicevox_engine_wine_simple \
# 		-f ./Dockerfile.simple

# .PHONY: run-simple
# run-simple:
# 	docker run --rm -it \
# 		-v '$(ROOT_DIR)/VOICEVOX:/opt/VOICEVOX' \
# 		-p '127.0.0.1:50021:50021' \
# 		voicevox_engine_wine $(CMD)
