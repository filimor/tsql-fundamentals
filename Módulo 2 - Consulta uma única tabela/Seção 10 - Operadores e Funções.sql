/*
Operadores e Fun��es com dados Alfanum�ricos ou Caracters 
*/

use FundamentosTSQL
go


-- Concatena��o 

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
Para contornar esse problemas, podemos usar uma fun��o COALESCE  
*/

Select COALESCE(10 ,0 )
Select COALESCE(NULL,0 )


Select Contato, 
       Endereco+', '+ Cidade + ', CEP: ' + Cep +', '+ COALESCE ( Regiao ,'') +', '+ Pais as Endereco 
  From vendas.Cliente


/*
FUN��ES CARACTERES 
*/

------------------------------------------------------------------
-- SUBSTRING - Extrai um parte ou sequ�ncia de caracters de uma 
-- outra sequ�ncia de caracteres
-- SUBSTRING( sequ�ncia de caracters, posi��o inicial, quantidade de caracteres)

SELECT SUBSTRING('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',19,25) as sequ�ncia

SELECT SUBSTRING('Codigo Pe�a : JP-025-55, Controle : 89-JP2017',1,23) as Codigo
SELECT SUBSTRING('Codigo Pe�a : JP-025-55, Controle : 89-JP2017',26,20) as Controle


------------------------------------------------------------------
-- LEFT - Extrai caracters a esquerda de uma sequ�ncia de caracters 
-- LEFT (sequ�ncia de caracters, quantidade de caracteres a esquerda)

SELECT LEFT('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',15) as sequ�ncia
SELECT LEFT('Codigo Pe�a : JP-025-55, Controle : 89-JP2017',23) as Codigo


------------------------------------------------------------------
-- RIGHT - Extrai caracters a direita de uma sequ�ncia de caracters 
-- RIGHT(sequ�ncia de caracters, quantidade de caracteres a direita)

SELECT RIGHT ('SQL SERVER 2017 - Fundamentos profissionais em T-SQL',5) as sequ�ncia
SELECT RIGHT ('Codigo Pe�a : JP-025-55, Controle : 89-JP2017',20) as Codigo

------------------------------------------------------------------
-- LEN - Total de caracteres de uma sequ�ncia de caracters.
-- LEN (sequ�ncia de caracters)

SELECT LEN('SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho
SELECT LEN( N'SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho

------------------------------------------------------------------
-- DATALENGTH - Total de bytes utilizados de uma sequ�ncia de caracters.
-- DATALENGTH (sequ�ncia de caracters)

SELECT DATALENGTH('SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho
SELECT DATALENGTH(N'SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Tamanho


------------------------------------------------------------------
-- CHARINDEX - N�mero da posi��o de uma sequ�ncia de caracters dentro de outra 
-- sequ�ncia de caracters.
-- CHARINDEX (sequ�ncia de pesquisa , sequ�ncia de caracters, posicao inicial)

SELECT CHARINDEX ('Fundamento','SQL SERVER 2017 - Fundamentos profissionais em T-SQL') as Posicao 

SELECT CHARINDEX ('JP','Codigo Pe�a : JP-025-55, Controle : 89-JP2017 ',20) as Posicao 


------------------------------------------------------------------
-- REPLACE - Substitui uma sequ�ncia de caracters por outra 
-- sequ�ncia de caracters.
-- REPLACE (sequ�ncia de caracter , sequ�ncia de pesquisa  , sequ�ncia de substitui��o)

SELECT REPLACE ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL','2000','2017') as Sequencia 
SELECT REPLACE ('Codigo Pe�a : JP-025-55, Controle : 89-JP2017 ','JP','NP') as Sequencia


------------------------------------------------------------------
-- REPLICATE - Replica uma sequ�ncia de caracter por um n�mero de vezes.
-- REPLACE (sequ�ncia de caracter , n�mero de replica��o)

SELECT REPLICATE ('SQL SERVER 2017 ', 3) as Ocorrencia 
SELECT REPLICATE ('0',10)  as Sequencia 

------------------------------------------------------------------
-- STUFF - Remove uma sequ�ncia de caracter de um outra sequ�ncia de caracter 
-- e inclui uma nova sequ�ncia de caracter.
-- STUFF(sequ�ncia de caracter , n�mero de replica��o)

SELECT STUFF ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL',12,4 ,'2017') as Sequencia 
SELECT STUFF ('Codigo Pe�a : JP-025-55, Controle : 89-JP2017 ',15,9,'NP-K17-A') as Sequencia


------------------------------------------------------------------
-- UPPER - Converte uma sequ�ncia de caracter em mai�sculos 
-- UPPER (sequ�ncia de caracter )

SELECT UPPER ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL') as Sequencia 
SELECT UPPER ('Codigo Pe�a : JP-025-55, Controle : 89-JP2017 ') as Sequencia

------------------------------------------------------------------
-- LOWER - Converte uma sequ�ncia de caracter em min�sculos
-- LOWER (sequ�ncia de caracter )

SELECT LOWER ('SQL SERVER 2000 - Fundamentos profissionais em T-SQL') as Sequencia 
SELECT LOWER ('Codigo Pe�a : JP-025-55, Controle : 89-JP2017 ') as Sequencia

------------------------------------------------------------------
-- RTRIM - Remove espa�o em branco a esquerda de uma sequ�ncia de caracter 
-- RTRIM (sequ�ncia de caracter )

SELECT '+'+RTRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT RTRIM ('Codigo Pe�a : JP-025-55                 ')+', Controle : 89-JP2017 ' as Sequencia

------------------------------------------------------------------
-- LTRIM - Remove espa�o em branco a direita de uma sequ�ncia de caracter 
-- LTRIM (sequ�ncia de caracter )

SELECT '+'+LTRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT 'Codigo Pe�a : JP-025-55' + LTRIM('                , Controle : 89-JP2017 ') as Sequencia


------------------------------------------------------------------
-- TRIM - Remove espa�o em branco a direita e a esquerda de uma sequ�ncia de caracter 
-- Fun��o nova no SQL SERVER 2017 
-- TRIM (sequ�ncia de caracter ) ou
-- TRIM (caracter FROM sequ�ncia de caracter ) ou


SELECT '+'+TRIM ('           SQL SERVER 2000 - Fundamentos profissionais em T-SQL         ')+'+' as Sequencia 
SELECT TRIM ('             Codigo Pe�a : JP-025-55, Controle : 89-JP2017    ') as Sequencia

SELECT TRIM ('#' FROM '###Codigo Pe�a : JP-025-55, Controle : 89-JP2017###') as Sequencia


/*
Exemplos 
*/

-- Apresentar os produtos que come�am com a letra H 

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


-- Mostra o ID do cliente em 5 posi��es e com zeros iniciais.
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
a m�scara 999.999-99 
*/

use FundamentosTSQL
go

select RazaoSocial, 
       Documento ,
	   substring(Documento,1,3)+'.'+substring(Documento,4,3)+'-'+substring(Documento,7,2)
  From vendas.Cliente

Select * from vendas.cliente


  



