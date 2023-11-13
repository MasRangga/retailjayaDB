-- Data untuk tabel orders
INSERT INTO orders (customer_id, status, total) VALUES (5, 'paid', 0);
SET @order_id = LAST_INSERT_ID();

-- Menambahkan data ke dalam order_details
INSERT INTO order_details (order_id, product_id, quantity, price, subtotal) VALUES
(@order_id, 1, 2, 5000000, 10000000), -- Laptop ASUS
(@order_id, 2, 1, 150000, 150000), -- Celana Jeans Pria
(@order_id, 3, 3, 3000, 9000); -- Pensil HB

-- Menampilkan data dari order_details
SELECT
    od.id AS order_detail_id,
    od.order_id,
    b.name AS product_name,
    od.quantity,
    od.price,
    od.subtotal
FROM
    order_details od
JOIN
    barang b ON od.product_id = b.id;

-- Menampilkan data dari tabel orders
SELECT * FROM orders;

-- Mengupdate total pada tabel orders
UPDATE orders o
SET total = (
    SELECT SUM(subtotal)
    FROM order_details od
    WHERE od.order_id = o.id
)
WHERE o.id = @order_id;
