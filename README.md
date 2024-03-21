## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| user_name          | string | null: false |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| password_digest    | string | null: false |
| last_name	         | string | null: false |
| first_name         | string | null: false |
| birth_date         | date   | null: false |


### Association

- has_many :items
- has_many :orders


## items テーブル

| Column       | Type       | Options     |
| -----------  | ---------- | ----------- |
| user_id      | references	| null: false, foreign_key: true|
| item-name    | string     | null: false | 
| item-info    | text       | null: false |
| price        | integer    | null: false |
| category_id  | integer    | null: false |
| condition    | string     | null: false |
| shipping_cost| string     | null: false |
| ship_from    | string     | null: false |
| shipping_day | string     | null: false |

### Association

- has_many :orders
- belongs_to :user



##  ordersテーブル

| Column          | Type            | Options        |
|---------------- |---------------- | ---------------|
| user_id         | references	    | null: false, foreign_key: true
| product_id      | references      | null: false, foreign_key: true |
| card_number     | string          |	null: false |
| expiration_date | date            |	null: false |
| security_code   | string          |	null: false |


### Association

- belongs_to :user
- has_one :addresses


##  addressesテーブル

| Column        | Type       | Options      |
|---------------|------------|--------------|
| order_id      | references |null: false, foreign_key: true  |
| postal_code   | string     |null: false   |
| prefecture    | string     |null: false   |
| city          | string     |null: false   |
| address       | string     |null: false   |
| building_name | string     |
| phone_number  | string     |null: false   |	


### Association

- has_one :orders

