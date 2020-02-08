Use DBExemplo
go

if object_id('dbo.Pedido', 'U') is not null
   drop table dbo.Pedido;


if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

/*
Incluindo uma restrição de valor padrão - Default Constraint 
*/

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null Primary Key,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null default (CURRENT_TIMESTAMP),
   Demissao       date        null, 
   CPF            varchar(11) not null Unique,
   Salario        money       not null Check (Salario > 0) 
)
GO

/*
Essa regra impõe uma restrição de valor padrão quando um valor 
para uma coluna não é informada no processo de inclusão 

*/


/*
Segunda forma de criar uma restrição de valor padrão - Default Constraint 
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
	  Primary Key(IDEmpregado) ;

Alter Table dbo.Empregado
      Add Constraint UNCPF 
	  Unique(CPF);

Alter Table dbo.Empregado
      Add Constraint CKSalario 
	  Check (Salario > 0) 

Alter Table dbo.Empregado
      Add Constraint DFAdmisao 
	  Default (CURRENT_TIMESTAMP) 
	  for Admissao 
