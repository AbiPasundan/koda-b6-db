# ERD coffee shop

<!--
buatkan query dalam file query.sql mendapatkan satu product yang sudah di agregasikan dengan variant dan size yang dipilih

final expectation: product, size, variant

Buatkan query untuk mendapatkan sub total dari setiap barang yang dipilih dan tambhkan juga quantity
clue: menggunakan sub query
-->

```mermaid

---
title: Order example
---
erDiagram

    %%{init: {'theme': 'forest'}}%%

    product {
        id int pk
        pictures varchar fk
        product_name varchar
        desc text
        price decimal
        flash_sale varchar
        rating varchar
        discount int fk
        sizr int fk
        review int
        category varchar fk
        quantity int
    }
    
    product_variant {
        variant int pk
        add_price varchar
    }
    
    product_size {
        id int pk
        size_name int pk
        add_price int pk
    }
    
    product_images {
        p_id int pk
        path varchar pk
    }

    discount {
        id int pk
        discount_rate varchar
        desc varchar
        is_flash_sale varchar
    }
    
    category {
        category_id int pk
        category_name varchar
    }

    reviews {
        reviews_id int pk
        message varchar
        rattings varchar
    }

    product ||--|{product_variant: ""
    product ||--|{product_size : ""
    product ||--|{product_images : ""
    product ||--|{category : ""
    product ||--|{reviews : ""
    product }|--||discount : ""

    reviews ||--|{users : ""
    product ||--||cart : ""
    users ||--||cart : ""

    cart {
        cart_id int pk
    }

    users {
        id int pk
        full_name varchar
        email varchar
        password varchar
        address text
        phone varchar
        pictures varchar
    }

    transaction {
        quantity int fk
        full_name varchar
        email varchar
        address varchar
        sub_total int
        delivery int
        tax int
        total int
        transaction_id int fk
        date time_stamp
        status varchar fk
        payment_method varchar fk
    }

    transaction }|--|{ transaction_product : ""
    product }|--|{ transaction_product : ""

    transaction_product {
        transaction_id int pk
        quantity int
        size varchar
        variant varchar
        price int
    }

```








Baik. Saya jelaskan secara sistematis dan teknis.

---

# 🔎 Apa Itu Subquery di PostgreSQL?

Subquery adalah:

> Query yang berada di dalam query lain.

Subquery bisa berada di:

* SELECT
* FROM
* WHERE
* HAVING

PostgreSQL akan mengeksekusi subquery terlebih dahulu, lalu hasilnya dipakai oleh query utama.

---

# 1️⃣ Subquery di WHERE (Scalar Subquery)

Digunakan ketika subquery menghasilkan satu nilai.

### Contoh:

Ambil produk dengan harga di atas rata-rata harga semua produk.

```sql
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

Penjelasan:

1. PostgreSQL hitung `AVG(price)`
2. Hasilnya dibandingkan dengan setiap row di query utama

---

# 2️⃣ Subquery dengan IN

Ambil produk yang memiliki discount aktif (`is_flash_sale = true`).

```sql
SELECT product_name
FROM products
WHERE discount IN (
    SELECT discount_id
    FROM discount
    WHERE is_flash_sale = TRUE
);
```

Subquery menghasilkan banyak `discount_id`.

---

# 3️⃣ Subquery di SELECT (Correlated Subquery)

Ini sering dipakai untuk agregasi tanpa cross join.

Contoh: tampilkan produk dan semua variannya.

```sql
SELECT 
    p.product_name,
    (
        SELECT STRING_AGG(v.variant_name, ', ')
        FROM product_variant v
        WHERE v.product_id = p.id
    ) AS variants
FROM products p;
```

Ini disebut **correlated subquery**, karena:

```text
v.product_id = p.id
```

Subquery bergantung pada row di query utama.

PostgreSQL akan menjalankan subquery untuk setiap row produk.

---

# 4️⃣ Subquery di FROM (Derived Table)

Digunakan ketika kita ingin membuat "virtual table".

Contoh: ambil produk dengan jumlah variant > 1.

```sql
SELECT *
FROM (
    SELECT product_id, COUNT(*) AS total_variant
    FROM product_variant
    GROUP BY product_id
) AS variant_count
WHERE total_variant > 1;
```

Bagian dalam FROM dijalankan dulu, lalu diperlakukan seperti tabel sementara.

---

# 5️⃣ Correlated vs Non-Correlated

### Non-correlated

Tidak tergantung query luar.

```sql
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);
```

Dieksekusi sekali.

---

### Correlated

Tergantung row luar.

```sql
SELECT product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM product_variant v
    WHERE v.product_id = p.id
);
```

Dieksekusi per-row.

---

# 6️⃣ EXISTS (Sangat Penting untuk Performance)

Lebih efisien daripada IN dalam banyak kasus.

Contoh: produk yang punya minimal 1 variant.

```sql
SELECT product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM product_variant v
    WHERE v.product_id = p.id
);
```

PostgreSQL berhenti scanning begitu menemukan 1 row cocok.

---

# 7️⃣ Subquery untuk Simulasi Order (Realistic Example)

Misalnya user pilih:

* product_id = 1
* variant = 'Hot'
* size = 'Large'

Hitung harga final:

```sql
SELECT 
    p.product_name,
    (
        SELECT add_price
        FROM product_variant
        WHERE product_id = p.id
        AND variant_name = 'Hot'
    ) +
    (
        SELECT size_price
        FROM product_size
        WHERE product_id = p.id
        AND size_name = 'Large'
    ) +
    p.price AS final_price
FROM products p
WHERE p.id = 1;
```

Ini memanfaatkan subquery untuk ambil harga tambahan.

---

# 8️⃣ Kapan Pakai Subquery?

Gunakan subquery jika:

* Menghindari cross join
* Menghindari GROUP BY kompleks
* Ingin logic terisolasi
* Butuh per-row calculation

Jangan gunakan subquery jika:

* Dataset sangat besar dan correlated → bisa lambat
* Bisa diganti JOIN yang lebih efisien

---

# 🔥 Subquery vs JOIN (Perbandingan Konseptual)

| JOIN                             | Subquery                        |
| -------------------------------- | ------------------------------- |
| Lebih cepat untuk agregasi besar | Lebih clean untuk per-row logic |
| Bisa menyebabkan row explosion   | Tidak menyebabkan cartesian     |
| Lebih kompleks GROUP BY          | Lebih mudah dibaca              |

---

# 📌 Kesimpulan Teknis

Subquery di PostgreSQL:

* Dievaluasi sebelum query utama (kecuali correlated)
* Bisa scalar, table, atau boolean
* Sangat kuat untuk filtering & per-row computation
* Harus dipakai dengan pemahaman execution cost

---

Jika Anda ingin, saya bisa jelaskan:

* Execution plan (`EXPLAIN ANALYZE`) untuk subquery vs join
* Atau optimasi index agar subquery cepat
* Atau praktik terbaik untuk sistem e-commerce / coffee shop

Anda ingin lanjut ke level mana?
