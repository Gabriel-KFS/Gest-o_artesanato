create database AtFinal;
use AtFinal;


CREATE TABLE Fornecedor (
    FornecedorID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    InformacoesContato VARCHAR(255)
);


CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    InformacoesContato VARCHAR(255)
);


CREATE TABLE Pedido (
    PedidoID INT PRIMARY KEY,
    DataPedido DATE,
    StatusPedido VARCHAR(50),
    ClienteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE Produto (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10,2),
    QuantidadeEmEstoque INT,
    FornecedorID INT,
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID)
);


CREATE TABLE DetalhesPedido (
    DetalhesID INT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    PrecoUnitario DECIMAL(10,2),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);


CREATE INDEX idx_Fornecedor_Nome ON Fornecedor(Nome);
CREATE INDEX idx_Cliente_Nome ON Cliente(Nome);
CREATE INDEX idx_Pedido_DataPedido ON Pedido(DataPedido);


ALTER TABLE Produto ADD CONSTRAINT fk_Produto_Fornecedor 
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID);

ALTER TABLE Pedido ADD CONSTRAINT fk_Pedido_Cliente 
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID);

ALTER TABLE DetalhesPedido ADD CONSTRAINT fk_DetalhesPedido_Pedido 
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID);

ALTER TABLE DetalhesPedido ADD CONSTRAINT fk_DetalhesPedido_Produto 
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);
    
