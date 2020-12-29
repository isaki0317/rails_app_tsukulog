# TSUKULOG(つくログ)

### サイト概要
DIYの成果や情報をSNS形式で気軽にシェアするアプリです。
仲間同士でシェアすることで、日常に「楽しい」「活気」「笑顔」を増やす手助けができるアプリになっています。

### サイトテーマ
未経験者～上級者まで、全ての利用者の日常をより豊かにするためのオンラインプラットフォームです。

### テーマを選んだ理由
DIYに関しての雑誌特集はよく見かけるようになりましたが、いざ取り組む際に面倒くさくなってしまったり気軽にアドバイスやアイデアを共有でいる場がありませんでした。
私もDIYの経験はあるものの、気軽に情報を得られる機会や手段があればもっと早い段階から取り組んでいたのでは？という考えからこのテーマにしました。

### ターゲットユーザ
・オリジナルの家具やアイテムを自作したい人。<br>
・DIYに興味があるけど、なかなか始められない人。<br>
・DIYの楽しさや成果を共有したい人。<br>
・DIYを通して仲間や友達を作りたい人。

### 主な利用シーン
・DIYで作成した成果物の写真や工程を共有できます。<br>
・豊富な検索、並び替え条件から投稿を絞り込むことができます。<br>
・フォローしたユーザーとDMで直接やり取りができます、DIYをきっかけとして新たな友人に出会えるかもしれせん。

### 機能一覧・設計図
###### 機能一覧
 https://docs.google.com/spreadsheets/d/1i7w0K9miIVeMCW5Xw7jBwlSvwkMNjEt_FOvWAdbosvs/edit?usp=sharing
###### ER図
 https://drive.google.com/file/d/1wnwKP0v4uMlW8p6hq26SZ2CkRc-UpVtO/view?usp=sharing

### 環境・使用技術
#### 開発環境
- OS：Linux(CentOS)
- DB : Sqlite3
- IDE：Cloud9
#### フロントエンド
- Bootstrap 3.3.6
- SCSS (BEM)
- JavaScript、jQuery、Ajax
#### バックエンド
- Ruby 2.6.3
- Rails 5.2.4.4
#### 本番環境
- AWS (EC2、RDS for MySQL、Route53、S3)
- MySQL2
- Nginx、 Puma
#### テスト
- Rspec (Jsのテスト含む） 計200以上
- GithubActions(CI/CD)
#### その他主な使用技術
- 非同期通信 (フォロー・いいね・ブックマーク・お問合せ・ジャンル作成・ブロック解除・DM・プレビュー機能・エラーメッセージ他)
- Action Mailer
- whenever （定時処理）
- HTTPS接続 (Certbot)
- Rubocop-airbnb
- 例外処理(ブロック機能createアクション時の[フォロー解除・過去の通知削除・トークルーム削除]をTransactionで一括りにしています)
- プレースホルダ(SQLインジェクション対策を意識)

### Qiita
https://qiita.com/IsakiMatsuo