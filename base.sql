-- DROP TABLE "users", "products", "transaction";

CREATE TABLE "users" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(30),
    email VARCHAR(30),
    password VARCHAR(30),
    address TEXT,
    phone VARCHAR(30),
    pictures VARCHAR(100)
);

CREATE TABLE "products" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pictures VARCHAR(100),
    product_name VARCHAR(30),
    product_desc TEXT,
    price INT,
    quantity INT
);


CREATE TABLE "transaction" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    delivery_method VARCHAR(100),
    full_name VARCHAR(30),
    email VARCHAR(50),
    address TEXT,
    sub_total INT,
    delivery_fee INT,
    tax INT,
    total INT,
    transaction_id INT,
    date INT,
    status VARCHAR,
    payment_method INT
);
