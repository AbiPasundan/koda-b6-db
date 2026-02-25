-- SELECT products.product_name, string_agg(variant_name, ',') as variant, size_name
-- FROM products
-- JOIN product_variant ON variant_name = product_variant.variant_name
-- JOIN product_size ON size_name = product_size.size_name
-- GROUP BY product_name, product_variant.variant_name, product_size.size_name
-- LIMIT 1;


SELECT 
    products.product_name,
    product_variant.variant_name,
    product_size.size_name,
    (products.price + product_variant.add_price + product_size.size_price) AS final_price
FROM products
JOIN product_variant ON products.id = product_variant.product_id
JOIN product_size ON products.id = product_size.product_id
WHERE products.id = 1
AND product_variant.variant_name = 'Ice'
AND product_size.size_name = 'Large';