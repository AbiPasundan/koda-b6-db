-- DROP TABLE "users", "products", "transaction", "product_images", "category", "product_size","product_variant","discount";

CREATE TABLE "category" (
    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(30)
);

CREATE TABLE "discount" (
    discount_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    discount_rate INT,
    description VARCHAR(500),
    is_flash_sale BOOLEAN
);

CREATE TABLE "products" (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(30),
    product_desc TEXT,
    price INT,
    quantity INT,
    product_category INT,
    discount INT,
    CONSTRAINT fk_category FOREIGN KEY (product_category) REFERENCES category(category_id) ON DELETE SET NULL,
    CONSTRAINT fk_discount FOREIGN KEY (discount) REFERENCES discount(discount_id) ON DELETE CASCADE
);

CREATE TABLE "product_variant" (
    product_variant_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INT,
    variant_name VARCHAR(50),
    add_price INT,
    CONSTRAINT fk_variant FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE "product_size" (
    product_size_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INT,
    size_name VARCHAR(50),
    size_price INT,
    CONSTRAINT fk_size FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE "product_images" (
    product_images_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INT,
    path VARCHAR(500),
    CONSTRAINT fk_images FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
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

INSERT INTO category (category_id, category_name) VALUES (DEFAULT, 'kopi'), (DEFAULT, 'non kopi'),(DEFAULT, 'makanan'),(DEFAULT, 'minuman'),(DEFAULT, 'add on'),(DEFAULT, 'makanan asin'),(DEFAULT, 'makanan manis'),(DEFAULT, 'makanan ringan'),(DEFAULT, 'makanan berat'),(DEFAULT, 'roti');

INSERT INTO discount (discount_rate, description, is_flash_sale)
  VALUES
  (10, 'Mother Day`s', TRUE), (6, 'Ramadhan', TRUE), (5, 'Idul Fitr', TRUE), (9, 'Most Loyal Customoer', TRUE), (0, 'No Discount', FALSE),
  (1, 'Promo Februari', TRUE), (0, 'Imlek', TRUE), (10, 'Promo Februari', TRUE), (9, 'Gift', FALSE), (100, 'testing', FALSE);

INSERT INTO products (id, product_name, product_desc, price, quantity, product_category, discount)
  VALUES
  (DEFAULT, 'kapal api late', 'Kopi Kapal Api Biasa', 15000, 30, 1, 2),
  (DEFAULT, 'Classic Coffe', 'Esspreso 2 shot with milk', 25000, 30, 1, 10),
  (DEFAULT, 'Lava cake', 'hidangan penutup (dessert)', 10000, 70, 2, 2),
  (DEFAULT, 'Brownis', 'makanan yang dipanggang yang berbentuk persegi, datar atau bar', 35000, 25, 2, 2),
  (DEFAULT, 'Muffin', 'Kue individu (sekali makan) yang dipanggang dalam cetakan berbentuk cangkir atau muffin tin.', 30000, 47, 2, 3),
  (DEFAULT, 'Kopi tubruk', '', 30000, 90, 2, 1),
  (DEFAULT, 'Melya', 'kopi berbahan dasar espresso yang dicampur dengan kakao bubuk dan madu.', 30000, 100, 2, 9),
  (DEFAULT, 'Café au lait', 'adalah campuran kopi hitam yang tajam dengan susu panas.', 30000, 10, 2, 5),
  (DEFAULT, 'Machiato', 'minuman kopi yang dibuat dengan mencampurkan espresso dengan susu.', 30000, 5, 2, 7),
  (DEFAULT, 'Esspreso', 'Kopi bertekanan Tinggi', 30000, 7, 2, 7),
  (DEFAULT, 'test', 'testing123', 30000, 9, 2, 8);

INSERT INTO products 
(product_name, product_desc, price, quantity, product_category, discount)
VALUES 
('Cappuccino', 'Coffee with milk foam', 30000, 100, 1, 1);

INSERT INTO product_variant (product_id, variant_name, add_price) VALUES (1, 'hot', 1500);

INSERT INTO product_variant 
(product_variant_id, product_id, variant_name, add_price)
VALUES
(DEFAULT, 1, 'Hot', 0),
(DEFAULT, 1, 'Ice', 2000),
(DEFAULT, 2, 'Hot', 0),
(DEFAULT, 2, 'Ice', 0),
(DEFAULT, 3, 'Original', 0),
(DEFAULT, 3, 'Sweet', 0);

INSERT INTO product_size (product_id, size_name, size_price) VALUES (1, 'Small', 1000);

INSERT INTO product_images (product_id, path) VALUES (1, 'test/images');

SELECT * FROM products;
SELECT * FROM discount;
SELECT * FROM category;

SELECT * FROM product_variant;
SELECT * FROM product_size;
SELECT * FROM product_images;
