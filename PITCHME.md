### Vueとrailsを使った開発
---
### 自己紹介
**名前**：ゆうき      

**仕事**：現在Webの受託開発としてフロントをメインで触ってます。

先月SES会社から転職し、 
7/16(木)入社

---
### 実際に作ったもの

<a href="https://yojigen-app.herokuapp.com/" target="_blank">リンク</a>

---
### 初期構想

仕事にジョインしたてだったのでついて行けるように全ての技術を詰め込もう

Vue, Vuex, Typescript, Rails, Docker, AWS

---
### 実際に使った技術

Vue, Rails, AWS

---
### 進め方
---

DBの設計をする
↓
バックエンドを簡単に作る
↓
フロントを作る

---
### つまるポイント
---
webpackとwebpackerどっちにする問題

---
JavaScriptモジュールバンドラー

html, css, javascript, imgなどを一つのjavascriptにまとめてくれるツール

---
### webpackerとは
---
railsのgemのひとつ
railsでwebpackを使いやすくラッパーしたもの
version6以降では標準実装
---


### そもそもwebpackって？
---

---
- build済みindex.htmlを返す
- データベースから返ってきたjsonを返す
<img src="gitpitch-img/productimg.png"/>  
---?code=server.js&lang=javascript&title=server.js

@[15](buildしたフロントページを返す)
---?code=server.js&lang=javascript&title=server.js

@[72-86](データベースに書き込み、jsonを返す)
---
フォルダ構成
<img src="gitpitch-img/folder.png"/>  

---
### ER図(テーブル)
<img src="gitpitch-img/table.png"/>  
---
### つまり
- １つのスレッドには0 or 複数のコメント、いいねが結びついている |
- スレッド、コメント、いいねは[user_id]を紐付けて、誰がしたか分かる |

---
### フロント側画面構成
<table>
<thead>
<tr>
<td>URL</td>
<td>表示条件</td>
</tr>
</thead>
<tbody>
<tr>
<td>/</td>
<td>誰でもみれる</td>
</tr>
<tr>
<td>/thread/comment:id</td>
<td>誰でもみれる</td>
</tr>
<tr>
<td>/login</td>
<td>未ログインのみ</td>
</tr>
<tr>
<td>/signup</td>
<td>未ログインのみ</td>
</tr>
<tr>
<td>/thread/create</td>
<td>ログイン済みのみ</td>
</tr>
<tr>
<td>/thread/edit/:id</td>
<td>ログイン済みのみ</td>
</tr>
<tr>
<td>合計</td>
<td>6画面</td>
</tr>

</tbody>
</table>
---
### Q. どうやって振り分けるか
- A. ログインしているかどうか => accessToken |


---?code=yojigen-app/src/components/User.js&lang=javascript&title=login or not
@[2](ローカルストレージにtokenがあるかどうか判定)

---?code=yojigen-app/src/components/GuestRoute.js&lang=javascript&title=not
@[9-12](accessTokenがないならlogin/signupページをロードできる)

---?code=yojigen-app/src/components/PrivateRoute.js&lang=javascript&title=login
@[9-12](accessTokenがあるならcreate/editページをロードできる)

---
### 本番デプロイ時

---
### コード側
* Express側
  * Procfileの作成(Expressサーバーの起動コマンド)
  * .envファイルに環境変数を記載
* React側
  * static.jsonの作成(heroku標準のwebpackから切り替えるため)
---
<img src="gitpitch-img/folder2.png"/>  

---?code=package.json&lang=javascript&title=package.json
@[8](デプロイ時にReactのコードをbuildするように設定)

---?code=server.js&lang=javascript&title=server.js

@[385-387](これがないとlocalでは動くが、本番環境では動かない)

---
最後までありがとうございました。