.PHONY: build
build:
	docker buildx build . \
		-t voicevox_engine_wine

.PHONY: run
run:
	docker run --rm -it \
		-p '127.0.0.1:50021:50021' \
		voicevox_engine_wine

