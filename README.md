# TIME-SNS

現代風SNSアプリ :envelope:

## 説明

- メッセージ機能
- フレンド検索機能
- フォロー機能
- グループ機能
- 非同期通信での送信、更新

# TIME-SNS DB設計
## usersテーブル
Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|image|string|null: false|
|content|text|null: false|
### Association
- has_many :group_users
- has_many :groups, through:  :group_users
- has_many :groupmessages
- has_many :friend_users
- has_many :friends, through: :friend_users
- has_many :directmessages
- has_many :follows

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|image|string|null: false|
### Association
- has_many :group_users
- has_many :users, through:  :group_users
- has_many :groupmessages

## group_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group

## groupmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
|content|text|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to : group

## friendsテーブル
|Column|Type|Options|
|------|----|-------|
### Association
- has_many :friend_users
- has_many :users, through:  :friend_users
- has_many :directmessages

## friend_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|friend_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :friend

## directmessagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
|content|text|
|user_id|integer|null: false, foreign_key: true|
|friend_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :friend

## followsテーブル
|Column|Type|Options|
|------|----|-------|
|followable_id|integer|null: false, foreign_key: true|
|follower_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :followable
- belongs_to :follower