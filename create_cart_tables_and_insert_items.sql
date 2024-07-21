-- 1. Create the carts table

CREATE TABLE carts (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('OPEN', 'ORDERED'))
);

-- 2. Create the cart_items table

CREATE TABLE cart_items (
    cart_id UUID REFERENCES carts(id),
    product_id UUID,
    count INTEGER,
    PRIMARY KEY (cart_id, product_id)
);

-- 3. Insert test data into carts

INSERT INTO carts (id, user_id, created_at, updated_at, status) VALUES
('b3e1c25d-d2e8-4c5c-a8a3-f2e6ad9d0d61', 'c4e6ac7e-bd13-4b74-8f8f-63a1b3b1e689', '2024-07-01', '2024-07-01', 'OPEN'),
('5a1d7e11-5d62-4d2f-9f6b-c4e4c5c6a84f', 'd7a2f14b-ef87-4c3e-9f5d-f5a7b7e5d4e3', '2024-07-02', '2024-07-02', 'ORDERED');

-- 4. Insert test data into cart_items

INSERT INTO cart_items (cart_id, product_id, count) VALUES
('b3e1c25d-d2e8-4c5c-a8a3-f2e6ad9d0d61', 'a4b5c6d7-e8f9-4b7a-8f6d-9e5c6d7a4b5f', 2),
('b3e1c25d-d2e8-4c5c-a8a3-f2e6ad9d0d61', 'b5c6d7e8-f9a4-4b7a-8f6d-9e5c6d7a4c5f', 3),
('5a1d7e11-5d62-4d2f-9f6b-c4e4c5c6a84f', 'c6d7e8f9-a4b5-4c7a-8f6d-9e5c6d7a4d5f', 1);
