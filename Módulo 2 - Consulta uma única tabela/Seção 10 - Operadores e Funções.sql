/*
Operadores e Funções com dados Alfanuméricos ou Caracters 
*/

use FundamentosTSQL
go


-- Concatenação 

Select iIDEmpregado , PrimeiroNome , UltimoNome, 
       PrimeiroNome+ ' '+ UltimoNome as NomeCompleto  
  FROM RH.Empregado


Select Contato, 
       Endereco+', '+ Cidade + ', CEP: ' + Cep +', '+Pais as Endereco ,
	   Regiao 
  From vendas.Cliente

Select Contato, 
       Endereco+', '+ Cidade + ', CEP: ' + Cep +', '+ Regiao+', '+Pais as Endereco 
  From vendas.Cliente


/*
Para contornar esse problemas, podemos usar uma função COALESCE  
*/

Select COALESCE(10 ,0 )
Select COALESCE(NULL,0 )


Select Contato, 
       Endereco+', '+ Cidade + ', CEP: ' + Cep +', '+ COALESCE ( Regiao ,'') +', '+ Pais as Endereco 
  From vendas.Cliente


/*
FUNÇÕES CARACTERES 
*/

------------------------------------------------------------------
-- SUBSTRING - Extrai um parte ou sequência de caracters de uma 
-- outra sequência de caracteres
-- SUBSTRING( sequência de caracters, posição inicial, quantidade de caracteres)

SELECT SUBSTRING('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',19,25) as sequência

SELECT SUBSTRING('Codigo Peça : JP-025-55, Controle : 89-JP2017',1,23) as Codigo
SELECT SUBSTRING('Codigo Peça : JP-025-55, Controle : 89-JP2017',26,20) as Controle


------------------------------------------------------------------
-- LEFT - Extrai caracters a esquerda de uma sequência de caracters 
-- LEFT (sequência de caracters, quantidade de caracteres a esquerda)

SELECT LEFT('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',15) as sequência
SELECT LEFT('Codigo Peça : JP-025-55, Controle : 89-JP2017',23) as Codigo


------------------------------------------------------------------
-- RIGHT - Extrai caracters a direita de uma sequência de caracters 
-- RIGHT(sequência de caracters, quantidade de caracteres a direita)

SELECT RIGHT ('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',5) as sequência
SELECT RIGHT ('Codigo Peça : JP-025-55, Controle : 89-JP2017',20) as Codigo

------------------------------------------------------------------
-- LEN - Total de caracteres de uma sequência de caracters.
-- LEN (sequência de caracters)

SELECT LEN('SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho
SELECT LEN( N'SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho

------------------------------------------------------------------
-- DATALENGTH - Total de bytes utilizados de uma sequência de caracters.
-- DATALENGTH (sequência de caracters)

SELECT DATALENGTH('SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho
SELECT DATALENGTH(N'SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho


------------------------------------------------------------------
-- CHARINDEX - Número da posição de uma sequência de caracters dentro de outra 
-- sequência de caracters.
-- CHARINDEX (sequência de pesquisa , sequência de caracters, posicao inicial)

SELECT CHARINDEX ('Fundamento','SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Posicao 

SELECT CHARINDEX ('JP','Codigo Peça : JP-025-55, Controle : 89-JP2017 ',20) as Posicao 


------------------------------------------------------------------
-- REPLACE - Substitui uma sequência de caracters por outra 
-- sequência de caracters.
-- REPLACE (sequência de caracter , sequência de pesquisa  , sequência de substituição)

SELECT REPLACE ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL','2000','2017') as Sequencia 
SELECT REPLACE ('Codigo Peça : JP-025-55, Controle : 89-JP2017 ','JP','NP') as Sequencia


------------------------------------------------------------------
-- REPLICATE - Replica uma sequência de caracter por um número de vezes.
-- REPLACE (sequência de caracter , número de replicação)

SELECT REPLICATE ('SQL SERVER 2017 ', 3) as Ocorrencia 
SELECT REPLICATE ('0',10)  as Sequencia 

------------------------------------------------------------------
-- STUFF - Remove uma sequência de caracter de um outra sequência de caracter 
-- e inclui uma nova sequência de caracter.
-- STUFF(sequência de caracter , número de replicação)

SELECT STUFF ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL',12,4 ,'2017') as Sequencia 
SELECT STUFF ('Codigo Peça : JP-025-55, Controle : 89-JP2017 ',15,9,'NP-K17-A') as Sequencia


------------------------------------------------------------------
-- UPPER - Converte uma sequência de caracter em maiúsculos 
-- UPPER (sequência de caracter )

SELECT UPPER ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL') as Sequencia 
SELECT UPPER ('Codigo Peça : JP-025-55, Controle : 89-JP2017 ') as Sequencia

------------------------------------------------------------------
-- LOWER - Converte uma sequência de caracter em minúsculos
-- LOWER (sequência de caracter )

SELECT LOWER ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL') as Sequencia 
SELECT LOWER ('Codigo Peça : JP-025-55, Controle : 89-JP2017 ') as Sequencia

------------------------------------------------------------------
-- RTRIM - Remove espaço em branco a esquerda de uma sequência de caracter 
-- RTRIM (sequência de caracter )

SELECT '+'+RTRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT RTRIM ('Codigo Peça : JP-025-55                 ')+', Controle : 89-JP2017 ' as Sequencia

------------------------------------------------------------------
-- LTRIM - Remove espaço em branco a direita de uma sequência de caracter 
-- LTRIM (sequência de caracter )

SELECT '+'+LTRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT 'Codigo Peça : JP-025-55' + LTRIM('                , Controle : 89-JP2017 ') as Sequencia


------------------------------------------------------------------
-- TRIM - Remove espaço em branco a direita e a esquerda de uma sequência de caracter 
-- Função nova no SQL SERVER 2017 
-- TRIM (sequência de caracter ) ou
-- TRIM (caracter FROM sequência de caracter ) ou


SELECT '+'+TRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT TRIM ('             Codigo Peça : JP-025-55, Controle : 89-JP2017    ') as Sequencia

SELECT TRIM ('#' FROM '###Codigo Peça : JP-025-55, Controle : 89-JP2017###') as Sequencia


/*
Exemplos 
*/

-- Apresentar os produtos que começam com a letra H 

select iIDProduto , 
       substring(NomeProduto,9,31) as NomeProduto  
  From Producao.Produto
 Where substring(NomeProduto,9,1) = 'H'

-- Separar o nome e sobrenome da coluna Contato da tabela de Clientes

/*
Allen, Michael
Florczyk, Krzysztof
Ray, Mike
*/

 Select Contato, 
 		SUBSTRING(CONTATO,CHARINDEX(',', CONTATO)+2,100 ) as PrimeiroNome,
        SUBSTRING(CONTATO,1,CHARINDEX(',', CONTATO)-1) as UltimoNome 
  From Vendas.Cliente


-- Mostra o ID do cliente em 5 posições e com zeros iniciais.
/*
iIDCliente RazaoSocial
---------- ----------------------------------------
00001      Customer NRZBB
00002      Customer MLTDN
00003      Customer KBUDE
00004      Customer HFBZG
*/

select iIDCliente from vendas.Cliente
order by iIDCliente

Select 00001
Select '00001'

Select cast(iIDCliente as varchar(5)) as iIDCliente  
  From vendas.Cliente
 Order by iIDCliente

Select '00000'+cast(iIDCliente as varchar(5)) as iIDCliente  
  From vendas.Cliente
 Order by iIDCliente

Select right('00000'+cast(iIDCliente as varchar(5)) , 5) as iIDCliente  ,  RazaoSocial  
  From vendas.Cliente
 Order by iIDCliente


/*
Mostrar o Nome do cliente e o numero do documento formatado com
a máscara 999.999-99 
*/

use FundamentosTSQL
go

select RazaoSocial, 
       Documento ,
	   substring(Documento,1,3)+'.'+substring(Documento,4,3)+'-'+substring(Documento,7,2)
  From vendas.Cliente

Select * from vendas.cliente


  



