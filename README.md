A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).


## Dart側

```shell
# brew でインストール。freezedとの関係で少し前のバージョンを実行
brew install dart@2.12

# お決まりの
pub get

# GitHub API からJSONに情報を吐き出す (数分かかります！)
export GITHUB_TOKEN=your-github-token # 必須
export TARGET_ORGANIZATION=bizreach-inc
export TARGET_REPOSITORY=hrmony-prf
export BACK_MONTH=0 # 当月より何ヶ月前から取得するか
export MONTH_SPAN=6 # どこまでさかのぼって取得するか
dart bin/nuno.dart

# JSONからCSVに情報を変更する
export IN_FILE=./web/public/out.json
export OUT_FILE=./web/public/out_tabled.csv
dart bin/nuno_tabler.dart

# テストもしよう
dart test --reporter expanded
```

※ なお、IntelliJで求められれるSDKのパスは `/usr/local/opt/dart/libexec`
