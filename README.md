# 🛒 Projeto Banco de Dados - E-commerce

Este projeto consiste na modelagem e estruturação de um banco de dados relacional para um sistema de E-commerce. O objetivo é representar de forma eficiente os principais processos envolvidos em uma plataforma de compras online, incluindo cadastro de clientes, vendedores, produtos, pedidos, pagamentos e entregas.

---

## 📌 Sumário

- [📚 Descrição](#-descrição)
- [🧠 Modelagem Conceitual](#-modelagem-conceitual)
- [🧩 Modelagem Lógica](#-modelagem-lógica)
- [🗄️ Estrutura do Banco de Dados](#-estrutura-do-banco-de-dados)
- [🔗 Relacionamentos](#-relacionamentos)
- [📦 Tecnologias Utilizadas](#-tecnologias-utilizadas)

---

## 📚 Descrição

Este banco de dados visa atender às necessidades de um sistema de E-commerce completo, suportando:

- Clientes pessoas físicas e jurídicas
- Cadastro de produtos e estoques
- Vendedores e fornecedores
- Pedidos e histórico de compras
- Pagamentos via Pix e Cartão
- Rastreamento de entregas

---

## 🧠 Modelagem Conceitual

O modelo ER (Entidade-Relacionamento) representa:

- Entidades como `Cliente`, `Produto`, `Pedido`, `Entrega`, etc.
- Relacionamentos com cardinalidades e restrições de integridade
- Herança (generalização) entre Pessoa Física e Jurídica

> Diagrama disponível na pasta `/diagramas`.

---

## 🧩 Modelagem Lógica

O banco de dados foi modelado utilizando o MySQL com foco na normalização e consistência dos dados. Foram definidos os seguintes tipos de relacionamento:

- **1:1** → Cliente ↔ Pessoa Física / Jurídica, Pedido ↔ Entrega
- **1:N** → Cliente → Pedido, Pedido → Pagamento
- **N:N** → Pedido ↔ Produto, Produto ↔ Fornecedor, Produto ↔ Vendedor

---

## 🗄️ Estrutura do Banco de Dados

### Principais Tabelas

- `Cliente`, `PessoaFisica`, `PessoaJuridica`
- `Produto`, `ProdutoVendedor`
- `Pedido`, `PedidoProduto`, `Entrega`
- `MeioPagamento`, `Cartao`, `Pix`
- `Estoque`, `ProdutoEstoque`
- `Fornecedor`, `DisponibilizaProduto`

> Cada tabela foi criada com suas respectivas **chaves primárias e estrangeiras**, garantindo a integridade referencial.

---

## 🔗 Relacionamentos

| Tipo     | Relacionamento                                 |
|----------|------------------------------------------------|
| 1:1      | Cliente ↔ PessoaFisica / PessoaJuridica        |
| 1:1      | Pedido ↔ Entrega                               |
| 1:N      | Cliente → Pedido                               |
| 1:N      | Pedido → MeioPagamento                         |
| 1:N      | Estoque → ProdutoEstoque                       |
| N:N      | Pedido ↔ Produto (via PedidoProduto)           |
| N:N      | Produto ↔ Vendedor (via ProdutoVendedor)       |
| N:N      | Produto ↔ Fornecedor (via DisponibilizaProduto)|

---

## 📦 Tecnologias Utilizadas

- 💾 **MySQL** – Modelagem e estrutura relacional
- 🧰 **MySQL Workbench** – Criação visual do modelo EER
- 📝 **Markdown** – Documentação

---