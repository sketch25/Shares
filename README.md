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
- has_many :goods
- has_many :good_posts, through: :goods, source: :post
- has_many :bads
- has_many :bad_posts, through: :bads, source: :post
- has_many :comgoods
- has_many :comgood_comments, through: :comgoods, source: :comment
- has_many :combad
- has_many :combad_comments, through: :combads, source: :comment
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user

## Relationshipテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|follow_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|title|string|null: false|
|content|text|null: false|
|type|string|null: false|
|hashtag|string||

### Association
- belongs_to :user
- has_many :comments
- has_many :goods
- has_many :good_users, through: :goods, source: :user
- has_many :bads
- has_many :bad_users, through: :bads, source: :user
- has_many :post_tags
- has_many :tags, through: :post_tags

## goodsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :post

## badsテーブル
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
- has_many :comgoods
- has_many :comgood_users, through: :comgoods, source: :user
- has_many :combads
- has_many :combad_users, through: :combads, source: :user

## comgoodsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :comment

## combadsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :comment

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
- has_many :posts,through:post_tags# Shares_beta
