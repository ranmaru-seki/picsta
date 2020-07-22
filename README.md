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

# English
[![Image from Gyazo](https://i.gyazo.com/630323f5d97d5117b06ca8539a24b16e.png)](https://gyazo.com/630323f5d97d5117b06ca8539a24b16e)  
This app enables you to show your photos to the world.

## Description
InstaClone is the Clone App of Instagram, written by Ruby, using Ruby on Rails, MySQL, jQuery.  
You can login/logout, post your photos, leave comments, like other user's photos, search users,  
follow your favorite users so your TimeLine only shows the photos of the users you're following.

## Features / Demo
- TimeLine only shows the photos of the users you're following.
- Mypage has all of your photos you have posted that will be lined up on your feed.
- Mypage shows you the lists of your followings and followers.
- Click the follow button on user's page to follow a user.
- You can search users by username at the top bar.
- Liked Photos page allows the user to see the photos he/she liked.
- You can leave comments under photos.

## Development Environment
Ruby 2.6.5  
Rails 5.2.4.3  
MySQL 14.14  
jQuery 1.12.4  

## Production environment
InstaClone is deployed on AWS  
IP：13.114.35.249

## Author
Ranmaru Seki  
Mail to: m78.seki.ranmaru@gmail.com
<br />
<br />
<br />

# 日本語
[![Image from Gyazo](https://i.gyazo.com/630323f5d97d5117b06ca8539a24b16e.png)](https://gyazo.com/630323f5d97d5117b06ca8539a24b16e)  
このアプリは、あなたが撮った写真を世界に公開するためのアプリです。

## 概要
InstaCloneはインスタグラムのクローンアプリです。Ruby、Ruby on Rails、jQuery、MySQLで書かれています。  
このアプリには、ログイン/ログアウト機能、投稿一覧ページ、写真投稿機能、投稿削除機能、コメント機能、いいね機能、
いいねした投稿ページ、ユーザーマイページ、フォロー/フォロー解除機能があります。  
ユーザーページにあるフォローボタンを押すことで、そのユーザーをフォローすることができます。  
フォローを解除したい場合は、もう一度同じボタンを押すことでフォローを解除することができます。  
あなたのタイムラインには、あなたがフォローしているユーザーの投稿のみが表示されます。

## 開発環境
Ruby 2.6.5  
Rails 5.2.4.3  
MySQL 14.14  
jQuery 1.12.4  

## 本番環境
AWSを用いてデプロイ済み。  
IP：13.114.35.249

## 特徴
### あなたのタイムラインには、あなたがフォローしているユーザーの投稿のみを表示します。
[![Image from Gyazo](https://i.gyazo.com/a214d27dec20cf88535ca7197d097ce8.gif)](https://gyazo.com/a214d27dec20cf88535ca7197d097ce8)  
<br />
<br />

### マイページには、あなたが過去に投稿した写真達が一覧で見やすく表示されています。
[![Image from Gyazo](https://i.gyazo.com/5a9eeaff20850e5a27d8ebaa9b768958.gif)](https://gyazo.com/5a9eeaff20850e5a27d8ebaa9b768958)  
<br />
<br />

### ユーザページからワンクリックでユーザーをフォローすることができます。
### トップバーにある検索ボックスから、世界中のユーザーをす検索することが可能です。
[![Image from Gyazo](https://i.gyazo.com/d751f1c66c8768eb12c89e08292f2d8f.gif)](https://gyazo.com/d751f1c66c8768eb12c89e08292f2d8f)  
<br />
<br />

### いいねした投稿ページでは、そのユーザーがどんな投稿をいいねしているのか見ることができます。
[![Image from Gyazo](https://i.gyazo.com/29682d4e87daa9886e2ff2689b5a5437.gif)](https://gyazo.com/29682d4e87daa9886e2ff2689b5a5437)  
<br />
<br />

### 投稿の詳細ページから、コメントを残すことが可能です。
[![Image from Gyazo](https://i.gyazo.com/27e1daebcfaaac4154fe1b9524b6479e.gif)](https://gyazo.com/27e1daebcfaaac4154fe1b9524b6479e)  
<br />

## 工夫したポイント
- 多対多のアソシエーションを作成し、コメント機能を実装
- 非同期通信でコメント機能、いいね機能を実装
- インクリメンタルサーチでのユーザー検索機能を実装
- 架空のフォロークラス、フォロワークラスを使い、フォロー機能を実装
- 投稿する画像を確認するために、プレビュー機能を実装

## 課題や今後実装したい機能
- 画像を複数枚投稿する
- 動画を投稿できるようにする
- 通知機能をつける

## 著者
関 嵐丸  
E-Mail: m78.seki.ranmaru@gmail.com

# DB設計
## users table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true, index: true|
|email|string|null: false, unique: true|
|password|string|null: false|
#### Association
- has-many :posts
- has-many :comments
- has_many :likes
- has_many :like_items, through: :likes
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship'
- has_many :followers, through: :reverse_of_relationships, source: :user

## posts table
|Column|Type|Options|
|------|----|-------|
|contents|text|index: true|
|image|text|null: false|
|user_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- has-many :comments
- has-many :likes

## comments table
|Column|Type|Options|
|------|----|-------|
|contents|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|post_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :post
- belongs_to :user

## likes table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|post_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :post
- belongs_to :user

## relationships table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|follow_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :follow
