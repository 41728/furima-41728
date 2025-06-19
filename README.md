# FURIMA（フリマアプリ）

## アプリケーション概要

FURIMAは、ユーザー同士で商品の売買を行うことができるフリマアプリです。

- ユーザー登録／ログイン／ログアウト
- 商品の出品／編集／削除
- 商品一覧表示
- 商品詳細表示
- 商品購入（クレジットカード決済）
- 売却済み商品には「SOLD OUT」表示

---


## テスト用アカウント

### Basic認証

- ID：`admin`  
- パスワード：`2222`

### テストユーザー

- メールアドレス：`tech@furima.com`  
- パスワード：`123abc`

---

## アプリの使い方

1. ユーザー登録 or ログイン
2. 商品を出品または閲覧
3. 購入したい商品を選択し、クレジットカードで購入

---


## 使用技術

| 分類          | 技術                                      |
|---------------|-------------------------------------------|
| フロントエンド | HTML / CSS / JavaScript                   |
| バックエンド   | Ruby on Rails 7.1.5                       |
| データベース   | MySQL（本番・開発）                        |
| 認証          | Devise                                    |
| 決済          | Pay.jp（クレジットカード）                  |
| テスト        | RSpec / FactoryBot / Faker                |

---

## ER図

![ER図]https://gyazo.com/fdc405ae182281cab6cb7c4fdfe50195


---


## ローカル環境構築手順

```bash
# リポジトリをクローン
git clone https://github.com/41728/furima-41728.git
cd furima-41728

# gemをインストール
bundle install


# DB作成＆マイグレーション
rails db:create
rails db:migrate

# サーバー起動
rails s