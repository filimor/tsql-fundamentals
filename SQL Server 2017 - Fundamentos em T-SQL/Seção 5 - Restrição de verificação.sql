Use DBExemplo
go

if object_id('dbo.Pedido', 'U') is not null
   drop table dbo.Pedido;


if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

/*
Incluindo uma restri��o de verifica��o - Check Constraint 
*/

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null Primary Key,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null, 
   CPF            varchar(11) not null Unique,
   Salario        money       not null Check (Salario > 0) 
)
GO

/*
De acordo com a aula de L�gica do Predicado, podemos definir um predicado para 
integridade l�gica e defini��o de estrutura. 
No exemplo identificamos um predicado que diz que o salario de um funcion�rio deve ser maior que zero.

*/


/*
Segunda forma de criar uma restri��o de verifica��o - Check Constraint 
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
   Constraint UNCPF Unique(CPF) ,
   Constraint CKSalario Check (Salario > 0) 
)
GO


/*
Terceira forma de criar restri��o de verifica��o - Check Constraint 
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
