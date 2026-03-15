# ERD coffee shop

<!--
buatkan query dalam file query.sql mendapatkan satu product yang sudah di agregasikan dengan variant dan size yang dipilih

final expectation: product, size, variant

Buatkan query untuk mendapatkan sub total dari setiap barang yang dipilih dan tambhkan juga quantity
clue: menggunakan sub query

perbedaan
one to one
one to many

one to one penempatan foreign key ada di table
one to many penempatan foreign key ada di table utama

analisa di table landing page kubutuhan querynya apa saja
table card di landing page:
data product
* image
* title
* description
* rating
* price

table testimoni di landing pages:
* images
* message
* reviews

sintak join setelah on adalah kolom yang mempunyai hubungan dengan table lain

-->

```mermaid

---
title: Order example
---
erDiagram

    %%{init: {'theme': 'forest'}}%%

    category {
        INT category_id PK
        VARCHAR(30) category_name
    }

    discount {
        INT discount_id PK
        INT discount_rate
        TEXT description
        BOOLEAN is_flash_sale
    }

    products {
        INT id PK
        VARCHAR(30) product_name
        TEXT product_desc
        INT price
        INT quantity
        INT discount FK
    }
    products }o..|| discount : fk_discount

    product_categories {
        INT product_id FK
        INT category_id FK
    }
    product_categories }o--|| products : fk_product
    product_categories }o--|| category : fk_category

    product_variant {
        INT product_variant_id PK
        INT product_id FK
        VARCHAR(255) variant_name
        INT add_price
    }
    product_variant }o..|| products : fk_variant

    product_size {
        INT product_size_id PK
        INT product_id FK
        VARCHAR(255) size_name
        INT size_price
    }
    product_size }o..|| products : fk_size

    product_images {
        INT product_images_id PK
        INT product_id FK
        VARCHAR(255) path
    }
    product_images }o..|| products : fk_images

    users {
        INT id PK
        VARCHAR(255) full_name
        VARCHAR(255) email UK
        TEXT password
        TEXT address
        VARCHAR(255) phone
    }

    user_images {
        INT user_images_id PK
        INT user_id FK
        VARCHAR(255) path
    }
    user_images }o..|| users : fk_user_images

    reviews {
        INT review_id PK
        INT user_id FK
        INT product_id FK
        TEXT messages
        INT ratings
    }
    reviews }o..|| users : fk_user_review
    reviews }o..|| products : fk_product_review

    orders {
        INT id PK
        INT user_id FK
        VARCHAR(255) delivery_method
        VARCHAR(255) full_name
        VARCHAR(255) email
        TEXT address
        INT sub_total
        INT delivery_fee
        INT tax
        INT total
        TIMESTAMP date
        VARCHAR(255) status
        INT payment_method
    }
    orders }o..|| users : fk_order_user

    order_items {
        INT order_item_id PK
        INT order_id FK
        INT product_id FK
        INT quantity
        INT price
        VARCHAR(255) product_name
        VARCHAR(255) variant_name
    }
    order_items }o..|| orders : fk_order
    order_items }o..|| products : fk_product


```
