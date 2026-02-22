# ERD coffee shop

<!-- USER ||--o{ ORDER : places -->

<!-- 

    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses

 -->

```mermaid

---
title: Order example
---
erDiagram

    
    User {
        id int pk
        name varchar
        email varchar
        phone varchar
        address text
        photo varchar
        role enum
        created_at time_stamp
    }

    
    Payment {
        id int pk
        order_id int fk
        method enum
        amount decimal
        status enum
    }

    Product {
        id int pk
        product_name varchar
        price decimal
        desc text
        size varchar
        stock int
        category enum
        created_at time_stamp
    }

    User ||--o{ Cart : ""
    User ||--o{ Order : ""
    Cart ||--|{ Cart_Item : ""
    Product ||--o{ Cart_Item : ""
    Product ||--o{ Detail_Order : ""
    Order ||--o{ Detail_Order : ""

    Cart {
        id int pk
        user_id int fk
        created_at timestamp
    }

    Cart_Item {
        id int pk
        cart_id int fk
        product_id int fk
        quantity int
    }

    Payment ||--|| Order : ""
    Order {
        no_order int pk
        user_id int fk
        date time_stamp
        status enum
    }

    Detail_Order {
        id int pk
        order_id int fk
        product_id int fk
        created_at time_stamp
    }

```
