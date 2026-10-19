BEGIN;

-- ТЕСТ 1: Нарушение CHECK (отрицательное количество товара в остатках)
-- Ожидаемая ошибка: new row for relation "stock" violates check constraint "stock_quantity_check"
SAVEPOINT test1;
INSERT INTO stock (warehouse_id, product_id, quantity) 
VALUES (1, 5, -10);
ROLLBACK TO SAVEPOINT test1;


-- ТЕСТ 2: Нарушение UNIQUE (дублирование уникального артикула SKU)
-- Ожидаемая ошибка: duplicate key value violates unique constraint "products_sku_key"
SAVEPOINT test2;
INSERT INTO products (sku, name, category_id, unit) 
VALUES ('EL-PH-001', 'Новый телефон с чужим SKU', 1, 'шт');
ROLLBACK TO SAVEPOINT test2;


-- ТЕСТ 3: Нарушение CHECK (недопустимый тип документа, не IN и не OUT)
-- Ожидаемая ошибка: new row for relation "documents" violates check constraint "documents_type_check"
SAVEPOINT test3;
INSERT INTO documents (type, warehouse_id) 
VALUES ('TRANSFER', 1);
ROLLBACK TO SAVEPOINT test3;


-- ТЕСТ 4: Нарушение RESTRICT (попытка удалить категорию, в которой есть товары)
-- Ожидаемая ошибка: update or delete on table "categories" violates foreign key constraint "fk_products_category"
SAVEPOINT test4;
DELETE FROM categories WHERE category_id = 1;
ROLLBACK TO SAVEPOINT test4;


-- ТЕСТ 5: Нарушение составного UNIQUE (добавление дубликата товара в одну накладную)
-- Ожидаемая ошибка: duplicate key value violates unique constraint "uq_document_product"
SAVEPOINT test5;
-- В документе ID 1 уже есть товар ID 1 (из data.sql)
INSERT INTO document_items (document_id, product_id, quantity, price) 
VALUES (1, 1, 10, 19000.00);
ROLLBACK TO SAVEPOINT test5;


-- ТЕСТ 6: Нарушение CHECK (нулевая/отрицательная цена в документе)
-- Ожидаемая ошибка: new row for relation "document_items" violates check constraint "document_items_price_check"
SAVEPOINT test6;
INSERT INTO document_items (document_id, product_id, quantity, price) 
VALUES (1, 4, 10, -500.00);
ROLLBACK TO SAVEPOINT test6;

COMMIT;