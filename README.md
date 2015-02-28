gitbucket_gradle_builder
========================

起動
----

```
bundle install --path vendor/bundle
bundle exec ruby app.rb
```

設定
----


微妙なところ
============

* 実行するタスクは `gradle build` 固定
* gitでブランチ切った時の動きは未確認
* `git clone` してきたものを削除するには手で削除しなきゃいけない
* Jenkinsで良くね？
