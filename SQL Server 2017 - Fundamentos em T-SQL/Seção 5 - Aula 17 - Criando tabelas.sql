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
INT      - Valores inteiros entre -2 bilh�es at� 2 bilh�es - Ocupa 4 bytes
VARCHAR  - Cadeia de caracter de tamanho vari�vel. 
           ocupa de 1 at� 8000 bytes.
		   Se definido com MAX, ocupa at� 2Gb de dados.
DATE     - Armazena uma data valida entre 01/01/0001 at� 31/12/999
           e ocupa 3 bytes.
MONEY    - Valor monet�rio entre -922 trilhoes at� 922 trilh�es - Ocupa 8 bytes
*/

-- Incluindo novas colunas 

Alter Table dbo.Empregado add Departamento varchar(40) not null
go 
Alter Table dbo.Empregado add Cargo        varchar(50) not null

-- Consultando a estrutura da tabela. 

execute sp_help 'dbo.Empregado'
