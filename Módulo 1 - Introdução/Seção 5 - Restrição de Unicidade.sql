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

-- Validando a inclusão dos dados

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Manoel' ,'de Souza', '2014-08-25', null, '54852458', 2551.50)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(3,'Bonifácio' ,'das Quintas', '1978-12-02', '2010-10-28', '1235456788', 7510.00)

/*
Msg 2627, Level 14, State 1, Line 35
Violation of UNIQUE KEY constraint 'UQ__Empregad__C1F8973187078DFA'. 
Cannot insert duplicate key in object 'dbo.Empregado'. 
The duplicate key value is (1235456788).
The statement has been terminated.

*/
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




