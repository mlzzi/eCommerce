# eCommerce-DB: Modelo ER e Criação de Banco de Dados para E-commerce

Este repositório contém um diagrama de banco de dados relacional e o script SQL correspondente, criado para fins de estudo, com foco em sistemas de e-commerce. O modelo abrange entidades e relacionamentos básicos para gerenciar clientes, pedidos, produtos, fornecedores, estoque e formas de pagamento.  

## 🖼️ Diagrama ER  

![Diagrama ER](eCommerce_ER_Diagrama.png)  

## 📋 Estrutura do Modelo  

O modelo foi projetado para contemplar as principais entidades e operações de um sistema de e-commerce:  

- **Cliente**: Inclui dados de pessoas físicas (CPF e RG) e jurídicas (CNPJ e nome fantasia).  
- **Pedido**: Representa as compras realizadas pelos clientes, com status, rastreamento e custo de envio.  
- **Produto**: Armazena informações dos itens vendidos, incluindo categoria, preço e estoque.  
- **Fornecedor**: Registra fornecedores e suas localizações.  
- **Estoque**: Gerencia locais e quantidades de produtos armazenados.  
- **Forma de Pagamento**: Define os métodos de pagamento disponíveis (Crédito, Débito, Pix, Boleto, etc.).  

## 📂 Script de Criação do Banco de Dados  

O repositório também inclui um script SQL para a criação do banco de dados e inserção de dados fictícios. Este script foi desenvolvido para permitir a implementação prática do modelo em um ambiente de banco de dados relacional.  

### 🛠️ Funcionalidades do Script  

- **Criação do Banco de Dados**: Configura o banco de dados e suas tabelas.  
- **Relacionamentos e Constraints**: Inclui chaves estrangeiras, índices únicos e restrições de integridade.  
- **Inserção de Dados**: Contém dados fictícios para simulação de cenários reais, como:  
  - Clientes (pessoas físicas e jurídicas).  
  - Pedidos com diferentes status (Pendente, Pago, Cancelado, etc.).  
  - Produtos categorizados e vinculados a fornecedores e pedidos.  
  - Estoques associados a locais específicos.  
