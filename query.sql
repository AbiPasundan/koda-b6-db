SELECT 
    products.id,
    products.product_name,
    product_variant.variant_name,
    product_size.size_name,
    (products.price + product_variant.add_price + product_size.size_price) * 2 AS total_price
FROM products
JOIN product_variant
    ON products.id = product_variant.product_id
JOIN product_size
    ON products.id = product_size.product_id
WHERE products.id = 1
AND product_variant.product_variant_id = 2
AND product_size.product_size_id = 3;




SELECT products.price, products.quantity, (products.price * products.quantity) AS sub_total
FROM products


-- KEBUTUHAN DATA DI LANDING PAGES
-- 1. DATA CARD
-- analisa di table landing page kubutuhan querynya apa saja
-- table card di landing page:
-- data product
-- * image ~
-- * title ~
-- * description ~
-- * rating 
-- * price ~

SELECT product_images.path AS pictures, products.product_name AS title, products.product_desc AS description, products.price AS price
FROM products
JOIN product_images ON product_images_id = product_images.product_images_id
WHERE product_images.product_id = 1
AND products.id = 1

-- 2. DATA TESTIMONEY
-- table testimoni di landing pages:
-- * images
-- * message
-- * reviews



-- KEBUTUHAN DATA DI BROWSE PRODUCT
-- 1. CARD PRODUCT
-- data product
-- * image ~
-- * title ~
-- * is_flash_sale
-- * description ~
-- * rating 
-- * price ~
-- * price_if_discount
