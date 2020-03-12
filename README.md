# TIME-SNS
現代風SNSアプリ

## 説明
友達とのダイレクトメッセージやグループでのチャットが楽しめる！

## お試し用ログインパスワード
- email：gest@gmail.com
- password：gestgest
- アプリURL https://timesns.herokuapp.com/

## 実装した機能

- ログイン機能
- 非同期通信でのメッセージ送信
- 非同期通信での最新メッセージ更新
- ページネーション
- フォロー機能
- メールアドレスでのフレンド検索機能
- グループ機能

## 使用した技術

- Haml, SCSS(フロント)
- Ruby on rails, jQuery(サーバー)
- mySQL(ローカル環境・テスト環境のデータベース)
- rspecによるモデル、コントローラーの単体テスト(異常値も含む)
- Rubocopによるコード解析
- CircleCIによるテストの自動化
- master変更時、CircleCIによる自動デプロイ
- Heroku(本番環境)
- postgresql(本番環境のデータベース)
- S3(本番環境の画像保存先)

## デモイメージ
<img width="1280" alt="timedemo1" src="https://user-images.githubusercontent.com/59483718/76161931-57323000-617b-11ea-8cac-723aa2281fb5.png">

<img width="1280" alt="timedemo1" src="https://user-images.githubusercontent.com/59483718/76161935-631df200-617b-11ea-9b21-a981267a607c.jpg">

<img width="1280" alt="timedemo3" src="https://user-images.githubusercontent.com/59483718/76161944-77fa8580-617b-11ea-93d0-7906c7d814ef.png">

<img width="1280" alt="timedemo3" src="https://user-images.githubusercontent.com/59483718/76162269-6d41ef80-617f-11ea-9c7d-75e731ad4e33.jpg">

<img width="1280" alt="timedemo5" src="https://user-images.githubusercontent.com/59483718/76162377-7f705d80-6180-11ea-963c-8b4a4730a415.png">

## ER図
<img width="742" alt="timeerd" src="https://user-images.githubusercontent.com/59483718/76161915-294ceb80-617b-11ea-9971-225504012183.png">

## TIME-SNS DB設計
### usersテーブル
Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|image|string|
|content|text|
#### Association
- has_many :group_users
- has_many :groups, through:  :group_users
- has_many :groupmessages
- has_many :friend_users
- has_many :friends, through: :friend_users
- has_many :directmessages
- has_many :follows

### groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|image|string|
#### Association
- has_many :group_users
- has_many :users, through:  :group_users
- has_many :groupmessages

### group_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :group

### groupmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
|content|text|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to : group

### friendsテーブル
|Column|Type|Options|
|------|----|-------|
#### Association
- has_many :friend_users
- has_many :users, through:  :friend_users
- has_many :directmessages

### friend_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|friend_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :friend

### directmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
|content|text|
|user_id|integer|null: false, foreign_key: true|
|friend_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :friend

### followsテーブル
|Column|Type|Options|
|------|----|-------|
|followable_id|integer|null: false, foreign_key: true|
|follower_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :followable
- belongs_to :follower