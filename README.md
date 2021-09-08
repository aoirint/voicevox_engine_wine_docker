# voicevox_engine_wine_docker

VOICEVOX EngineをLinux・Wine上で実行するためのDockerイメージ。

初回起動時にWindows向けバイナリをダウンロード、実行する。

- https://github.com/Hiroshiba/voicevox
- https://github.com/Hiroshiba/voicevox/releases/tag/0.5.1

## Usage
```shell
# Dockerイメージのビルド
make

# Voicevox配布版のダウンロード・Voicevox Engineの起動
make run

# バージョン指定（GitHub Releasesのバージョン）
make run VERSION=0.5.1
```

`./work/tmp/`に配布版アーカイブ（`*.nsis.7z.*`）を配置すると、初回起動時のダウンロードを代替できる。

`./work/voicevox/0.5.1/run.exe`のように配布版アーカイブを（DLL等を含めて）解凍すると、初回起動時のダウンロード・解凍を代替できる。
