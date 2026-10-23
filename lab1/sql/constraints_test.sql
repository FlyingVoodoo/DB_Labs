BEGIN;

-- Нарушение CHECK (отрицательное количество товара в остатках)
SAVEPOINT test1;
INSERT INTO stock (warehouse_id, product_id, quantity) 
VALUES (1, 5, -10);
ROLLBACK TO SAVEPOINT test1;


-- Нарушение UNIQUE (дублирование уникального артикула SKU)
SAVEPOINT test2;
INSERT INTO products (sku, name, category_id, unit) 
VALUES ('EL-PH-001', 'Новый телефон с чужим SKU', 1, 'шт');
ROLLBACK TO SAVEPOINT test2;


-- Нарушение CHECK (недопустимый тип документа, не IN и не OUT)
SAVEPOINT test3;
INSERT INTO documents (type, warehouse_id) 
VALUES ('TRANSFER', 1);
ROLLBACK TO SAVEPOINT test3;


-- Нарушение RESTRICT (попытка удалить категорию, в которой есть товары)
SAVEPOINT test4;
DELETE FROM categories WHERE category_id = 1;
ROLLBACK TO SAVEPOINT test4;


-- Нарушение составного UNIQUE (добавление дубликата товара в одну накладную)
SAVEPOINT test5;
-- В документе ID 1 уже есть товар ID 1 (из data.sql)
INSERT INTO document_items (document_id, product_id, quantity, price) 
VALUES (1, 1, 10, 19000.00);
ROLLBACK TO SAVEPOINT test5;


-- Нарушение CHECK (нулевая/отрицательная цена в документе)
SAVEPOINT test6;
INSERT INTO document_items (document_id, product_id, quantity, price) 
VALUES (1, 4, 10, -500.00);
ROLLBACK TO SAVEPOINT test6;

COMMIT;