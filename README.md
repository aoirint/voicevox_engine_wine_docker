# voicevox_engine_wine_docker

VOICEVOX EngineをLinux上で実行するためのDockerイメージ（ローカルビルド必須）。

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


## Simple Image
VOICEVOXのバイナリをDockerイメージに含めない版。容量節約ができる。

### Directory Structure
配布zipを解凍する。

`VOICEVOX {version}.zip`を解凍して、`run.exe`が存在する階層を`VOICEVOX`ディレクトリとして配置する。

```
├── cmd.sh
├── Dockerfile
├── Dockerfile.simple
├── Makefile
├── README.md
└── VOICEVOX
     ├── run.exe
     └── VOICEVOX.exe
```

### Usage

```shell
make build-simple

make run-simple
```
