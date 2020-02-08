Use DBExemplo
go

Drop Table if exists dbo.Pedido;
GO

Drop Table if exists dbo.Empregado;
GO

/*
Incluindo uma restrição de verificação - Check Constraint 
*/

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null Primary Key,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null, 
   CPF            varchar(11) not null Unique,
   Salario        money       not null Check ( Salario > 0 ) 
)
GO

/*
De acordo com a aula de Lógica do Predicado, podemos definir um predicado para 
integridade lógica e definição de estrutura. 
No exemplo identificamos um predicado que diz que o 
salario de um funcionário deve ser maior que zero.

*/

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF, Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Joaquina' ,'da Silva', '1995-12-15', null, '1235455487', 0)

/*
Msg 547, Level 16, State 0, Line 38
The INSERT statement conflicted with the CHECK constraint "CK__Empregado__Salar__5BE2A6F2". 
The conflict occurred in database "DBExemplo", table "dbo.Empregado", column 'Salario'.
The statement has been terminated.
*/


/*
Segunda forma de criar uma restrição de verificação - Check Constraint 
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
Terceira forma de criar restrição de verificação - Check Constraint 
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
