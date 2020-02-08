/*
Executar o script com a conta SA
*/

USE master;

set nocount on;
go

-- Drop database
IF DB_ID('FundamentosTSQLBig') IS NOT NULL begin 
   ALTER DATABASE FundamentosTSQLBig set single_user with rollback immediate; 
   DROP DATABASE FundamentosTSQLBig;
end 

-- Create database
CREATE DATABASE FundamentosTSQLBig;
GO

USE FundamentosTSQLBig;
GO

---------------------------------------------------------------------
-- Create Schemas
---------------------------------------------------------------------

-- CREATE SCHEMA HR AUTHORIZATION dbo;
CREATE SCHEMA Rh AUTHORIZATION dbo;

GO
--CREATE SCHEMA Production AUTHORIZATION dbo;
CREATE SCHEMA Producao AUTHORIZATION dbo;
GO
--CREATE SCHEMA Sales AUTHORIZATION dbo;
CREATE SCHEMA Vendas AUTHORIZATION dbo;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

-- Create table RH.Empregado
-- select * from rh.Empregado
CREATE TABLE RH.Empregado
(
  iIDEmpregado     INT         NOT NULL IDENTITY,
  UltimoNome        VARCHAR(20) NOT NULL,
  PrimeiroNome      VARCHAR(10) NOT NULL,
  Cargo             VARCHAR(30) NOT NULL,
  Cortesia          VARCHAR(25) NOT NULL,
  DataAniversario   DATETIME    NOT NULL,
  DataAdmissao      DATETIME    NOT NULL,
  Endereco          VARCHAR(60) NOT NULL,
  Cidade            VARCHAR(15) NOT NULL,
  Regiao            VARCHAR(15) NULL,
  CEP               VARCHAR(10) NULL,
  Pais              VARCHAR(15) NOT NULL,
  Telefone          VARCHAR(24) NOT NULL,
  Salario           Money       NOT NULL ,
  iIDChefe          INT         NULL,
  CONSTRAINT PK_Empregado PRIMARY KEY(iIDEmpregado),
  CONSTRAINT FK_Empregado_Empregado FOREIGN KEY(iIDChefe)
    REFERENCES RH.Empregado(iIDEmpregado),
  CONSTRAINT CHK_DataAniversario CHECK(DataAniversario <= CURRENT_TIMESTAMP),
  CONSTRAINT CHK_Salario CHECK(Salario > 0)
);

CREATE NONCLUSTERED INDEX idx_nc_UltimoNome   ON RH.Empregado(UltimoNome);
CREATE NONCLUSTERED INDEX idx_nc_CEP ON RH.Empregado(CEP);

-- Create table Producao.Fornecedor
CREATE TABLE Producao.Fornecedor
(
  iIDFornecedor   INT          NOT NULL IDENTITY,
  RazaoSocial     VARCHAR(40) NOT NULL,
  Contato         VARCHAR(30) NOT NULL,
  Cargo           VARCHAR(30) NOT NULL,
  Endereco        VARCHAR(60) NOT NULL,
  Cidade          VARCHAR(15) NOT NULL,
  Regiao          VARCHAR(15) NULL,
  CEP             VARCHAR(10) NULL,
  Pais            VARCHAR(15) NOT NULL,
  Telefone        VARCHAR(24) NOT NULL,
  fax             VARCHAR(24) NULL,
  CONSTRAINT PK_Fornecedor PRIMARY KEY(iIDFornecedor)
);

CREATE NONCLUSTERED INDEX idx_nc_RazaoSocial ON Producao.Fornecedor(RazaoSocial);
CREATE NONCLUSTERED INDEX idx_nc_CEP  ON Producao.Fornecedor(CEP);

-- Create table Producao.Categoria
CREATE TABLE Producao.Categoria
(
  iIDCategoria   INT           NOT NULL IDENTITY,
  NomeCategoria  VARCHAR(15)  NOT NULL,
  Descricao      VARCHAR(200) NOT NULL,
  CONSTRAINT PK_Categoria PRIMARY KEY(iIDCategoria)
);

CREATE INDEX NomeCategoria ON Producao.Categoria(NomeCategoria);

-- Create table Producao.Produto
CREATE TABLE Producao.Produto
(
  iIDProduto    INT         NOT NULL IDENTITY,
  NomeProduto   VARCHAR(40) NOT NULL,
  iIDFornecedor INT         NOT NULL,
  iIDCategoria  INT         NOT NULL,
  PrecoUnitario MONEY       NOT NULL
    CONSTRAINT DFT_Produto_PrecoUnitario DEFAULT(0),
  Desativado    BIT          NOT NULL 
    CONSTRAINT DFT_Produto_Desativado DEFAULT(0),
  CONSTRAINT PK_Produto PRIMARY KEY(iIDProduto),
  CONSTRAINT FK_Produto_Categoria FOREIGN KEY(iIDCategoria)
    REFERENCES Producao.Categoria(iIDCategoria),
  CONSTRAINT FK_Produto_Fornecedor FOREIGN KEY(iIDFornecedor)
    REFERENCES Producao.Fornecedor(iIDFornecedor),
  CONSTRAINT CHK_Produto_PrecoUnitario CHECK(PrecoUnitario >= 0)
);

CREATE NONCLUSTERED INDEX idx_nc_iIDCategoria  ON Producao.Produto(iIDCategoria);
CREATE NONCLUSTERED INDEX idx_nc_NomeProduto   ON Producao.Produto(NomeProduto);
CREATE NONCLUSTERED INDEX idx_nc_iIDFornecedor ON Producao.Produto(iIDFornecedor);

-- Create table Vendas.Cliente
CREATE TABLE Vendas.Cliente
(
  iIDCliente   INT          NOT NULL IDENTITY,
  RazaoSocial  VARCHAR(40) NOT NULL,
  Contato      VARCHAR(30) NOT NULL,
  Cargo        VARCHAR(30) NOT NULL,
  Documento    VARCHAR(10) NULL, 
  Endereco     VARCHAR(60) NOT NULL,
  Cidade       VARCHAR(15) NOT NULL,
  Regiao       VARCHAR(15) NULL,
  CEP          VARCHAR(10) NULL,
  Pais         VARCHAR(15) NOT NULL,
  Telefone     VARCHAR(24) NOT NULL,
  fax          VARCHAR(24) NULL,
  CONSTRAINT PK_Cliente PRIMARY KEY(iIDCliente)
);

CREATE NONCLUSTERED INDEX idx_nc_Cidade      ON Vendas.Cliente(Cidade);
CREATE NONCLUSTERED INDEX idx_nc_RazaoSocial ON Vendas.Cliente(RazaoSocial);
CREATE NONCLUSTERED INDEX idx_nc_CEP         ON Vendas.Cliente(CEP);
CREATE NONCLUSTERED INDEX idx_nc_region      ON Vendas.Cliente(Regiao);

CREATE NONCLUSTERED INDEX idx_nc_RazaoSocial2 ON Vendas.Cliente(Contato,RazaoSocial)  ;
CREATE NONCLUSTERED INDEX idx_nc_RazaoSocial3 ON Vendas.Cliente(Cargo,RazaoSocial)  ;


-- Create table Vendas.Remetente
CREATE TABLE Vendas.Remetente
(
  iIDRemetente INT         NOT NULL IDENTITY,
  RazaoSocial  VARCHAR(40) NOT NULL,
  Telefone     VARCHAR(24) NOT NULL,
  CONSTRAINT PK_Remetente PRIMARY KEY(iIDRemetente)
);

-- Create table Vendas.Pedido
CREATE TABLE Vendas.Pedido
(
  iIDPedido       INT         NOT NULL ,
  iIDCliente      INT         NULL,
  iIDEmpregado    INT         NOT NULL,
  DataPedido      DATE        NOT NULL,
  DataRequisicao  DATE        NOT NULL,
  DataEnvio       DATE        NULL,
  iIDRemetente    INT         NOT NULL,
  Frete           MONEY       NOT NULL
    CONSTRAINT DFT_Pedido_Frete DEFAULT(0),
  shipname        VARCHAR(40) NOT NULL,
  shipaddress     VARCHAR(60) NOT NULL,
  shipCidade      VARCHAR(15) NOT NULL,
  shipregion      VARCHAR(15) NULL,
  shipCEP         VARCHAR(10) NULL,
  shipPais        VARCHAR(15) NOT NULL,
  CONSTRAINT PK_Pedido PRIMARY KEY(iIDPedido),
  CONSTRAINT FK_Pedido_Cliente FOREIGN KEY(iIDCliente)
    REFERENCES Vendas.Cliente(iIDCliente),
  CONSTRAINT FK_Pedido_Empregado FOREIGN KEY(iIDEmpregado)
    REFERENCES RH.Empregado(iIDEmpregado),
  CONSTRAINT FK_Pedido_Remetente FOREIGN KEY(iIDRemetente)
    REFERENCES Vendas.Remetente(iIDRemetente)
);

CREATE NONCLUSTERED INDEX idx_nc_iIDCliente   ON Vendas.Pedido(iIDCliente);
CREATE NONCLUSTERED INDEX idx_nc_iIDEmpregado ON Vendas.Pedido(iIDEmpregado);
CREATE NONCLUSTERED INDEX idx_nc_iIDRemetente ON Vendas.Pedido(iIDRemetente);
CREATE NONCLUSTERED INDEX idx_nc_DataPedido   ON Vendas.Pedido(DataPedido);
CREATE NONCLUSTERED INDEX idx_nc_DataEnvio    ON Vendas.Pedido(DataEnvio);
CREATE NONCLUSTERED INDEX idx_nc_shipCEP      ON Vendas.Pedido(shipCEP);

CREATE NONCLUSTERED INDEX idx_nc_DataPedido1  ON Vendas.Pedido(iidpedido desc,datapedido desc, iidcliente desc ) 




-- Create table Vendas.ItensPedido
CREATE TABLE Vendas.ItensPedido
(
  iIDPedido     INT           NOT NULL,
  iIDProduto    INT           NOT NULL,
  PrecoUnitario MONEY         NOT NULL
    CONSTRAINT DFT_ItensPedido_PrecoUnitario DEFAULT(0),
  Quantidade     SMALLINT      NOT NULL
    CONSTRAINT DFT_ItensPedido_Quantidade DEFAULT(1),
  Desconto  NUMERIC(4, 3) NOT NULL
    CONSTRAINT DFT_ItensPedido_Desconto DEFAULT(0),
  CONSTRAINT PK_ItensPedido PRIMARY KEY(iIDPedido, iIDProduto),
  CONSTRAINT FK_ItensPedido_Pedido FOREIGN KEY(iIDPedido)
    REFERENCES Vendas.Pedido(iIDPedido),
  CONSTRAINT FK_ItensPedido_Produto FOREIGN KEY(iIDProduto)
    REFERENCES Producao.Produto(iIDProduto),
  CONSTRAINT CHK_Desconto  CHECK (Desconto BETWEEN 0 AND 1),
  CONSTRAINT CHK_Quantidade  CHECK (Quantidade > 0),
  CONSTRAINT CHK_PrecoUnitario CHECK (PrecoUnitario >= 0)
)

CREATE NONCLUSTERED INDEX idx_nc_iIDPedido   ON Vendas.ItensPedido(iIDPedido);
CREATE NONCLUSTERED INDEX idx_nc_iIDProduto ON Vendas.ItensPedido(iIDProduto);
GO

---------------------------------------------------------------------
-- Populate table Tables
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Populate table Tables
---------------------------------------------------------------------
Begin transaction 

-- Populate table RH.Empregado
SET IDENTITY_INSERT RH.Empregado ON;
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(1, N'Davis', N'Sara', N'CEO', N'Ms.', '19581208', '20020501', N'7890 - 20th Ave. E., Apt. 2A', N'Seattle', N'WA', N'10003', N'USA', N'(206) 555-0101', 200000 , NULL);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(2, N'Funk', N'Don', N'Vice President, Sales', N'Dr.', '19620219', '20020814', N'9012 W. Capital Way', N'Tacoma', N'WA', N'10001', N'USA', N'(206) 555-0100', 130000 ,1);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(3, N'Lew', N'Judy', N'Sales Manager', N'Ms.', '19730830', '20020401', N'2345 Moss Bay Blvd.', N'Kirkland', N'WA', N'10007', N'USA', N'(206) 555-0103', 55000 ,2);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(4, N'Peled', N'Yael', N'Sales Representative', N'Mrs.', '19470919', '20030503', N'5678 Old Redmond Rd.', N'Redmond', N'WA', N'10009', N'USA', N'(206) 555-0104', 40100 , 3);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(5, N'Buck', N'Sven', N'Sales Manager', N'Mr.', '19650304', '20031017', N'8901 Garrett Hill', N'London', NULL, N'10004', N'UK', N'(71) 234-5678', 58000, 2);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(6, N'Suurs', N'Paul', N'Sales Representative', N'Mr.', '19730702', '20031017', N'3456 Coventry House, Miner Rd.', N'London', NULL, N'10005', N'UK', N'(71) 345-6789',40500, 5);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(7, N'King', N'Russell', N'Sales Representative', N'Mr.', '19700529', '20040102', N'6789 Edgeham Hollow, Winchester Way', N'London', NULL, N'10002', N'UK', N'(71) 123-4567', 39900 , 5);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(8, N'Cameron', N'Maria', N'Sales Representative', N'Ms.', '19680109', '20040305', N'4567 - 11th Ave. N.E.', N'Seattle', N'WA', N'10006', N'USA', N'(206) 555-0102', 40000,3);
INSERT INTO RH.Empregado(iIDEmpregado, UltimoNome, PrimeiroNome, Cargo, cortesia, DataAniversario, DataAdmissao,Endereco, Cidade,Regiao, CEP, Pais, Telefone, Salario, iIDChefe)
  VALUES(9, N'Dolgopyatova', N'Zoya', N'Sales Representative', N'Ms.', '19760127', '20041115', N'1234 Houndstooth Rd.', N'London', NULL, N'10008', N'UK', N'(71) 456-7890', 41500, 5);
SET IDENTITY_INSERT RH.Empregado OFF;

-- Populate table Producao.Fornecedor
SET IDENTITY_INSERT Producao.Fornecedor ON;
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(1, N'Supplier SWRXU', N'Adolphi, Stephan', N'Purchasing Manager', N'2345 Gilbert St.', N'London', NULL, N'10023', N'UK', N'(171) 456-7890', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(2, N'Supplier VHQZD', N'Hance, Jim', N'Order Administrator', N'P.O. Box 5678', N'New Orleans', N'LA', N'10013', N'USA', N'(100) 555-0111', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(3, N'Supplier STUAZ', N'Parovszky, Alfons', N'Sales Representative', N'1234 Oxford Rd.', N'Ann Arbor', N'MI', N'10026', N'USA', N'(313) 555-0109', N'(313) 555-0112');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(4, N'Supplier QOVFD', N'Bal�zs, Erzs�bet', N'Marketing Manager', N'7890 Sekimai Musashino-shi', N'Tokyo', NULL, N'10011', N'Japan', N'(03) 6789-0123', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(5, N'Supplier EQPNC', N'Holm, Michael', N'Export Administrator', N'Calle del Rosal 4567', N'Oviedo', N'Asturias', N'10029', N'Spain', N'(98) 123 45 67', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(6, N'Supplier QWUSF', N'Popkova, Darya', N'Marketing Representative', N'8901 Setsuko Chuo-ku', N'Osaka', NULL, N'10028', N'Japan', N'(06) 789-0123', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(7, N'Supplier GQRCV', N'R�bild, Jesper', N'Marketing Manager', N'5678 Rose St. Moonie Ponds', N'Melbourne', N'Victoria', N'10018', N'Australia', N'(03) 123-4567', N'(03) 456-7890');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(8, N'Supplier BWGYE', N'Iallo, Lucio', N'Sales Representative', N'9012 King''s Way', N'Manchester', NULL, N'10021', N'UK', N'(161) 567-8901', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(9, N'Supplier QQYEU', N'Basalik, Evan', N'Sales Agent', N'Kaloadagatan 4567', N'G�teborg', NULL, N'10022', N'Sweden', N'031-345 67 89', N'031-678 90 12');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(10, N'Supplier UNAHG', N'Barnett, Dave', N'Marketing Manager', N'Av. das Americanas 2345', N'Sao Paulo', NULL, N'10034', N'Brazil', N'(11) 345 6789', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(11, N'Supplier ZPYVS', N'Jain, Mukesh', N'Sales Manager', N'Tiergartenstra�e 3456', N'Berlin', NULL, N'10016', N'Germany', N'(010) 3456789', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(12, N'Supplier SVIYA', N'Regev, Barak', N'International Marketing Mgr.', N'Bogenallee 9012', N'Frankfurt', NULL, N'10024', N'Germany', N'(069) 234567', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(13, N'Supplier TEGSC', N'Brehm, Peter', N'Coordinator Foreign Markets', N'Frahmredder 3456', N'Cuxhaven', NULL, N'10019', N'Germany', N'(04721) 1234', N'(04721) 2345');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(14, N'Supplier KEREV', N'Keil, Kendall', N'Sales Representative', N'Viale Dante, 6789', N'Ravenna', NULL, N'10015', N'Italy', N'(0544) 56789', N'(0544) 34567');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(15, N'Supplier NZLIF', N'Sa?as-Szlejter, Karolina', N'Marketing Manager', N'Hatlevegen 1234', N'Sandvika', NULL, N'10025', N'Norway', N'(0)9-012345', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(16, N'Supplier UHZRG', N'Scholl, Thorsten', N'Regional Account Rep.', N'8901 - 8th Avenue Suite 210', N'Bend', N'OR', N'10035', N'USA', N'(503) 555-0108', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(17, N'Supplier QZGUF', N'Kleinerman, Christian', N'Sales Representative', N'Brovallav�gen 0123', N'Stockholm', NULL, N'10033', N'Sweden', N'08-234 56 78', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(18, N'Supplier LVJUA', N'Canel, Fabrice', N'Sales Manager', N'3456, Rue des Francs-Bourgeois', N'Paris', NULL, N'10031', N'France', N'(1) 90.12.34.56', N'(1) 01.23.45.67');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(19, N'Supplier JDNUG', N'Chapman, Greg', N'Wholesale Account Agent', N'Order Processing Dept. 7890 Paul Revere Blvd.', N'Boston', N'MA', N'10027', N'USA', N'(617) 555-0110', N'(617) 555-0113');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(20, N'Supplier CIYNM', N'K�szegi, Em�lia', N'Owner', N'6789 Serangoon Loop, Suite #402', N'Singapore', NULL, N'10037', N'Singapore', N'012-3456', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(21, N'Supplier XOXZA', N'Shakespear, Paul', N'Sales Manager', N'Lyngbysild Fiskebakken 9012', N'Lyngby', NULL, N'10012', N'Denmark', N'67890123', N'78901234');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(22, N'Supplier FNUXM', N'Skelly, Bonnie L.', N'Accounting Manager', N'Verkoop Rijnweg 8901', N'Zaandam', NULL, N'10014', N'Netherlands', N'(12345) 8901', N'(12345) 5678');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(23, N'Supplier ELCRN', N'LaMee, Brian', N'Product Manager', N'Valtakatu 1234', N'Lappeenranta', NULL, N'10032', N'Finland', N'(953) 78901', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(24, N'Supplier JNNES', N'Clark, Molly', N'Sales Representative', N'6789 Prince Edward Parade Hunter''s Hill', N'Sydney', N'NSW', N'10030', N'Australia', N'(02) 234-5678', N'(02) 567-8901');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(25, N'Supplier ERVYZ', N'Sprenger, Christof', N'Marketing Manager', N'7890 Rue St. Laurent', N'Montr�al', N'Qu�bec', N'10017', N'Canada', N'(514) 456-7890', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(26, N'Supplier ZWZDM', N'Cunha, Gon�alo', N'Order Administrator', N'Via dei Gelsomini, 5678', N'Salerno', NULL, N'10020', N'Italy', N'(089) 4567890', N'(089) 4567890');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(27, N'Supplier ZRYDZ', N'Leoni, Alessandro', N'Sales Manager', N'4567, rue H. Voiron', N'Montceau', NULL, N'10036', N'France', N'89.01.23.45', NULL);
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(28, N'Supplier OAVQT', N'Teper, Jeff', N'Sales Representative', N'Bat. B 2345, rue des Alpes', N'Annecy', NULL, N'10010', N'France', N'01.23.45.67', N'89.01.23.45');
INSERT INTO Producao.Fornecedor(iIDFornecedor, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(29, N'Supplier OGLRK', N'Walters, Rob', N'Accounting Manager', N'0123 rue Chasseur', N'Ste-Hyacinthe', N'Qu�bec', N'10009', N'Canada', N'(514) 567-890', N'(514) 678-9012');
SET IDENTITY_INSERT Producao.Fornecedor OFF;

-- Populate table Producao.Categoria
SET IDENTITY_INSERT Producao.Categoria ON;
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(3, N'Confections', N'Desserts, candies, and sweet breads');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(4, N'Dairy Produto', N'Cheeses');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(6, N'Meat/Poultry', N'Prepared meats');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(7, N'Produce', N'Dried fruit and bean curd');
INSERT INTO Producao.Categoria(iIDCategoria, NomeCategoria, Descricao)
  VALUES(8, N'Seafood', N'Seaweed and fish');
SET IDENTITY_INSERT Producao.Categoria OFF;

-- Populate table Producao.Produto
SET IDENTITY_INSERT Producao.Produto ON;
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(1, N'Product HHYDP', 1, 1, 18.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(2, N'Product RECZE', 1, 1, 19.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(3, N'Product IMEHJ', 1, 2, 10.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(4, N'Product KSBRM', 2, 2, 22.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(5, N'Product EPEIM', 2, 2, 21.35, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(6, N'Product VAIIV', 3, 2, 25.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(7, N'Product HMLNI', 3, 7, 30.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(8, N'Product WVJFP', 3, 2, 40.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(9, N'Product AOZBW', 4, 6, 97.00, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(10, N'Product YHXGE', 4, 8, 31.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(11, N'Product QMVUN', 5, 4, 21.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(12, N'Product OSFNS', 5, 4, 38.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(13, N'Product POXFU', 6, 8, 6.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(14, N'Product PWCJB', 6, 7, 23.25, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(15, N'Product KSZOI', 6, 2, 15.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(16, N'Product PAFRH', 7, 3, 17.45, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(17, N'Product BLCAX', 7, 6, 39.00, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(18, N'Product CKEDC', 7, 8, 62.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(19, N'Product XKXDO', 8, 3, 9.20, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(20, N'Product QHFFP', 8, 3, 81.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(21, N'Product VJZZH', 8, 3, 10.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(22, N'Product CPHFY', 9, 5, 21.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(23, N'Product JLUDZ', 9, 5, 9.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(24, N'Product QOGNU', 10, 1, 4.50, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(25, N'Product LYLNI', 11, 3, 14.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(26, N'Product HLGZA', 11, 3, 31.23, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(27, N'Product SMIOH', 11, 3, 43.90, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(28, N'Product OFBNT', 12, 7, 45.60, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(29, N'Product VJXYN', 12, 6, 123.79, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(30, N'Product LYERX', 13, 8, 25.89, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(31, N'Product XWOXC', 14, 4, 12.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(32, N'Product NUNAW', 14, 4, 32.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(33, N'Product ASTMN', 15, 4, 2.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(34, N'Product SWNJY', 16, 1, 14.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(35, N'Product NEVTJ', 16, 1, 18.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(36, N'Product GMKIJ', 17, 8, 19.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(37, N'Product EVFFA', 17, 8, 26.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(38, N'Product QDOMO', 18, 1, 263.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(39, N'Product LSOFL', 18, 1, 18.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(40, N'Product YZIXQ', 19, 8, 18.40, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(41, N'Product TTEEX', 19, 8, 9.65, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(42, N'Product RJVNM', 20, 5, 14.00, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(43, N'Product ZZZHR', 20, 1, 46.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(44, N'Product VJIEO', 20, 2, 19.45, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(45, N'Product AQOKR', 21, 8, 9.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(46, N'Product CBRRL', 21, 8, 12.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(47, N'Product EZZPR', 22, 3, 9.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(48, N'Product MYNXN', 22, 3, 12.75, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(49, N'Product FPYPN', 23, 3, 20.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(50, N'Product BIUDV', 23, 3, 16.25, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(51, N'Product APITJ', 24, 7, 53.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(52, N'Product QSRXF', 24, 5, 7.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(53, N'Product BKGEA', 24, 6, 32.80, 1);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(54, N'Product QAQRL', 25, 6, 7.45, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(55, N'Product YYWRT', 25, 6, 24.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(56, N'Product VKCMF', 26, 5, 38.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(57, N'Product OVLQI', 26, 5, 19.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(58, N'Product ACRVI', 27, 8, 13.25, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(59, N'Product UKXRI', 28, 4, 55.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(60, N'Product WHBYK', 28, 4, 34.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(61, N'Product XYZPE', 29, 2, 28.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(62, N'Product WUXYK', 29, 3, 49.30, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(63, N'Product ICKNK', 7, 2, 43.90, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(64, N'Product HCQDE', 12, 5, 33.25, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(65, N'Product XYWBZ', 2, 2, 21.05, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(66, N'Product LQMGN', 2, 2, 17.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(67, N'Product XLXQF', 16, 1, 14.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(68, N'Product TBTBL', 8, 3, 12.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(69, N'Product COAXA', 15, 4, 36.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(70, N'Product TOONT', 7, 1, 15.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(71, N'Product MYMOI', 15, 4, 21.50, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(72, N'Product GEEOO', 14, 4, 34.80, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(73, N'Product WEUJZ', 17, 8, 15.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(74, N'Product BKAZJ', 4, 7, 10.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(75, N'Product BWRLG', 12, 1, 7.75, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(76, N'Product JYGFE', 23, 1, 18.00, 0);
INSERT INTO Producao.Produto(iIDProduto, NomeProduto, iIDFornecedor, iIDCategoria, PrecoUnitario, Desativado)
  VALUES(77, N'Product LUNZZ', 12, 2, 13.00, 0);
SET IDENTITY_INSERT Producao.Produto OFF;

-- Populate table Vendas.Cliente
SET IDENTITY_INSERT Vendas.Cliente ON;
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(1, N'Customer NRZBB', N'Allen, Michael', N'Sales Representative', N'Obere Str. 0123', N'Berlin', NULL, N'10092', N'Germany', N'030-3456789', N'030-0123456');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(2, N'Customer MLTDN', N'Hassall, Mark', N'Owner', N'Avda. de la Constituci�n 5678', N'M�xico D.F.', NULL, N'10077', N'Mexico', N'(5) 789-0123', N'(5) 456-7890');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(3, N'Customer KBUDE', N'Peoples, John', N'Owner', N'Mataderos  7890', N'M�xico D.F.', NULL, N'10097', N'Mexico', N'(5) 123-4567', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(4, N'Customer HFBZG', N'Arndt, Torsten', N'Sales Representative', N'7890 Hanover Sq.', N'London', NULL, N'10046', N'UK', N'(171) 456-7890', N'(171) 456-7891');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(5, N'Customer HGVLZ', N'Higginbotham, Tom', N'Order Administrator', N'Berguvsv�gen  5678', N'Lule�', NULL, N'10112', N'Sweden', N'0921-67 89 01', N'0921-23 45 67');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(6, N'Customer XHXJV', N'Poland, Carole', N'Sales Representative', N'Forsterstr. 7890', N'Mannheim', NULL, N'10117', N'Germany', N'0621-67890', N'0621-12345');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(7, N'Customer QXVLA', N'Bansal, Dushyant', N'Marketing Manager', N'2345, place Kl�ber', N'Strasbourg', NULL, N'10089', N'France', N'67.89.01.23', N'67.89.01.24');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(8, N'Customer QUHWH', N'Ilyina, Julia', N'Owner', N'C/ Araquil, 0123', N'Madrid', NULL, N'10104', N'Spain', N'(91) 345 67 89', N'(91) 012 34 56');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(9, N'Customer RTXGC', N'Raghav, Amritansh', N'Owner', N'6789, rue des Bouchers', N'Marseille', NULL, N'10105', N'France', N'23.45.67.89', N'23.45.67.80');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(10, N'Customer EEALV', N'Bassols, Pilar Colome', N'Accounting Manager', N'8901 Tsawassen Blvd.', N'Tsawassen', N'BC', N'10111', N'Canada', N'(604) 901-2345', N'(604) 678-9012');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(11, N'Customer UBHAU', N'Jaffe, David', N'Sales Representative', N'Fauntleroy Circus 4567', N'London', NULL, N'10064', N'UK', N'(171) 789-0123', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(12, N'Customer PSNMQ', N'Ray, Mike', N'Sales Agent', N'Cerrito 3456', N'Buenos Aires', NULL, N'10057', N'Argentina', N'(1) 890-1234', N'(1) 567-8901');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(13, N'Customer VMLOG', N'Benito, Almudena', N'Marketing Manager', N'Sierras de Granada 7890', N'M�xico D.F.', NULL, N'10056', N'Mexico', N'(5) 456-7890', N'(5) 123-4567');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(14, N'Customer WNMAF', N'Jelitto, Jacek', N'Owner', N'Hauptstr. 0123', N'Bern', NULL, N'10065', N'Switzerland', N'0452-678901', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(15, N'Customer JUWXK', N'Richardson, Shawn', N'Sales Associate', N'Av. dos Lus�adas, 6789', N'Sao Paulo', N'SP', N'10087', N'Brazil', N'(11) 012-3456', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(16, N'Customer GYBBY', N'Birkby, Dana', N'Sales Representative', N'Berkeley Gardens 0123 Brewery', N'London', NULL, N'10039', N'UK', N'(171) 234-5678', N'(171) 234-5679');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(17, N'Customer FEVNN', N'Jones, TiAnna', N'Order Administrator', N'Walserweg 4567', N'Aachen', NULL, N'10067', N'Germany', N'0241-789012', N'0241-345678');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(18, N'Customer BSVAR', N'Rizaldy, Arif', N'Owner', N'3456, rue des Cinquante Otages', N'Nantes', NULL, N'10041', N'France', N'89.01.23.45', N'89.01.23.46');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(19, N'Customer RFNQC', N'Boseman, Randall', N'Sales Agent', N'5678 King George', N'London', NULL, N'10110', N'UK', N'(171) 345-6789', N'(171) 345-6780');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(20, N'Customer THHDP', N'Kane, John', N'Sales Manager', N'Kirchgasse 9012', N'Graz', NULL, N'10059', N'Austria', N'1234-5678', N'9012-3456');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(21, N'Customer KIDPX', N'Russo, Giuseppe', N'Marketing Assistant', N'Rua Or�s, 3456', N'Sao Paulo', N'SP', N'10096', N'Brazil', N'(11) 456-7890', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(22, N'Customer DTDMN', N'Bueno, Janaina Burdan, Neville', N'Accounting Manager', N'C/ Moralzarzal, 5678', N'Madrid', NULL, N'10080', N'Spain', N'(91) 890 12 34', N'(91) 567 89 01');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(23, N'Customer WVFAF', N'Khanna, Karan', N'Assistant Sales Agent', N'4567, chauss�e de Tournai', N'Lille', NULL, N'10048', N'France', N'45.67.89.01', N'45.67.89.02');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(24, N'Customer CYZTN', N'San Juan, Patricia', N'Owner', N'�kergatan 5678', N'Br�cke', NULL, N'10114', N'Sweden', N'0695-67 89 01', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(25, N'Customer AZJED', N'Carlson, Jason', N'Marketing Manager', N'Berliner Platz 9012', N'M�nchen', NULL, N'10091', N'Germany', N'089-8901234', N'089-5678901');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(26, N'Customer USDBG', N'Koch, Paul', N'Marketing Manager', N'9012, rue Royale', N'Nantes', NULL, N'10101', N'France', N'34.56.78.90', N'34.56.78.91');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(27, N'Customer WMFEA', N'Schm�llerl, Martin', N'Sales Representative', N'Via Monte Bianco 4567', N'Torino', NULL, N'10099', N'Italy', N'011-2345678', N'011-9012345');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(28, N'Customer XYUFB', N'Cavaglieri, Giorgio', N'Sales Manager', N'Jardim das rosas n. 8901', N'Lisboa', NULL, N'10054', N'Portugal', N'(1) 456-7890', N'(1) 123-4567');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(29, N'Customer MDLWA', N'Kolesnikova, Katerina', N'Marketing Manager', N'Rambla de Catalu�a, 8901', N'Barcelona', NULL, N'10081', N'Spain', N'(93) 789 0123', N'(93) 456 7890');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(30, N'Customer KSLQF', N'Shabalin, Rostislav', N'Sales Manager', N'C/ Romero, 1234', N'Sevilla', NULL, N'10075', N'Spain', N'(95) 901 23 45', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(31, N'Customer YJCBX', N'Cheng, Yao-Qiang', N'Sales Associate', N'Av. Brasil, 5678', N'Campinas', N'SP', N'10128', N'Brazil', N'(11) 567-8901', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(32, N'Customer YSIQX', N'Krishnan, Venky', N'Marketing Manager', N'6789 Baker Blvd.', N'Eugene', N'OR', N'10070', N'USA', N'(503) 555-0122', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(33, N'Customer FVXPQ', N'Sigurdarson, Hallur ', N'Owner', N'5� Ave. Los Palos Grandes 3456', N'Caracas', N'DF', N'10043', N'Venezuela', N'(2) 789-0123', N'(2) 456-7890');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(34, N'Customer IBVRG', N'Cohen, Shy', N'Accounting Manager', N'Rua do Pa�o, 7890', N'Rio de Janeiro', N'RJ', N'10076', N'Brazil', N'(21) 789-0123', N'(21) 789-0124');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(35, N'Customer UMTLM', N'Langohr, Kris', N'Sales Representative', N'Carrera 1234 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'10066', N'Venezuela', N'(5) 567-8901', N'(5) 234-5678');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(36, N'Customer LVJSO', N'Smith, Denise', N'Sales Representative', N'Cidade Center Plaza 2345 Main St.', N'Elgin', N'OR', N'10103', N'USA', N'(503) 555-0126', N'(503) 555-0135');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(37, N'Customer FRXZL', N'Cr?ciun, Ovidiu V.', N'Sales Associate', N'9012 Johnstown Road', N'Cork', N'Co. Cork', N'10051', N'Ireland', N'8901 234', N'5678 9012');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(38, N'Customer LJUCA', N'Lee, Frank', N'Marketing Manager', N'Garden House Crowther Way 3456', N'Cowes', N'Isle of Wight', N'10063', N'UK', N'(198) 567-8901', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(39, N'Customer GLLAG', N'Song, Lolan', N'Sales Associate', N'Maubelstr. 8901', N'Brandenburg', NULL, N'10060', N'Germany', N'0555-34567', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(40, N'Customer EFFTC', N'De Oliveira, Jose', N'Sales Representative', N'2345, avenue de l''Europe', N'Versailles', NULL, N'10108', N'France', N'12.34.56.78', N'12.34.56.79');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(41, N'Customer XIIWM', N'Litton, Tim', N'Sales Manager', N'3456 rue Alsace-Lorraine', N'Toulouse', NULL, N'10053', N'France', N'90.12.34.56', N'90.12.34.57');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(42, N'Customer IAIJK', N'Steiner, Dominik', N'Marketing Assistant', N'2345 Oak St.', N'Vancouver', N'BC', N'10098', N'Canada', N'(604) 567-8901', N'(604) 234-5678');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(43, N'Customer UISOJ', N'Deshpande, Anu', N'Marketing Manager', N'8901 Orchestra Terrace', N'Walla Walla', N'WA', N'10069', N'USA', N'(509) 555-0119', N'(509) 555-0130');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(44, N'Customer OXFRU', N'Louverdis, George', N'Sales Representative', N'Magazinweg 8901', N'Frankfurt a.M.', NULL, N'10095', N'Germany', N'069-7890123', N'069-4567890');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(45, N'Customer QXPPT', N'Sunkammurali,  Krishna', N'Owner', N'1234 Polk St. Suite 5', N'San Francisco', N'CA', N'10062', N'USA', N'(415) 555-0118', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(46, N'Customer XPNIK', N'Dressler, Marlies', N'Accounting Manager', N'Carrera 7890 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'10093', N'Venezuela', N'(9) 789-0123', N'(9) 456-7890');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(47, N'Customer PSQUZ', N'Lupu, Cornel', N'Owner', N'Ave. 5 de Mayo Porlamar 5678', N'I. de Margarita', N'Nueva Esparta', N'10121', N'Venezuela', N'(8) 01-23-45', N'(8) 67-89-01');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(48, N'Customer DVFMB', N'Szymczak, Rados?aw', N'Sales Manager', N'9012 Chiaroscuro Rd.', N'Portland', N'OR', N'10073', N'USA', N'(503) 555-0117', N'(503) 555-0129');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(49, N'Customer CQRAA', N'Duerr, Bernard', N'Marketing Manager', N'Via Ludovico il Moro 6789', N'Bergamo', NULL, N'10106', N'Italy', N'035-345678', N'035-901234');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(50, N'Customer JYPSC', N'Mace, Donald', N'Sales Agent', N'Rue Joseph-Bens 0123', N'Bruxelles', NULL, N'10074', N'Belgium', N'(02) 890 12 34', N'(02) 567 89 01');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(51, N'Customer PVDZC', N'Taylor, Maurice', N'Marketing Assistant', N'8901 rue St. Laurent', N'Montr�al', N'Qu�bec', N'10040', N'Canada', N'(514) 345-6789', N'(514) 012-3456');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(52, N'Customer PZNLA', N'Dupont-Roc, Patrice', N'Marketing Assistant', N'Heerstr. 4567', N'Leipzig', NULL, N'10125', N'Germany', N'0342-12345', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(53, N'Customer GCJSG', N'Mallit, Ken', N'Sales Associate', N'South House 1234 Queensbridge', N'London', NULL, N'10061', N'UK', N'(171) 890-1234', N'(171) 890-1235');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(54, N'Customer TDKEG', N'Tiano, Mike', N'Sales Agent', N'Ing. Gustavo Moncada 0123 Piso 20-A', N'Buenos Aires', NULL, N'10094', N'Argentina', N'(1) 123-4567', N'(1) 890-1234');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(55, N'Customer KZQZT', N'Egelund-Muller, Anja', N'Sales Representative', N'7890 Bering St.', N'Anchorage', N'AK', N'10050', N'USA', N'(907) 555-0115', N'(907) 555-0128');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(56, N'Customer QNIVZ', N'Marinova, Nadejda', N'Owner', N'Mehrheimerstr. 9012', N'K�ln', NULL, N'10047', N'Germany', N'0221-0123456', N'0221-7890123');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(57, N'Customer WVAXS', N'Tollevsen, Bj�rn', N'Owner', N'5678, boulevard Charonne', N'Paris', NULL, N'10085', N'France', N'(1) 89.01.23.45', N'(1) 89.01.23.46');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(58, N'Customer AHXHT', N'Fakhouri, Fadi', N'Sales Representative', N'Calle Dr. Jorge Cash 8901', N'M�xico D.F.', NULL, N'10116', N'Mexico', N'(5) 890-1234', N'(5) 567-8901');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(59, N'Customer LOLJO', N'Meston, Tosh', N'Sales Manager', N'Geislweg 2345', N'Salzburg', NULL, N'10127', N'Austria', N'4567-8901', N'2345-6789');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(60, N'Customer QZURI', N'Uppal, Sunil', N'Sales Representative', N'Estrada da sa�de n. 6789', N'Lisboa', NULL, N'10083', N'Portugal', N'(1) 789-0123', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(61, N'Customer WULWD', N'Florczyk, Krzysztof', N'Accounting Manager', N'Rua da Panificadora, 1234', N'Rio de Janeiro', N'RJ', N'10115', N'Brazil', N'(21) 678-9012', N'(21) 678-9013');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(62, N'Customer WFIZJ', N'Misiec, Anna', N'Marketing Assistant', N'Alameda dos Can�rios, 1234', N'Sao Paulo', N'SP', N'10102', N'Brazil', N'(11) 901-2345', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(63, N'Customer IRRVL', N'Veronesi, Giorgio', N'Accounting Manager', N'Taucherstra�e 1234', N'Cunewalde', NULL, N'10126', N'Germany', N'0372-12345', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(64, N'Customer LWGMD', N'Gaffney, Lawrie', N'Sales Representative', N'Av. del Libertador 3456', N'Buenos Aires', NULL, N'10124', N'Argentina', N'(1) 234-5678', N'(1) 901-2345');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(65, N'Customer NYUHS', N'Moore, Michael', N'Assistant Sales Representative', N'6789 Milton Dr.', N'Albuquerque', N'NM', N'10109', N'USA', N'(505) 555-0125', N'(505) 555-0134');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(66, N'Customer LHANT', N'Voss, Florian', N'Sales Associate', N'Strada Provinciale 7890', N'Reggio Emilia', NULL, N'10038', N'Italy', N'0522-012345', N'0522-678901');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(67, N'Customer QVEPD', N'Garden, Euan', N'Assistant Sales Agent', N'Av. Copacabana, 6789', N'Rio de Janeiro', N'RJ', N'10052', N'Brazil', N'(21) 345-6789', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(68, N'Customer CCKOT', N'Myrcha, Jacek', N'Sales Manager', N'Grenzacherweg 0123', N'Gen�ve', NULL, N'10122', N'Switzerland', N'0897-012345', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(69, N'Customer SIUIH', N'Watters, Jason M.', N'Accounting Manager', N'Gran V�a, 4567', N'Madrid', NULL, N'10071', N'Spain', N'(91) 567 8901', N'(91) 234 5678');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(70, N'Customer TMXGN', N'Ginters, Kaspars', N'Owner', N'Erling Skakkes gate 2345', N'Stavern', NULL, N'10123', N'Norway', N'07-89 01 23', N'07-45 67 89');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(71, N'Customer LCOUJ', N'Navarro, Tom�s', N'Sales Representative', N'9012 Suffolk Ln.', N'Boise', N'ID', N'10078', N'USA', N'(208) 555-0116', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(72, N'Customer AHPOP', N'Welcker, Brian', N'Sales Manager', N'4567 Wadhurst Rd.', N'London', NULL, N'10088', N'UK', N'(171) 901-2345', N'(171) 901-2346');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(73, N'Customer JMIKW', N'Gonzalez, Nuria', N'Owner', N'Vinb�ltet 3456', N'Kobenhavn', NULL, N'10079', N'Denmark', N'12 34 56 78', N'90 12 34 56');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(74, N'Customer YSHXL', N'O�Brien, Dave', N'Marketing Manager', N'9012, rue Lauriston', N'Paris', NULL, N'10058', N'France', N'(1) 23.45.67.89', N'(1) 23.45.67.80');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(75, N'Customer XOJYP', N'Wojciechowska, Agnieszka', N'Sales Manager', N'P.O. Box 1234', N'Lander', N'WY', N'10113', N'USA', N'(307) 555-0114', N'(307) 555-0127');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(76, N'Customer SFOGW', N'Gulbis, Katrin', N'Accounting Manager', N'Boulevard Tirou, 2345', N'Charleroi', NULL, N'10100', N'Belgium', N'(071) 56 78 90 12', N'(071) 34 56 78 90');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(77, N'Customer LCYBZ', N'Osorio, Cristian', N'Marketing Manager', N'2345 Jefferson Way Suite 2', N'Portland', N'OR', N'10042', N'USA', N'(503) 555-0120', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(78, N'Customer NLTYP', N'Young, Robin', N'Marketing Assistant', N'0123 Grizzly Peak Rd.', N'Butte', N'MT', N'10107', N'USA', N'(406) 555-0121', N'(406) 555-0131');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(79, N'Customer FAPSM', N'Wickham, Jim', N'Marketing Manager', N'Luisenstr. 0123', N'M�nster', NULL, N'10118', N'Germany', N'0251-456789', N'0251-012345');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(80, N'Customer VONTK', N'Geschwandtner, Jens', N'Owner', N'Avda. Azteca 4567', N'M�xico D.F.', NULL, N'10044', N'Mexico', N'(5) 678-9012', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(81, N'Customer YQQWW', N'Nagel, Jean-Philippe', N'Sales Representative', N'Av. In�s de Castro, 1234', N'Sao Paulo', N'SP', N'10120', N'Brazil', N'(11) 123-4567', N'(11) 234-5678');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(82, N'Customer EYHKM', N'Veninga, Tjeerd', N'Sales Associate', N'1234 DaVinci Blvd.', N'Kirkland', N'WA', N'10119', N'USA', N'(206) 555-0124', N'(206) 555-0133');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(83, N'Customer ZRNDE', N'Fonteneau, Karl', N'Sales Manager', N'Smagsloget 3456', N'�rhus', NULL, N'10090', N'Denmark', N'23 45 67 89', N'01 23 45 67');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(84, N'Customer NRCSK', N'Tuntisangaroon, Sittichai', N'Sales Agent', N'6789, rue du Commerce', N'Lyon', NULL, N'10072', N'France', N'78.90.12.34', N'78.90.12.35');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(85, N'Customer ENQZT', N'McLin, Nkenge', N'Accounting Manager', N'5678 rue de l''Abbaye', N'Reims', NULL, N'10082', N'France', N'56.78.90.12', N'56.78.90.13');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(86, N'Customer SNXOJ', N'Syamala, Manoj', N'Sales Representative', N'Adenauerallee 7890', N'Stuttgart', NULL, N'10086', N'Germany', N'0711-345678', N'0711-901234');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(87, N'Customer ZHYOS', N'Ludwig, Michael', N'Accounting Manager', N'Torikatu 9012', N'Oulu', NULL, N'10045', N'Finland', N'981-123456', N'981-789012');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(88, N'Customer SRQVM', N'Li, Yan', N'Sales Manager', N'Rua do Mercado, 4567', N'Resende', N'SP', N'10084', N'Brazil', N'(14) 234-5678', NULL);
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(89, N'Customer YBQTI', N'Smith Jr., Ronaldo', N'Owner', N'8901 - 14th Ave. S. Suite 3B', N'Seattle', N'WA', N'10049', N'USA', N'(206) 555-0123', N'(206) 555-0132');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(90, N'Customer XBBVR', N'Larsson, Katarina', N'Owner/Marketing Assistant', N'Keskuskatu 2345', N'Helsinki', NULL, N'10055', N'Finland', N'90-012 3456', N'90-789 0123');
INSERT INTO Vendas.Cliente(iIDCliente, RazaoSocial, Contato, Cargo,Endereco, Cidade,Regiao, CEP, Pais, Telefone, fax)
  VALUES(91, N'Customer CCFIZ', N'Conn, Steve', N'Owner', N'ul. Filtrowa 6789', N'Warszawa', NULL, N'10068', N'Poland', N'(26) 234-5678', N'(26) 901-2345');
SET IDENTITY_INSERT Vendas.Cliente OFF;

-- Populate table Vendas.Remetente
SET IDENTITY_INSERT Vendas.Remetente ON;
INSERT INTO Vendas.Remetente(iIDRemetente, RazaoSocial, Telefone)
  VALUES(1, N'Shipper GVSUA', N'(503) 555-0137');
INSERT INTO Vendas.Remetente(iIDRemetente, RazaoSocial, Telefone)
  VALUES(2, N'Shipper ETYNR', N'(425) 555-0136');
INSERT INTO Vendas.Remetente(iIDRemetente, RazaoSocial, Telefone)
  VALUES(3, N'Shipper ZHISN', N'(415) 555-0138');
SET IDENTITY_INSERT Vendas.Remetente OFF;

/*
*/
go
create sequence seqIDPedido start with 1 increment by 1 
go

;
with cteOneLine as (
select top 1 
       CAST(RAND()*91 AS INT)+1 as idCliente,
	   CAST(RAND()*9 AS INT)+1 as idEmpregado ,
	   dateadd(d,cast(rand()*100 as int)  ,datapedido ) DataPedido ,
	   dateadd(d,cast(rand()*100 as int)  ,DataRequisicao) DataRequisicao,
	   dateadd(d,cast(rand()*100 as int)  ,DataEnvio) DataEnvio ,
       [iIDRemetente], (rand()*1000)+1 as Frete, [shipname], [shipaddress], [shipCidade], [shipregion], [shipCEP], [shipPais]
from FundamentosTSQL.vendas.pedido
order by newid() 
)
insert into Vendas.Pedido ([iIDPedido], [iIDCliente], [iIDEmpregado], [DataPedido], [DataRequisicao], [DataEnvio], [iIDRemetente], [Frete], [shipname], [shipaddress], [shipCidade], [shipregion], [shipCEP], [shipPais])
select (NEXT VALUE FOR seqIDPedido) as idPedido, * from cteOneLine 

go 1000000

commit 



