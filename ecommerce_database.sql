-- Criação do esquema para o banco de dados e-commerce
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Criação das tabelas para o cenário de e-commerce

-- Tabela Clientes
CREATE TABLE customer (
    idcustomer INT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    phone CHAR(11) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL
);

-- Tabela Pessoa Física
CREATE TABLE individual (
    idindividual INT PRIMARY KEY,
    customer_idcustomer INT UNIQUE,
    cpf CHAR(11) NOT NULL UNIQUE,
    rg CHAR(9) NOT NULL UNIQUE,
    FOREIGN KEY (customer_idcustomer) REFERENCES customer(idcustomer)
);

-- Tabela Empresas
CREATE TABLE company (
    idcompany INT PRIMARY KEY,
    customer_idcustomer INT UNIQUE,
    tradename VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    FOREIGN KEY (customer_idcustomer) REFERENCES customer(idcustomer)
);

-- Tabela Métodos de Pagamento
CREATE TABLE payment_method (
    idpayment_method INT PRIMARY KEY,
    description VARCHAR(45) NOT NULL,
    type ENUM('Crédito', 'Débito', 'Pix', 'Boleto') NOT NULL
);

-- Tabela Pedidos
CREATE TABLE product_order (
    idorder INT PRIMARY KEY,
    customer_idcustomer INT NOT NULL,
    status ENUM('Pendente', 'Pago', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    description VARCHAR(100),
    shipping FLOAT NOT NULL CHECK (shipping >= 0),
    date DATE NOT NULL,
    trackingcode CHAR(20) UNIQUE,
    FOREIGN KEY (customer_idcustomer) REFERENCES customer(idcustomer)
);

-- Tabela Fornecedores
CREATE TABLE supplier (
    idsupplier INT PRIMARY KEY,
    tradename VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    location VARCHAR(100),
    supplier_type TINYINT NOT NULL CHECK (supplier_type IN (0, 1))
);

-- Tabela Produtos
CREATE TABLE product (
    idproduct INT PRIMARY KEY,
    supplier_idsupplier INT NOT NULL,
    category ENUM('Eletrônicos', 'Roupas', 'Alimentos', 'Livros', 'Móveis') NOT NULL,
    description VARCHAR(100),
    price FLOAT NOT NULL CHECK (price >= 0),
    name VARCHAR(45) NOT NULL UNIQUE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    order_idorder INT,
    FOREIGN KEY (supplier_idsupplier) REFERENCES supplier(idsupplier),
    FOREIGN KEY (order_idorder) REFERENCES product_order(idorder)
);

-- Tabela Estoque
CREATE TABLE inventory (
    idinventory INT PRIMARY KEY,
    location VARCHAR(100) NOT NULL,
    product_idproduct INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    FOREIGN KEY (product_idproduct) REFERENCES product(idproduct)
);

-- Inserções de dados fictícios

-- Inserção de Clientes
INSERT INTO customer (idcustomer, name, email, phone, address) VALUES
(1, 'João Silva', 'joao.silva@email.com', '11999999999', 'Rua A, 123'),
(2, 'Maria Oliveira', 'maria.oliveira@email.com', '21988888888', 'Av. B, 456'),
(3, 'Carlos Lima', 'carlos.lima@email.com', '31977777777', 'Rua C, 789'),
(4, 'Ana Souza', 'ana.souza@email.com', '41966666666', 'Rua D, 101'),
(5, 'Fernanda Alves', 'fernanda.alves@email.com', '51955555555', 'Av. E, 202'),
(6, 'Pedro Gonçalves', 'pedro.goncalves@email.com', '61944444444', 'Rua F, 303'),
(7, 'Lucas Martins', 'lucas.martins@email.com', '71933333333', 'Rua G, 404');

-- Inserção de Pessoa Física
INSERT INTO individual (idindividual, customer_idcustomer, cpf, rg) VALUES
(1, 1, '12345678901', 'MG1234567'),
(2, 3, '23456789012', 'SP2345678'),
(3, 5, '34567890123', 'RJ3456789'),
(4, 6, '45678901234', 'RS4567890'),
(5, 7, '56789012345', 'PR5678901');

-- Inserção de Pessoa Jurídica
INSERT INTO company (idcompany, customer_idcustomer, tradename, cnpj) VALUES
(1, 2, 'Oliveira e Cia LTDA', '12345678000199'),
(2, 4, 'Ana Importações ME', '98765432000198');

-- Inserção de Formas de Pagamento
INSERT INTO payment_method (idpayment_method, description, type) VALUES
(1, 'Cartão de Crédito', 'Crédito'),
(2, 'Transferência Bancária', 'Pix'),
(3, 'Boleto Bancário', 'Boleto'),
(4, 'Cartão de Débito', 'Débito'),
(5, 'Pagamento na Entrega', 'Débito');

-- Inserção de Pedidos
INSERT INTO product_order (idorder, customer_idcustomer, status, description, shipping, date, trackingcode) VALUES
(1, 1, 'Pago', 'Pedido de eletrônicos', 15.50, '2025-01-01', 'ABC123456789BR'),
(2, 2, 'Enviado', 'Pedido de móveis', 30.00, '2025-01-02', 'DEF987654321BR'),
(3, 3, 'Pendente', 'Pedido de livros', 5.00, '2025-01-03', 'GHI123123123BR'),
(4, 5, 'Cancelado', 'Pedido de roupas', 10.00, '2025-01-04', 'JKL456456456BR'),
(5, 7, 'Entregue', 'Pedido de alimentos', 12.00, '2025-01-05', 'MNO789789789BR');

-- Inserção de Fornecedores
INSERT INTO supplier (idsupplier, tradename, cnpj, location, supplier_type) VALUES
(1, 'Tech Distribuidora', '23456789000123', 'São Paulo - SP', 0),
(2, 'Moveis e Cia', '34567890000134', 'Curitiba - PR', 1),
(3, 'BookStore LTDA', '45678901234567', 'Rio de Janeiro - RJ', 1),
(4, 'WearHouse', '56789012345678', 'Belo Horizonte - MG', 0),
(5, 'Food Supply', '67890123456789', 'Porto Alegre - RS', 0);

-- Inserção de Produtos
INSERT INTO product (idproduct, supplier_idsupplier, category, description, price, name, quantity, order_idorder) VALUES
(1, 1, 'Eletrônicos', 'Notebook Dell Inspiron', 3500.00, 'Notebook Dell', 10, 1),
(2, 2, 'Móveis', 'Cadeira de Escritório', 450.00, 'Cadeira Gamer', 20, 2),
(3, 3, 'Livros', 'Livro de Tecnologia', 120.00, 'Livro Tech', 15, 3),
(4, 4, 'Roupas', 'Camisa Polo', 90.00, 'Camisa Social', 50, 4),
(5, 5, 'Alimentos', 'Cesta Básica', 250.00, 'Cesta Alimentos', 30, 5);

-- Inserção de Estoque
INSERT INTO inventory (idinventory, location, product_idproduct, quantity) VALUES
(1, 'Galpão Central', 1, 8),
(2, 'Galpão Regional', 2, 15),
(3, 'Depósito Principal', 3, 10),
(4, 'Armazém Local', 4, 25),
(5, 'Centro de Distribuição', 5, 20);

-- Consultas SQL

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.name, COUNT(o.idorder) AS totalorders
FROM customer c
LEFT JOIN product_order o ON c.idcustomer = o.customer_idcustomer
GROUP BY c.name;

-- 2. Algum fornecedor também é cliente?
SELECT s.tradename AS supplier, c.name AS customer
FROM supplier s
INNER JOIN company cp ON s.cnpj = cp.cnpj
INNER JOIN customer c ON cp.customer_idcustomer = c.idcustomer;

-- 3. Relação de produtos, fornecedores e estoques
SELECT p.name AS product, s.tradename AS supplier, i.location AS inventory, i.quantity AS stockquantity
FROM product p
INNER JOIN supplier s ON p.supplier_idsupplier = s.idsupplier
LEFT JOIN inventory i ON p.idproduct = i.product_idproduct;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT s.tradename AS supplier, p.name AS product
FROM supplier s
INNER JOIN product p ON s.idsupplier = p.supplier_idsupplier;

-- 5. Total de vendas e receita gerada por categoria de produto
SELECT 
    p.category AS category,
    COUNT(p.idproduct) AS total_products_sold,
    SUM(p.price * p.quantity) AS total_revenue
FROM product p
GROUP BY p.category
ORDER BY total_revenue;

-- 6. Quantos pedidos ainda estão pendentes ou em transporte?

SELECT 
    status,
    COUNT(idorder) AS total_orders
FROM product_order
WHERE status IN ('Pendente', 'Enviado')
GROUP BY status;

-- 7. Clientes que realizaram mais de um pedido

SELECT 
    c.name AS customer_name,
    COUNT(o.idorder) AS total_orders
FROM customer c
INNER JOIN product_order o ON c.idcustomer = o.customer_idcustomer
GROUP BY c.name
HAVING COUNT(o.idorder) > 1
ORDER BY total_orders DESC;

-- 8. Produtos em falta no estoque (quantidade zero)

SELECT 
    p.name AS product_name,
    i.quantity AS stock_quantity
FROM product p
LEFT JOIN inventory i ON p.idproduct = i.product_idproduct
WHERE i.quantity = 0;

-- 9. Produtos vendidos em cada pedido

SELECT 
    o.idorder AS order_id,
    o.description AS order_description,
    p.name AS product_name,
    p.quantity AS quantity_sold,
    p.price AS unit_price,
    (p.quantity * p.price) AS total_price
FROM product_order o
INNER JOIN product p ON o.idorder = p.order_idorder
ORDER BY o.idorder;

-- 10. Detalhes dos pedidos com informações completas do cliente e pagamento

SELECT 
    o.idorder AS order_id,
    o.description AS order_description,
    o.date AS order_date,
    c.name AS customer_name,
    c.email AS customer_email,
    c.phone AS customer_phone,
    pm.description AS payment_method,
    o.status AS order_status,
    o.trackingcode AS tracking_code,
    o.shipping AS shipping_cost
FROM product_order o
INNER JOIN customer c ON o.customer_idcustomer = c.idcustomer
LEFT JOIN payment_method pm ON o.idorder = pm.idpayment_method
ORDER BY o.date DESC;
