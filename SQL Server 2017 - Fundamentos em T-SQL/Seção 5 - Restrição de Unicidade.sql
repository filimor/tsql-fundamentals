Use DBExemplo
go

if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

/*
Incluindo uma restrição de unicidade - Unique Constraint
*/

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null Primary Key,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null Unique,
   Salario        money       not null
)
GO

/*
*/


/*
Segunda forma de criar uma restrição de unicidade - Unique Constraint
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
   Constraint PKEmpregado Primary Key(IDEmpregado),
   Constraint UNCPF Unique(CPF) 
)
GO


/*
Terceira forma de criar restrição de unicidade - Unique Constraint
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

Alter Table dbo.Empregado
      Add Constraint UNCPF 
	  Unique(CPF)




/*
Terceira forma de criar restrição de unicidade - Unique Constraint
*/
if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null 
)
GO
