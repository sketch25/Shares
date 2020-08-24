# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,  unique: true|
|nickname|string|null: false|
|icon|string||
|profile|text||
|mail|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :users,through:Relationship

## Relationshipテーブル
|Column|Type|Options|
|------|----|-------|
|follow_id|references|null: false, foreign_key: true|
|follower_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|title|string|null: false|
|content|text|null: false|
|type|string|null: false|

### Association
- belongs_to :user
- has_many :comments
- has_many :likes
- has_many :post_tags
- has_many :tags,through:posts_tags

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :post

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|
|content|text|null: false|

### Association
- belongs_to :user
- belongs_to :post

## post_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|post_id|references|null: false, foreign_key: true|
|tag_id|references|null: false, foreign_key: true|

### Association
- belongs_to :post
- belongs_to :tag

## tagsテーブル
|Column|Type|Options|
|------|----|-------|
|tag|string|null: false|

### Association
- has_many :posts_tags
- has_many :posts,through:post_tags