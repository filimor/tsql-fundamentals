Use DBExemplo
go

if object_id('dbo.Empregado', 'U') is not null
   drop table dbo.Empregado;

Create Table dbo.Empregado 
(
   IDEmpregado    int         not null ,
   PrimeiroNome   varchar(50) not null,
   UltimoNome     varchar(50) not null,
   Admissao       date        not null,
   CPF            varchar(11) not null,
   Salario        money       not null
)
GO

/*
Tipos de dados
INT      - Valores inteiros entre -2 bilhões até 2 bilhões - Ocupa 4 bytes
VARCHAR  - Cadeia de caracter de tamanho variável. 
           ocupa de 1 até 8000 bytes.
		   Se definido com MAX, ocupa até 2Gb de dados.
DATE     - Armazena uma data valida entre 01/01/0001 até 31/12/999
           e ocupa 3 bytes.
MONEY    - Valor monetário entre -922 trilhoes até 922 trilhões - Ocupa 8 bytes
*/

-- Incluindo novas colunas 

Alter Table dbo.Empregado add Departamento varchar(40) not null
go 
Alter Table dbo.Empregado add Cargo        varchar(50) not null

-- Consultando a estrutura da tabela. 

execute sp_help 'dbo.Empregado'
