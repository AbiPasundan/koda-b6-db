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