Use DBExemplo
go

if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

/*
Primeira forma de criar uma chave prim�ria - Primary Key Constraint 
*/

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null primary key,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null
)
GO

/*
Quando incluir a primeira linha com os dados do empregado neste tabela, 
com dados e todas as colunas e a coluna IDEmpregado dever� receber um inteiro, por exemplo 1.

Quando incluir uma outra linha qualquer com valores diferentes nas colunas,
mas a coluna IDEmpregado com o valor 1, a restri��o de chave prim�ria n�o permitira a inclus�o e 
retornar� uma mensagem de erro.

*/


/*
Segunda forma de criar uma chave prim�ria
*/

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
   Constraint PKEmpregado Primary Key(IDEmpregado) 
)
GO


/*
Terceira forma de criar uma chave prim�ria
*/
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
   Salario        money       not null 
)
GO


Alter Table dbo.Empregado 
      Add Constraint PKEmpregado 
	  Primary Key(IDEmpregado) 


GO
/*
Mensagem de erro ao criar um Primary Key 
*/

if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         null,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null,
   Constraint PKEmpregado Primary Key(IDEmpregado) 
)
GO

