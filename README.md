# ERD coffee shop

<!-- USER ||--o{ ORDER : places -->

```mermaid

---
title: Order example
---
erDiagram

    
    User {
        id int
        name varchar
        email varchar
        phone int
        address text
        photo text
        created_at time_stamp
    }

    Product {
        id int
        product_name varchar
        price int
        desc text
        size varchar
        method varchar
        stock int
    }

    Order {
        id int
        product_name varchar
        price int
        desc text
        size varchar
        method varchar
        stock int
    }

```
