/*O SQL Server da suporte para duas formas do tipo de dados caracteres.

- Regular
- Unicode

Regular 

Os tipos de dados regulares utilizam "1 bytes" para representar um caracter.
Com isso, podemos colocar em 1 posição, 256 tipos de caracteres diferentes.
*/

Use FundamentosTSQL
GO

Select id, Caracter   
  From ASCIITabela
 Where id < 256


/*
Para os idiomas originados do Latin (como o Português ou Inglês) essa forma
de dados é suficiente para representar todos os caracteres. 
*/

/*
Unicode 

Os tipos de dados unicodes utilizam "2 bytes" para representar "um" caracter.
Com isso, podemos colocar em 1 posição, 65.536 tipos de caracteres diferentes.

https://unicode-table.com/pt/

*/

-- Lista dos caracters árabe
Select id, NCaracter   
  From ASCIITabela
 Where id between 1536 and 1791

/*
Todos os idiomas são suportados por essa forma de caracter.  
*/

/*
Como representar uma sequência de caracters na forma UNICODE.
-------------------------------------------------------------

N'SQL Server 2017 - Fundamentos profissionais em T-SQL'

*/

Select N'SQL Server 2017 - Fundamentos profissionais em T-SQL'

Select n'SQL Server 2017 - Fundamentos profissionais em T-SQL'


/*
Tipos de dados 
*/

/*
Para as formas de dados Regular, tempos dois tipos. CHAR e o VARCHAR.
Para as formas de dados Unicode, tempos dois tipos. NCHAR e o NVARCHAR.
*/

-- NCHAR 
/*
Representa o tipo de dado de tamanho fixo. 
Voce declara o tipo de dados : NCHAR(n), onde n é o tamanho 
máximo de caracters que esse tipo de dados armezenará. 

Limite para o tamanho máximo :

NCHAR  - até 4000 bytes 

Com isso, o SQL Server reservará "n" caracters para armazenar o dados, utilizando ou não
todos os caracteres.  

*/
use DBExemplo
go

drop table if exists Teste
go

Create Table Teste (
  Nome nchar(10)
)

insert into Teste (Nome) values ('Jose')
insert into Teste (Nome) values (N'ホセ')  -- Jose em Japonês !!! select nchar(12507)+ nchar(12475)

select * from Teste

insert into Teste (Nome) values ('ホセ')  -- Jose em Japonês !!! select nchar(12507)+ nchar(12475)


----------
JOSE      |
----------

select '['+nome+']' from Teste

select datalength(nome) from teste

/*
O SQL Server não tem processo de expandir ou comprimir a coluna. O dados é
armazenado com o tamanho de acordo com o valor declarado no tipo do dado.

*/

-- NVARCHAR 

/*
Representa o tipo de dado de tamanho variado.
Voce declare o tipo de dado : NVARCHAR(n), onde "n" é o 
tamanho máximo de caracteres que pode ser armazenado. 

Limite para o tamanho máximo :

NVARCHAR - até 4000 bytes 

Já neste caso, o SQL SERVER armazenará somente os caracteres utilizados 
neste tipo de dados, respeitando o limite declarado. 
*/

use DBExemplo
go

drop table if exists Teste 
go

Create Table Teste (
   Nome nvarchar(10)
)

insert into Teste (Nome) values ('Jose')
insert into Teste (Nome) values (N'ホセ')  -- Jose em Japonês !!! select nchar(12507)+ nchar(12475)


select * from Teste

-----
JOSE|
-----

select '['+nome+']' from Teste

select datalength(nome) from Teste


/*
O consumo de espaço é reduzido e as leituras são mais rápidas. 
Mas existe um overhead de processamento para reduzir ou expandir o dados 
no processo de gravação. 
*/




use FundamentosTSQL
go 

drop table if exists Producao.MateriaPrima
go

Create Table Producao.MateriaPrima (
iIDMateriaPrima int not null ,
Nome            varchar(100) not null,
NomeOriginal    nvarchar(100) not null, 
Abreviacao      char(10) not null,
Codigo          char(10) not null,
Unidade         char(10) not null,
Custo           money not null,
Desativado      bit not null default(0),
Constraint PKMateriaPrima Primary key (iIDMateriaPrima)
)

--select nchar(3650)+nchar(3614)+nchar(3621)+nchar(3637)+nchar(3652)+nchar(3623)+nchar(3609)+nchar(3636)+nchar(3621)+nchar(3588)+nchar(3621)+nchar(3629)+nchar(3652)+nchar(3619)+nchar(3604)+nchar(3660)

Insert Into Producao.MateriaPrima (iIDMateriaPrima,Nome,NomeOriginal, Abreviacao,Codigo,Unidade, Custo)
values (1,'Policloreto de vinila',N'โพลีไวนิลคลอไรด์' ,'PVC','9002-86-02','Unidade', 10.00)

Select Nome,NomeOriginal,Abreviacao, Codigo , Unidade from Producao.MateriaPrima

Select '*'+Nome+'*'       from Producao.MateriaPrima
Select '*'+NomeOriginal+'*' from Producao.MateriaPrima

go


/*
Armazenando dados Unicode 
*/

drop table if exists Producao.ProdutoImportado 
go

Create Table Producao.ProdutoImportado  (
iIDProduto int not null ,
NomeNacional    varchar(100) not null,
NomeOriginal    nvarchar(100) not null,
Idioma          char(25) not null,
Constraint PKProdutoImportado Primary key (iIDProduto)
)

select nchar(22721)+nchar(32025)  

Insert Into Producao.ProdutoImportado (iIDProduto,NomeOriginal,NomeNacional,Idioma)
values ( 1,  N'壁紙'  ,'Papel de Parede','Japonês')

Insert Into Producao.ProdutoImportado (iIDProduto,NomeOriginal,NomeNacional,Idioma)
values ( 2,  nchar(1054) + nchar( 1073)  + nchar( 1086 ) + nchar( 1080 )  ,'Papel de Parede','Russo')

Insert Into Producao.ProdutoImportado (iIDProduto,NomeOriginal,NomeNacional,Idioma)
values ( 3,  NCHAR(1608)+NCHAR(1585)+NCHAR(1602)+NCHAR(1575)+NCHAR(1604)+NCHAR(1580)+NCHAR(1583)+NCHAR(1585)+NCHAR(1575)+NCHAR(1606) ,'Papel de Parede','Árabe')


Select * from Producao.ProdutoImportado


/*
*/


drop table if exists Producao.ProdutoImportado 
go

Create Table Producao.ProdutoImportado  (
iIDProduto int not null ,
NomeNacional    varchar(100) not null,
NomeOriginal    nvarchar(100) not null,
Idioma          char(25) not null,
Resumo          nvarchar(max) not null, 
Codigo          char(10) not null,
Unidade         char(10) not null,
Custo           money not null,
Desativado      bit not null default(0),
Constraint PKProdutoImportado Primary key (iIDProduto)
)


Insert Into Producao.ProdutoImportado
       (iIDProduto,NomeOriginal,NomeNacional,Idioma,Resumo,Codigo,Unidade, Custo)
values ( 1,
         N'壁紙' ,
		 'Papel de Parede',
		 'Japão',
		 N'壁紙（かべがみ、英: wallpaper）とは、建築物において壁や天井の内装仕上材として用いられる布・紙やビニル（合成樹脂）でできたシート。おもに、下地の保護や装飾などを目的とし、内壁下地材の表面に接着剤を用いて貼り付ける。近年ではシックハウス対策として、ホルムアルデヒドを飛散しにくい接着剤への転換が進んでいる。一般には「壁紙」と呼ばれるが、天井に貼ることも多いため、建築業界では「クロス」（cloth）と呼ぶこともある。
',
		  'JP-0254-15',
		  'Peça',
		  5.00
        )




select * from Producao.ProdutoImportado

---- https://ja.wikipedia.org/wiki/%E5%A3%81%E7%B4%99

select Resumo from Producao.ProdutoImportado



/*
Utilizando uma coluna VACHAR ou CHAR para armazenar um UNICODE 
*/


drop table if exists Producao.ProdutoImportado 
go

Create Table Producao.ProdutoImportado  (
iIDProduto int not null ,
NomeNacional    varchar(100) not null,
NomeOriginal    varchar(100) not null,
Idioma          char(20) not null,
Resumo          varchar(max) not null, 
Codigo          char(10) not null,
Unidade         char(10) not null,
Custo           money not null,
Desativado      bit not null default(0),
Constraint PKProdutoImportado Primary key (iIDProduto)
)


Insert Into Producao.ProdutoImportado
       (iIDProduto,NomeOriginal,NomeNacional,Idioma,Resumo,Codigo,Unidade, Custo)
values ( 1,
         N'壁紙' ,
		 'Papel de Parede',
		 'Japão',
		 N'壁紙（かべがみ、英: wallpaper）とは、建築物において壁や天井の内装仕上材として用いられる布・紙やビニル（合成樹脂）でできたシート。おもに、下地の保護や装飾などを目的とし、内壁下地材の表面に接着剤を用いて貼り付ける。近年ではシックハウス対策として、ホルムアルデヒドを飛散しにくい接着剤への転換が進んでいる。一般には「壁紙」と呼ばれるが、天井に貼ることも多いため、建築業界では「クロス」（cloth）と呼ぶこともある。',
		 'JP-0254-15',
		 'Peça',
		  5.00
        )


select * from Producao.ProdutoImportado


/*
*/