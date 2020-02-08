Use DBExemplo
go
set nocount on 
go

Drop Table if exists dbo.Pedido;
GO

Create Table dbo.Pedido 
(
   IDPedido    int         not null,
   IDEmpregado int         not null,
   Cliente     varchar(50) not null,
   Criado      datetime    not null,
   Quantidade  int         not null,
   Constraint PKPedido Primary Key (IDPedido)
)
GO

Drop Table if exists dbo.Empregado;

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


insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

Insert Into dbo.Pedido (IDPedido,IDEmpregado,Cliente,Criado, Quantidade)
values (1,1,'Maria Constantina','2017-01-03',10)

select * from dbo.Empregado 
select * from dbo.Pedido

Insert Into dbo.Pedido (IDPedido,IDEmpregado,Cliente,Criado, Quantidade)
values (2,3,'Joaquina Moura','2017-03-22',7)

select * from dbo.Empregado 
select * from dbo.Pedido

Delete from Empregado 
 Where IDEmpregado = 1

select * from dbo.Empregado 
select * from dbo.Pedido


/*
Voce tem uma restrição de integridade relacional no seu modelo relacional que diz : 
"Um pedido deve ser realizado por um funcionario".
Essa regra diz que os valores de um pedido tem um restrição de Empregado.
Em termos mais tecnicos, a coluna IDEmpregado da tabela Pedido tem restrição 
de integridade referencial com a coluna IDEmpregado da tabela Empregado.

*/

Drop Table if exists dbo.Pedido;
GO

Create Table dbo.Pedido 
(
   IDPedido    int         not null,
   IDEmpregado int         not null,
   Cliente     varchar(50) not null,
   Criado      datetime    not null,
   Quantidade  int         not null,
   Constraint PKPedido Primary Key (IDPedido),
   Constraint FKEmpregado Foreign Key (IDEmpregado) 
                          References dbo.Empregado(IDEmpregado)
)
GO

Delete from Empregado
GO


insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

Insert Into dbo.Pedido (IDPedido,IDEmpregado,Cliente,Criado, Quantidade)
values (1,1,'Maria Constantina','2017-01-03',10)

select * from dbo.Empregado 
select * from dbo.Pedido

-- Apresenta o erro de FK !!
Insert Into dbo.Pedido (IDPedido,IDEmpregado,Cliente,Criado, Quantidade)
values (2,3,'Joaquina Moura','2017-03-22',7)

/*
Msg 547, Level 16, State 0, Line 96
The INSERT statement conflicted with the FOREIGN KEY constraint "FKEmpregado". 
The conflict occurred in database "DBExemplo", table "dbo.Empregado", column 'IDEmpregado'.
The statement has been terminated.
*/

-- Apresenta erro de excluir uma lina na tabela PAI com referencia a uma tabela FILHA

Delete from Empregado 
 Where IDEmpregado = 1

/*
Msg 547, Level 16, State 0, Line 108
The DELETE statement conflicted with the REFERENCE constraint "FKEmpregado". 
The conflict occurred in database "DBExemplo", table "dbo.Pedido", column 'IDEmpregado'.
The statement has been terminated.
*/


Drop Table if exists dbo.Pedido;
GO

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


