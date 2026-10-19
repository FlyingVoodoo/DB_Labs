BEGIN;

ALTER TABLE documents 
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'DRAFT';

ALTER TABLE documents 
ADD CONSTRAINT chk_documents_status 
CHECK (status IN ('DRAFT', 'COMPLETED', 'CANCELLED'));

ALTER TABLE products 
ADD COLUMN min_stock_level INT NOT NULL DEFAULT 0;

ALTER TABLE products 
ADD CONSTRAINT chk_products_min_stock 
CHECK (min_stock_level >= 0);

COMMIT;