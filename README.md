## 剣道試合表管理ツール

## 使ってる技術 Vue Rails(ver5)

### こだわりポイント
* Vueはコンポーネント設計で作った。

### 今後の改良
* エラーハンドリング
* 環境をドッカーで作る

### ローカル環境構築

* gitをクローンする
```
$ git clone git@github.com:satouyuuki/rails-kendo.git
```
* ディレクトリ移動
```
$ cd rails-kendo
```
* gemをインストール
```
$ bundle install --without production
```
* マイグレーション
```
rails db:migrate RAILS_ENV=development
```
* ダミーデータを挿入
```
rails db:migrate RAILS_ENV=development
```
* ローカルサーバ立ち上げ
```
rails s
```