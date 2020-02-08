Use DBExemplo
go

if object_id('dbo.Pedido', 'U') is not null
   drop table dbo.Pedido;

Create Table dbo.Pedido 
(
   IDPedido    int         not null,
   IDEmpregado int         not null,
   Cliente     varchar(50) not null,
   Criado      datetime    not null,
   Quantidade  int         not null,
   Constraint PKPedido Primary Key (IDPedido)
)


if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null ,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null ,
   Constraint PKEmpregado Primary Key(IDEmpregado),
   Constraint UNCPF Unique(CPF) 
)
GO

/*
Voce tem uma restrição de integridade relacional no seu modelo relacional que diz : 
"Um pedido deve ser realizado por um funcionario".
Essa regra diz que os valores de um pedido tem um restrição de Empregado.
Em termos mais tecnicos, a coluna IDEmpregado da tabela Pedido tem restrição de integridade
referencial com a coluna IDEmpregado da tabela Empregado.

*/

if object_id('dbo.Pedido', 'U') is not null
   drop table dbo.Pedido;

Create Table dbo.Pedido 
(
   IDPedido    int         not null,
   IDEmpregado int         not null,
   Cliente     varchar(50) not null,
   Criado      datetime    not null,
   Quantidade  int         not null,
   Constraint PKPedido Primary Key (IDPedido),
   Constraint FKEmpregado Foreign Key (IDEmpregado) References dbo.Empregado(IDEmpregado)
)

go
if object_id('dbo.Pedido', 'U') is not null
   drop table dbo.Pedido;

Create Table dbo.Pedido 
(
   IDPedido    int         not null,
   IDEmpregado int         not null,
   Cliente     varchar(50) not null,
   Criado      datetime    not null,
   Quantidade  int         not null,
   Constraint PKPedido Primary Key (IDPedido)
)

Alter Table dbo.Pedido 
   Add Constraint FKEmpregado 
   Foreign Key (IDEmpregado) 
   References dbo.Empregado(IDEmpregado)


