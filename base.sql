-- DROP TABLE "users", "products", "transaction", "product_images", "category", "product_size","product_variant","discount";

CREATE TABLE "product_variant" (
    id INT PRIMARY KEY,
    variant_name VARCHAR(50),
    add_price INT
);

CREATE TABLE "product_size" (
    id INT PRIMARY KEY,
    size_name VARCHAR(50),
    size_price INT
);

CREATE TABLE "product_images" (
    id INT PRIMARY KEY,
    path VARCHAR(500)
);

CREATE TABLE "category" (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(30)
);
CREATE TABLE "discount" (
    id INT PRIMARY KEY,
    discount_rate INT,
    description VARCHAR(500),
    is_flash_sale BOOLEAN
);

CREATE TABLE "users" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(30),
    email VARCHAR(30),
    password VARCHAR(500),
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
    quantity INT,
    product_variant INT,
    product_category INT,
    discount INT,
    size INT,
    images INT,
    CONSTRAINT fk_variant FOREIGN KEY (product_variant) REFERENCES product_variant(id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (product_category) REFERENCES category(category_id) ON DELETE SET NULL,
    CONSTRAINT fk_discount FOREIGN KEY (discount) REFERENCES discount(id) ON DELETE CASCADE,
    CONSTRAINT fk_size FOREIGN KEY (size) REFERENCES product_size(id) ON DELETE CASCADE,
    CONSTRAINT fk_images FOREIGN KEY (images) REFERENCES product_images(id) ON DELETE CASCADE
);

CREATE TABLE "transaction" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    delivery_method VARCHAR(30),
    full_name VARCHAR(100),
    email VARCHAR(100),
    address TEXT,
    sub_total INT,
    delivery_fee INT,
    tax INT,
    total INT,
    date TIMESTAMP,
    status VARCHAR(30),
    payment_method INT
);
