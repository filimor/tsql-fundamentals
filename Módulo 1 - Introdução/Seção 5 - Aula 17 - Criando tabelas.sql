Use DBExemplo
go

Drop Table if exists dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null ,
   PrimeiroNome   varchar(50) not null ,
   UltimoNome     varchar(50) not null ,
   Admissao       date        not null ,
   CPF            varchar(11) not null ,
   Salario        money       not null
)
GO

/*
Tipos de dados
INT      - Valores inteiros entre -2 bilhões até 2 bilhões - Ocupa 4 bytes
VARCHAR  - Cadeia de caracter de tamanho variável. 
           ocupa de 1 até 8000 bytes.
		   Se definido com MAX, ocupa até 2Gb de dados.
DATE     - Armazena uma data valida entre 01/01/0001 até 31/12/9999
           e ocupa 3 bytes.
MONEY    - Valor monetário entre -922 trilhoes até 922 trilhões - Ocupa 8 bytes
*/

-- Incluindo novas colunas 

Alter Table dbo.Empregado add Departamento varchar(40) not null
go 
Alter Table dbo.Empregado add Cargo        varchar(50) not null

-- Consultando a estrutura da tabela. 

execute sp_help 'dbo.Empregado'

-- 
insert into dbo.empregado
(iDEmpregado, PrimeiroNome, UltimoNome, Admissao, CPF,Salario , Departamento, Cargo)
values
(1,'Jose',' da Silva', '2010-02-10','12554584587', 10000.00 ,'Vendas', 'Vendedor')

Select * 
  From dbo.empregado

-- Erro de truncate 
insert into dbo.empregado
(iDEmpregado, PrimeiroNome, UltimoNome, Admissao, CPF,Salario , Departamento, Cargo)
values
(2,'Manuel',' da Silva', '2007-10-15','12554584587', 8500.00 ,'Compras', 'Comprador')

