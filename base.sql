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
    CONSTRAINT fk_discount FOREIGN KEY (discount) REFERENCES discount(discount_id) ON DELETE SET NULL
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

CREATE TABLE "reviews" (
    review_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    massage TEXT,
    ratings INT
);

ALTER TABLE product_variant 
ADD CONSTRAINT unique_variant_per_product 
UNIQUE (product_id, variant_name);

ALTER TABLE product_size
ADD CONSTRAINT unique_size_per_product
UNIQUE (product_id, size_name);

INSERT INTO category (category_id, category_name)
VALUES
(DEFAULT, 'kopi'), -- 1
(DEFAULT, 'non kopi'), -- 2
(DEFAULT, 'makanan'), -- 3
(DEFAULT, 'minuman'), -- 4
(DEFAULT, 'add on'), -- 5
(DEFAULT, 'makanan asin'), -- 6
(DEFAULT, 'makanan manis'), -- 7
(DEFAULT, 'makanan ringan'), -- 8
(DEFAULT, 'makanan berat'), -- 9
(DEFAULT, 'roti'); -- 10

INSERT INTO discount (discount_rate, description, is_flash_sale)
  VALUES
    (10, 'Mother Day`s', TRUE), -- 1
    (6, 'Ramadhan', TRUE), -- 2
    (5, 'Idul Fitr', TRUE), -- 3
    (9, 'Most Loyal Customoer', TRUE), -- 4
    (0, 'No Discount', FALSE), -- 5
    (1, 'Promo Februari', TRUE), -- 5
    (0, 'Imlek', TRUE), -- 6
    (10, 'Promo Februari', TRUE), -- 7
    (9, 'Gift', FALSE), -- 8
    (100, 'testing', FALSE); -- 9

INSERT INTO products (id, product_name, product_desc, price, quantity, product_category, discount)
  VALUES
  (DEFAULT, 'kapal api late', 'Kopi Kapal Api Biasa', 15000, 30, 1, 2),
  (DEFAULT, 'Classic Coffe', 'Esspreso 2 shot with milk', 25000, 30, 1, 10),
  (DEFAULT, 'Lava cake', 'hidangan penutup (dessert)', 10000, 70, 2, 2),
  (DEFAULT, 'Brownis', 'makanan yang dipanggang yang berbentuk persegi, datar atau bar', 35000, 25, 2, 2),
  (DEFAULT, 'Muffin', 'Kue individu (sekali makan) yang dipanggang dalam cetakan berbentuk cangkir atau muffin tin.', 30000, 47, 2, 3),
  (DEFAULT, 'Kopi tubruk', 'Kopi Langsung Diseduh', 30000, 90, 2, 1),
  (DEFAULT, 'Melya', 'kopi berbahan dasar espresso yang dicampur dengan kakao bubuk dan madu.', 30000, 100, 2, 9),
  (DEFAULT, 'Café au lait', 'adalah campuran kopi hitam yang tajam dengan susu panas.', 30000, 10, 2, 5),
  (DEFAULT, 'Machiato', 'minuman kopi yang dibuat dengan mencampurkan espresso dengan susu.', 30000, 5, 2, 7),
  (DEFAULT, 'Esspreso', 'Kopi bertekanan Tinggi', 9000, 7, 2, 7),
  (DEFAULT, 'V60', 'No Description Yet', 15000, 9, 2, 8),
  (DEFAULT, 'Plain Milk', 'susu segar atau UHT tanpa tambahan perasa, gula, atau aroma, yang kaya akan protein, lemak utuh, vitamin, dan kalsium', 17500, 27, 4, 5)
  (DEFAULT, 'Flavour Milk', 'No Description Yet', 17000, 12, 4, 5),
  (DEFAULT, 'Soekapi Platter', 'No Description Yet', 70000, 9, 3, 5),
  (DEFAULT, 'Bitterballen', 'kudapan goreng khas Belanda yang sangat populer, berbentuk bola-bola kecil (sekitar 3-4 cm) dengan tekstur renyah di luar dan isian ragout daging yang lembut dan gurih di dalam', 35000, 27, 3, 5),
  (DEFAULT, 'Rissoles', 'pastri berisi daging cincang, sayuran, atau ragout yang dibungkus dadar tipis, dilapisi tepung panir, dan digoreng renyah', 28000, 29, 3,5),
  (DEFAULT, 'French Fries', 'hidangan yang dibuat dari potongan-potongan kentang yang digoreng dalam minyak goreng panas. ', 26000, 17, 3,5),
  (DEFAULT, 'Singkong Goreng', 'hidangan yang dibuat dari potongan-potongan kentang yang digoreng dalam minyak goreng panas. ', 26000, 15, 3,5),
  (DEFAULT, 'Pisang Goreng Salted Caramel', 'No Description Yet', 26000, 21, 3,5),
  (DEFAULT, 'Hot Chocolate', 'minuman hangat yang dibuat dengan melelehkan cokelat padat (seperti cokelat batangan, keping cokelat/chips, atau serutan) ke dalam susu atau air panas. ', 36000, 11, 2,5),
  (DEFAULT, 'Ice Chocolate', 'minuman cokelat dingin yang menyegarkan, terbuat dari campuran cokelat (bubuk atau sirup), susu, dan es batu', 41000, 3, 2,9),
  (DEFAULT, 'Hot Matcha Latte', 'minuman hangat yang populer, menggabungkan bubuk teh hijau matcha berkualitas tinggi dari Jepang dengan susu panas yang creamy. ', 41000, 21, 2,6),
  (DEFAULT, 'Hot Red Velvet Latte', 'minuman kopi kekinian yang memadukan espresso, susu panas, dan bubuk atau sirup red velvet, menghasilkan rasa manis, gurih, dan tekstur lembut seperti kue red velvet.', 39000, 21, 2,4),
  (DEFAULT, 'Ice Red Velvet Latte', 'minuman kekinian yang memadukan espresso, susu, dan sirup atau bubuk red velvet, menghasilkan rasa manis, gurih, dan tekstur creamy yang menyegarkan.', 41000, 30, 2,3),
  (DEFAULT, 'Hot Taro Latte', 'minuman creamy perpaduan bubuk talas ungu (taro) manis dengan susu panas, seringkali tanpa kopi (non-coffee). ', 39000, 11, 2,2),
  (DEFAULT, 'Ice Taro Latte', 'minuman yang menggabungkan rasa unik dari bubuk taro dan kelezatan susu.', 39000, 17, 2,1),
  (DEFAULT, 'Ice Lychee Tea', 'minuman teh dingin yang populer karena rasanya yang manis, segar, dan aromatik, seringkali disajikan dengan buah leci asli dan es batu.', 31000, 29, 2,1),
  (DEFAULT, 'Hot Regular Tea', 'No Description Yet', 19000, 17, 2,9),
  (DEFAULT, 'Ice Regular Tea', 'No Description Yet', 21000, 30, 2,7),
  (DEFAULT, 'Hot Premium Tea', 'No Description Yet', 19000, 23, 2,4),
  (DEFAULT, 'Ice Premium Tea', 'No Description Yet', 21000, 3, 2,1),
  (DEFAULT, 'On The Rock', 'cara penyajian minuman, khususnya minuman beralkohol seperti wiski atau brendi, yang disajikan di atas es batu tanpa tambahan campuran lain.', 45000, 7, 1,5),
  (DEFAULT, 'Piccolo Latte', 'minuman kopi susu berbasis espresso berukuran mini, biasanya disajikan dalam gelas 85-114 ml.', 30000, 39, 1,5),
  (DEFAULT, 'Affogatto', 'hidangan penutup (dessert) khas Italia berupa satu atau dua skup es krim vanila (atau gelato) yang disiram dengan segelas espresso panas.', 33000, 11, 1,5),
  (DEFAULT, 'Hot Vanilla Latte', 'minuman kopi populer yang terdiri dari campuran espresso, susu panas yang di-steam (steamed milk), dan sirup vanilla', 29000, 37, 1,5),
  (DEFAULT, 'Ice Vanilla Latte', 'minuman kopi populer yang terdiri dari campuran espresso, susu panas yang di-steam (steamed milk), dan sirup vanilla', 31000, 1, 1,5),
  (DEFAULT, 'Apple Pie', 'hidangan penutup klasik yang terdiri dari kulit pastri renyah (crust) yang diisi dengan potongan apel manis, kayu manis, dan gula. ', 32000, 14, 3,1),
  (DEFAULT, 'Pineapple Pie', 'hidangan penutup tropis yang populer, terkenal dengan perpaduan rasa manis dan segar dari nanas serta kulit pai yang renyah dan bermentega.', 32000, 16, 3,5),
  (DEFAULT, 'Almond Gallete Pie', 'kue pastri berbentuk bundar yang renyah dan berlapis-lapis (puff pastry) dengan isian krim almond manis yang lembut.', 31000, 21, 3,5),
  (DEFAULT, 'Cheese Danish', 'kue pastry (kue kering berlapis) yang terkenal dengan tekstur renyah di luar, lembut di dalam, serta isian krim keju manis yang gurih. ', 32000, 33, 3,5),
  (DEFAULT, 'Croissant Ham & Cheese', 'kombinasi sarapan atau camilan klasik yang terdiri dari roti croissant renyah yang diisi dengan ham gurih dan keju leleh, seringkali dipanggang hingga keju meleleh sempurna.', 32000, 33, 3,7),
  (DEFAULT, 'Brownies Choco Chips', 'No Description Yet', 25000, 21, 3,5),
  (DEFAULT, 'Brownies Choco Almond', 'No Description Yet', 26000, 21, 3,5),
  (DEFAULT, 'Brownies & Ice Cream', 'No Description Yet', 31000, 21, 3,5),
  (DEFAULT, 'Vietnam Drip', 'metode seduh kopi khas Vietnam menggunakan saringan logam kecil, menghasilkan kopi pekat ala espresso yang biasa disajikan di atas susu kental manis.', 31000, 21, 1,1),
  (DEFAULT, 'Aero press', 'alat seduh kopi manual portabel yang menggunakan tekanan udara untuk menghasilkan kopi yang clean, intens, dan kaya rasa dalam waktu 2-3 menit.', 24000, 15, 2,1),
  (DEFAULT, 'Cold Brew Coffee', 'metode penyeduhan kopi dengan merendam bubuk kopi giling kasar dalam air dingin/suhu ruang selama 12–24 jam, menghasilkan konsentrat kopi rendah asam, manis alami, dan halus. ', 29000, 21, 2,1),
  (DEFAULT, 'V60', 'metode seduh kopi manual (manual brew) yang menghasilkan kopi bersih dan aromatik menggunakan dripper berbentuk V', 39000, 27, 2,1),
  (DEFAULT, 'Berry Good & Ice Cream', 'idangan penutup berbahan dasar stroberi segar, sering kali berupa es krim yang dicampur dengan buah beri utuh atau saus beri kental. ', 45000, 33, 2,9),
  ;

INSERT INTO products 
(product_name, product_desc, price, quantity, product_category, discount)
VALUES 
('Cappuccino', 'Coffee with milk foam', 30000, 100, 1, 1);

INSERT INTO product_variant 
(product_variant_id, product_id, variant_name, add_price)
VALUES
(DEFAULT, 1, 'Hot', 0), (DEFAULT, 1, 'Ice', 2000),
(DEFAULT, 2, 'Hot', 0), (DEFAULT, 2, 'Ice', 1500),
(DEFAULT, 3, 'Original', 0), (DEFAULT, 3, 'Sweet', 0),
(DEFAULT, 4, 'Hot', 0), (DEFAULT, 4, 'Ice', 1500),
(DEFAULT, 5, 'Hot', 0), (DEFAULT, 5, 'Ice', 1500),
-- (DEFAULT, 6, 'Hot', 0), (DEFAULT, 6, 'Ice', 1500),
(DEFAULT, 7, 'Hot Sweet', 1000), (DEFAULT, 7, 'Ice Sweet', 1000), (DEFAULT, 7, 'Hot', 0), (DEFAULT, 7, 'Ice', 0),
(DEFAULT, 8, 'Coklat', 0), (DEFAULT, 8, 'Madu', 1000), (DEFAULT, 8, 'Cokalt Madu', 1000),
(DEFAULT, 9, 'Hot', 0), (DEFAULT, 9, 'Ice', 2000),
(DEFAULT, 10, 'Hot', 0), (DEFAULT, 10, 'Ice', 1000),
(DEFAULT, 11, 'Hot', 0), (DEFAULT, 11, 'Ice', 2000),
(DEFAULT, 12, 'Hot', 0), (DEFAULT, 12, 'Ice', 2000)
;
INSERT INTO product_size
  (product_id, size_name, size_price)
  VALUES (1, 'Small', 100), (1, 'Regular', 1000), (1, 'Large', 5000), (1, 'Big Boss', 10000),
  (2, 'Regular', 0),
  (3, 'Small', 0), (3, 'Medium', 0), (3, 'Full Cake', 5000),
  (4, 'Small', 0), (4, 'Medium', 0), (4, 'Full Cake', 5000),
  (5, 'Regular', 0),
  (6, 'Small', 0), (6, 'Regular', 0), (6, 'Large', 5000), (6, 'Big Boss', 10000),
  (7, 'Regular', 0),
  (8, 'Small', 0),(8, 'Regular', 0),(8, 'Large', 1500),
  (9, 'Small', 0),(9, 'Regular', 0),(9, 'Large', 1500),
  (10, 'Small', 0),(10, 'Regular', 0),(10, 'Large', 1500),
  (11, 'Small', 0),(11, 'Regular', 0),(11, 'Large', 1500),
  (12, 'Small', 0),(12, 'Regular', 0),(12, 'Large', 1500)
  ;

INSERT INTO product_images (product_id, path) VALUES (1, 'test/images');

-- SELECT * FROM products;
-- SELECT * FROM discount;
-- SELECT * FROM category;

-- SELECT * FROM product_variant;
-- SELECT * FROM product_size;
-- SELECT * FROM product_images;