DROP TABLE IF EXISTS "users", "products", "orders", "product_images", "category", "product_categories", "product_size","product_variant","discount", "reviews" CASCADE;

CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(30)
);

CREATE TABLE discount (
    discount_id INT PRIMARY KEY,
    discount_rate INT,
    description TEXT,
    is_flash_sale BOOLEAN
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(30),
    product_desc TEXT,
    price INT,
    quantity INT,
    discount INT,
    CONSTRAINT fk_discount FOREIGN KEY (discount) REFERENCES discount(discount_id) ON DELETE SET NULL
);

CREATE TABLE product_categories (
    product_id INT,
    category_id INT,

    CONSTRAINT pk_product_category
    PRIMARY KEY (product_id, category_id),

    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE TABLE product_variant (
    product_variant_id INT PRIMARY KEY,
    product_id INT,
    variant_name VARCHAR(255),
    add_price INT,

    CONSTRAINT fk_variant FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT unique_variant_per_product UNIQUE(product_id, variant_name)
);

CREATE TABLE product_size (
    product_size_id INT PRIMARY KEY,
    product_id INT,
    size_name VARCHAR(255),
    size_price INT,

    CONSTRAINT fk_size FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT unique_size_per_product UNIQUE(product_id, size_name)
);

CREATE TABLE product_images (
    product_images_id INT PRIMARY KEY,
    product_id INT,
    path VARCHAR(255),
    CONSTRAINT fk_images FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    password TEXT,
    address TEXT,
    phone VARCHAR(255),
    pictures VARCHAR(255)
);


CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    messages TEXT,
    ratings INT,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    delivery_method VARCHAR(255),
    full_name VARCHAR(255),
    email VARCHAR(255),
    address TEXT,
    sub_total INT,
    delivery_fee INT,
    tax INT,
    total INT,
    date TIMESTAMP,
    status VARCHAR(255),
    payment_method INT
);