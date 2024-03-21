## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name	         | string | null: false |
| first_name         | string | null: false |
| last_name_kana	   | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :items
- has_many  :order


## items テーブル

| Column       | Type       | Options     |
| -----------  | ---------- | ----------- |
| user         | references	| null: false, foreign_key: true|
| item_name    | string     | null: false, foreign_key: true| 
| item_info    | text       | null: false |
| price           | integer    | null: false |
| category_id     | integer    | null: false |
| condition_id    | integer     | null: false |
| shipping_cost_id| integer     | null: false |
| prefecture_id   | integer     | null: false |
| shipping_day_id | integer     | null: false |

### Association

- has_one    :order
- belongs_to :user



##  ordersテーブル

| Column          | Type            | Options        |
|---------------- |---------------- | ---------------|
| user            | references	    | null: false, foreign_key: true
| item            | references	    | null: false, foreign_key: true


### Association

- belongs_to :user
- belongs_to :item
- has_one :address


##  addressesテーブル

| Column        | Type       | Options      |
|---------------|------------|--------------|
| order         | references |null: false, foreign_key: true  |
| postal_code   | string     |null: false   |
| prefecture_id | integer    |null: false   |
| city          | string     |null: false   |
| address       | string     |null: false   |
| building_name | string     |
| phone_number  | string     |null: false   |	


### Association

- belongs_to :order

