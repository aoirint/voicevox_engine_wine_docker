.PHONY: build
build:
	docker buildx build . \
		-t voicevox_engine_wine

.PHONY: run
run:
	docker run --rm -it \
		voicevox_engine_wine

