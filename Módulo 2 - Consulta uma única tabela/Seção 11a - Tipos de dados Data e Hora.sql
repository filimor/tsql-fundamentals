/*
Tipos de dados : Data e Hora
1. Dados Data e Hora
2. Dados Data
3. Dados Hora
4. Como representar 
5. Outros tipos 
*/


/*
1. Dados Data e Hora
Em algumas literaturas são chamadas de Datas Completas 
*/

use DBExemplo
go
drop table if exists dbo.Empregado
go

Create Table dbo.Empregado  (
id				int				not null primary key,
Nome			varchar(20)		not null,
Salario			money			null,
Comissao		money			null,
DataNascimento	datetime		not null,
DataAdmissao	smalldatetime	not null
)
go

/*
Armazena data e hora em um único tipo de dados. 

DateTime -		 ocupa 8 bytes		01/01/1753 até 31/12/9999
                                    3 1/3 milisegundos 

Smalldatetime -	 ocupa 4 bytes 		01/01/1900 até 06/06/2079
                                    1 minuto 				

Esses tipos não são padrão ANSI. 

*/

insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao )
values (1, 'Jose da Silva', 10000.00, 100.00, '1978-10-23' , '2017-10-15')

go

select * from dbo.Empregado

-- Incluir um aniversário do ano de 1752
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao )
             values (2, 'Manoel Souza', 10000.00, 100.00, '1752-10-23' , '2017-10-15 12:50:30')

/*
Msg 242, Level 16, State 3, Line 48
The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
The statement has been terminated.
*/


-- Incluir a data de admissão com segundos.
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao )
             values (2, 'Manoel Souza', 10000.00, 100.00, '1952-10-23' , '2017-10-15 12:50:31')

select * from dbo.Empregado

/*
Muita atenção!!!
Em coluna do tipo Datetime ou SmallDatetime, se voce não especificar a hora, 
o SQL Server assume meia-noite ou '00:00:00.00' do dia  !!!

Isso é importante quando veremos pesquisa com data na próxima aula. 

*/


/*
1. Dados Data 
*/

use DBExemplo
go
drop table if exists dbo.Empregado
go

Create Table dbo.Empregado  (
id int not null primary key,
Nome varchar(20) not null,
Salario money null,
Comissao money null,
DataNascimento date not null,
DataAdmissao date not null
)

/*
Armazena data um único tipo de dados. 

Date -			 ocupa 3 bytes		01/01/0001 até 31/12/9999
                                   
*/


go

insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao )
values (1, 'Jose da Silva', 10000.00, 100.00, '1978-10-23' , '2017-10-15')

go

select * from dbo.Empregado


-- Incluir uma data de admissao com hora 
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao )
             values (3, 'Joaquim Souza', 10000.00, 100.00, '1952-10-23' , '2017-10-15 12:50:30')
			  
select * from dbo.Empregado


/*
1. Dados Hora 
*/

use DBExemplo
go
drop table if exists dbo.MarcacaoPonto
go

Create Table dbo.MarcacaoPonto(
id int not null primary key,
idFuncionario int not null ,
Operacao varchar(10) not null check (Operacao in('Saida','Entrada')),
Data date not null,
Hora time not null
-- Constraint FKEmpregado foreign key (iDFuncionario) references Empregado(id) 
)
go

/*
Armazena hora um único tipo de dados. 

Time(n) -			 ocupa 3 a 5 bytes		100ns

Onde n representa a escala em frações de segundos. 

O intervalo de horas é 00:00:00 até 23:59:59.
Esse tipo de dado não armazena hora acumulada.
                                  
*/


Insert into dbo.MarcacaoPonto (id, idFuncionario, Operacao, Data, hora)
values (1,1,'Entrada' ,'2017-10-20' ,'09:00')


select * from dbo.MarcacaoPonto



select cast ('19:00:00.1234567' as time(7)) as Precisao7
select cast ('19:00:00.1234567' as time(5)) as Precisao5
select cast ('19:00:00.1234567' as time(3)) as Precisao3
select cast ('19:00:00.1234567' as time(1)) as Precisao1
select cast ('19:00:00.1234567' as time(0)) as Precisao0

select cast ('19:00:00.1234567' as time) as Precisao

-- Hora inválida
Insert into dbo.MarcacaoPonto (id, idFuncionario, Operacao, Data, hora)
values (1,1,'Entrada' ,'2017-10-20' ,'48:00')




/*
4. Como representar 
*/

/*
O formato padrão para data completas, data ou hora independente do 
idioma utilizados são :

Datas Completas
'AAAA-MM-DD HH:MM:SS'
'AAAAMMDD HH:MM:SS'

Data
'AAAA-MM-DD'
'AAAAMMDD'

Hora 
'HH:MM:SS.NNNNNNN'

*/

use DBExemplo 
go
drop table if exists dbo.Empregado
go

Create Table dbo.Empregado  (
id int not null primary key,
Nome varchar(20) not null,
Salario money null,
Comissao money null,
DataNascimento datetime not null,
DataAdmissao smalldatetime not null,
DataDemissao date null,
HoraDemissao time(2) null 
)
go

-- Usando exemplo 'AAAA-MM-DD' 
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao ,DataDemissao, HoraDemissao )
values (1, 'Jose da Silva', 10000.00, 100.00, '1978-10-23' , '2017-10-15',null,null)

select * from dbo.Empregado

-- Usando exemplo 'AAAAMMDD' 
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao ,DataDemissao, HoraDemissao )
values (2, 'Joaquim da Silva', 10000.00, 100.00, '19900502' , '20170901',null,null)

select * from dbo.Empregado


-- Usando exemplo 'AAAA-MM-DD HH:MM:SS' 
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao ,DataDemissao, HoraDemissao )
values (3, 'Manuel da Silva', 10000.00, 100.00, '1978-10-23' , '2017-10-15 12:15:32.0',null,null)

select * from dbo.Empregado

-- Usando exemplo 'AAAAMMDD HHMMSS' 
insert into dbo.Empregado (Id, Nome, Salario, Comissao, DataNascimento , DataAdmissao ,DataDemissao, HoraDemissao )
values (4, 'Patricio da Silva', 10000.00, 100.00, '19781023 101525' , '20171015',null,null)

/*
Msg 242, Level 16, State 3, Line 212
The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
The statement has been terminated.
*/


/*
5. Outros tipos
*/

/*
Armazena data e hora em um único tipo de dados. 

DateTime2 -		 ocupa 6 a 8 bytes	01/01/0001 até 31/12/9999
                                    100ns

DateTimeOffSet - ocupa 8 a 10 bytes	01/01/1900 até 31/12/9999
                                    100ns

Esses tipos são padrão ANSI. 

*/





use DBExemplo
go

drop table if exists dbo.Voos
go

Create Table dbo.Voos (
Id int not null primary key,          -- Identificação do Voo
idRota int not null,                  -- Identificacao da Rota 
Partida datetimeoffset(2) not null,   -- Data e hora da Partida
Chegada datetimeoffset(2) not null,   -- Data e hora da Chegada
)


-- O tempo de um voo específico entre São Paulo e Paris é de 11:10 horas. 
-- Partida as 21:05hs de São Paulo (https://www.timeanddate.com/worldclock/brazil/sao-paulo)
-- Chegada em Paris as 11:20hs do dia seguinte (https://www.timeanddate.com/worldclock/france/paris)
-- As horas são representadas como hora local em cada cidade. 
-- São Paulo está em UTC -2 
-- Paris está em UTC +1


insert into dbo.voos (id,idRota, Partida, Chegada)
values (1,1,'2018-01-01 21:05:00 -02:00','2018-01-02 11:20:00 +01:00')


-- Sem considerar o UTC.
insert into dbo.voos (id,idRota, Partida, Chegada)
values (2,1,'2018-01-01 21:05:00','2018-01-02 11:20:00')

select datediff(MINUTE,Partida, Chegada )/60.0 as Tempo, Partida , Chegada 
 from dbo.voos 


select * from dbo.voos 
 
