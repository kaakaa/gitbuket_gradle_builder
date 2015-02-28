gitbucket_gradle_builder
========================

GitBucketのWebHookを受けると`gradlew build`する

起動
----

```
bundle install --path vendor/bundle
bundle exec ruby app.rb
```

設定
----

* GitBucketのWebHookに `/hook` を登録する
![GitBucketの設定](https://raw.githubusercontent.com/kaakaa/gitbuket_gradle_builder/master/gitbuket_stting.png "GitBucketの設定")

* あとはコミットすれば、勝手に`git clone`、もしくは既に`git clone`してあれば`git pull`して、`gradle build`する

微妙なところ
============

* 実行するタスクは `gradlew build` 固定
  * なので、Windows上では動かない
* gitでブランチ切った時の動きは未確認
* `git clone` してきたものを削除するには手で削除しなきゃいけない
* Jenkinsで良くね？

