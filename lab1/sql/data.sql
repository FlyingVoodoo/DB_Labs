
INSERT INTO categories (name) VALUES 
('Электроника'),
('Бытовая химия'),
('Одежда и обувь'),
('Продукты питания');

INSERT INTO warehouses (name, address) VALUES 
('Центральный склад', 'г. Москва, ул. Промышленная, д. 10'),
('Региональный склад Юг', 'г. Краснодар, ул. Логистическая, д. 5');

INSERT INTO suppliers (name, phone, email) VALUES 
('ООО "ТехноПром"', '+7 (495) 123-45-67', 'technoprom@mail.ru'),
('ЗАО "ХимТрейд"', '+7 (812) 987-65-43', 'himtrade@company.com'),
('ИП Иванов А.А.', '+7 (900) 555-35-35', 'ivanov_opt@yandex.ru');

INSERT INTO products (sku, name, category_id, unit) VALUES 
('EL-PH-001', 'Смартфон Xiaomi Redmi Note 13', 1, 'шт'),
('EL-LAP-002', 'Ноутбук Lenovo IdeaPad 3', 1, 'шт'),
('CH-PW-101', 'Стиральный порошок Persil 3кг', 2, 'шт'),
('CH-CL-102', 'Средство для мытья посуды Fairy 1л', 2, 'шт'),
('CL-TS-201', 'Футболка мужская черная (L)', 3, 'шт');

-- Остатки товаров на складах
INSERT INTO stock (warehouse_id, product_id, quantity) VALUES 
(1, 1, 45),
(1, 2, 12),
(1, 3, 150),
(2, 3, 80),
(2, 4, 200),
(2, 5, 50);

-- document_id 1: Приход (IN) от поставщика
INSERT INTO documents (type, warehouse_id, supplier_id) VALUES 
('IN', 1, 1);

-- document_id 2: Расход (OUT) со склада
INSERT INTO documents (type, warehouse_id, supplier_id) VALUES 
('OUT', 1, NULL);

-- Позиции для приходной накладной (doc 1)
INSERT INTO document_items (document_id, product_id, quantity, price) VALUES 
(1, 1, 50, 18500.00),
(1, 2, 15, 45000.00);

-- Позиции для расходной накладной (doc 2)
INSERT INTO document_items (document_id, product_id, quantity, price) VALUES 
(2, 1, 5, 22000.00);