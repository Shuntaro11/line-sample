# TIME-SNS

現代風SNSアプリ :envelope:

## 説明

- メッセージ機能
- メールアドレスでのフレンド検索機能
- フォロー機能
- グループ機能
- 非同期通信での送信、更新

## ログインパスワード
- email：gest@gmail.com
- password：gestgest

## デモイメージ
<img width="1280" alt="timedemo1" src="https://user-images.githubusercontent.com/59483718/76161931-57323000-617b-11ea-8cac-723aa2281fb5.png">

<img width="1280" alt="timedemo1" src="https://user-images.githubusercontent.com/59483718/76161935-631df200-617b-11ea-9b21-a981267a607c.jpg">

<img width="1280" alt="timedemo3" src="https://user-images.githubusercontent.com/59483718/76161944-77fa8580-617b-11ea-93d0-7906c7d814ef.png">

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