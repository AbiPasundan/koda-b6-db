SELECT products.product_name, string_agg(variant_name, ',') as variant, size_name
FROM products
JOIN product_variant ON variant_name = product_variant.variant_name
JOIN product_size ON size_name = product_size.size_name
GROUP BY product_name, product_variant.variant_name, product_size.size_name
LIMIT 1;