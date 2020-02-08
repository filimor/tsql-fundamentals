Use DBExemplo
go

Drop Table if exists dbo.Empregado;

/*
Chave Primária. Uma ou várias colunas que garante a unicidade de uma linha
dentro de uma tabela. 

Unicidade impõe uma restrição em uma ou várias colunas garantindo que os valores 
dessas colunas em uma linha nunca se repetirão em outra linha 

Para isso, essas coluna não podem receber valores nulos (NULL) 

*/

/*
Primeira forma de criar uma chave primária - Primary Key Constraint 
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
com dados em todas as colunas e a coluna IDEmpregado deverá receber 
um inteiro, por exemplo 1.

Quando incluir uma outra linha qualquer com valores diferentes nas colunas,
mas a coluna IDEmpregado com o valor 1, a restrição de chave primária não 
permitira a inclusão e retornará uma mensagem de erro.

*/

-- Validando a inclusão dos dados

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Manoel' ,'de Souza', '2014-08-25', null, '54852458', 2551.50)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Bonifácio' ,'das Quintas', '1978-12-02', '2010-10-28', '1235456788', 7510.00)

/*
Msg 2627, Level 14, State 1, Line 56
Violation of PRIMARY KEY constraint 'PK__Empregad__2278217D2BB2A36B'. 
Cannot insert duplicate key in object 'dbo.Empregado'. The duplicate key value is (2).
The statement has been terminated.
*/


/*
Segunda forma de criar uma chave primária
*/

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
   Constraint PKEmpregado Primary Key (IDEmpregado) 
)
GO

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(1,'Jose' ,'da Silva', '2000-01-10', null, '1235456788', 1000)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Manoel' ,'de Souza', '2014-08-25', null, '54852458', 2551.50)

select * from dbo.Empregado

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values(2,'Bonifácio' ,'das Quintas', '1978-12-02', '2010-10-28', '1545545', 7510.00)



/*
Terceira forma de criar uma chave primária
*/
Drop Table if exists dbo.Empregado;

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
	  Primary Key (IDEmpregado) 

GO





/*
Mensagem de erro ao criar um Primary Key 
*/

Drop Table if exists dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null,
   Constraint PKEmpregado Primary Key(IDEmpregado) 
)
GO

/*
Como garantir automaticamente que os valores criados da chave primária não 
vão ser repetidos. 
*/

-- Pela aplicação
-- Pelo Banco de Dados


Create Sequence SeqIDEmpregado start with 1 increment by 1
go

insert into dbo.Empregado (IDEmpregado, PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values( NEXT VALUE FOR SeqIDEmpregado ,'Manoel' ,'de Souza', '2014-08-25', null, '54852458', 2551.50)



Drop Table if exists dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null primary key default( NEXT VALUE FOR SeqIDEmpregado),
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   Demissao       date        null,
   CPF            varchar(11) not null,
   Salario        money       not null
)
GO

insert into dbo.Empregado (PrimeiroNome, UltimoNome, Admissao, Demissao, CPF,Salario)
values('Manoel' ,'de Souza', '2014-08-25', null, '54852458', 2551.50)


select * from dbo.Empregado
