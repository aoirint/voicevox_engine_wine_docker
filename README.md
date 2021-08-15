# voicevox_engine_wine_docker

## Normal Image
VOICEVOXのバイナリをDockerイメージに含める版。可搬性が高い。

### Directory Structure
配布zipを解凍せずに`VOICEVOX.zip`として配置する。

```
├── cmd.sh
├── Dockerfile
├── Dockerfile.simple
├── Makefile
├── README.md
├── VOICEVOX.zip
```

### Usage

```shell
make build

make run
```
