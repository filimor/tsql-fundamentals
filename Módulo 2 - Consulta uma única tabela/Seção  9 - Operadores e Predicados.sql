/*
EXPRESSÕES, OPERADORES E PREDICADOS 
*/


/*
EXPRESSÕES 

Combinação de valores e operadores que o SQL avalia para 
obter um resultado. 

*/
use FundamentosTSQL
go

Select 'Aos Cuidados de:' as Titulo, 
       Contato 
  From Vendas.Cliente

-- Contato e a constante 'Aos Cuidados de:' , no contexto de execução 
-- da instrução acima são classificados como expressão simples 

Select NomeProduto, 
       PrecoUnitario,
       PrecoUnitario * 1.15 as NovoPreco 
  From Producao.Produto

-- Um calculo matemático acima é classificada 
-- como uma expressão complexa.

Select PrimeiroNome , 
       DataAdmissao , GETDATE() - DataAdmissao as TempoDias
  From Rh.Empregado

-- Expressões quando combinadas com operadores, que podem gera um valor
-- com o mesmo tipo de dados.  

-- Para gerar tipos de dados diferentes, o SQL pode realizar a 
-- chamada conversão implícita ou então será necessário
-- utilizar funções de conversão (CAST ou CONVERT) ou funções 
-- específicas que tratam o tipo de dado. 

-- Exemplo simples da CAST

select CAST( 1 as money) as ValorMoney 
select CAST( 1 as numeric(5,2)) as ValorNumeric
select CAST( '100'  as int ) + 1 as ValorInt
select CAST( 100  as varchar) as ValorChar

select CAST( GETDATE() as int ) as  DataDia
select CAST( CAST('1970-01-10' as datetime) as int) as DataDia


-- Exemplo usando o CAST 



Select PrimeiroNome , 
       DataAdmissao , CAST ( GETDATE() - DataAdmissao as int )  as TempoDias
  From Rh.Empregado

-- Exemplo usando função que trata o mesmo tipo de dado. 
  Select PrimeiroNome , 
       DataAdmissao , DATEDIFF(d,DataAdmissao,GETDATE() )  as Tempo
  From Rh.Empregado



/*
OPERADORES 

Símbolo que especifica a ação que será realizada em uma ou
mais expressões. 

*/

-- Operadores ARITMÉTICOS 
/*
					+ 
					- 
					* 
					/ 
					%
*/

Select 3+4 as Soma, 
       4-2 as Subtração, 
	   5*2 as Multiplicação ,
	   12/2 as Divisão,
   	   15/7 as Divisão,
       15%7 as Módulo 

Select NomeProduto, 
	   PrecoUnitario * 1.15 + 2.00 
  From Producao.Produto

-- Operadores aritméticos como 3+4, por exemplo, são chamados 
-- também de expressões 



/*
Operação aritméticas com tipos de dados diferentes. 
*/

Select case when 10/3 > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end as 'Atividade' 

-- Se as duas expressões são do mesmo tipo de dado,
-- o resultado será do mesmo tipo de dado.

select 10/3





Select case when 10/3.0 > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end as 'Atividade'

-- Neste exemplo temos a conversão implicita dos dados. O valor 
-- 3.0 que é do tipo NUMERIC tem prioridade no tipo INT que é 
-- o valor 10. Então o valor 10 é convertido para 10.0 implicitamente.

-- Utilizando a função CAST 
Select case when 10/ cast( 3 as numeric ) > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as 'Atividade' 


-- Outro exemplo utilizando caracter 

Select case when '10 ' + 5  = 15
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as 'Atividade'


-- Neste outro exemplo temos novamente a conversão implicita. 
-- O valor 5 que é do tipo INT tem prioridade no tipo CHAR que é 
-- o valor '10 '. Então o valor '10 ' é convertido para 10 implicitamente.

Select case when 'Valor 10 ' + 5  = 15
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as Resultado 


-- https://docs.microsoft.com/pt-br/sql/t-sql/data-types/data-type-precedence-transact-sql




-- Operadores de COMPARAÇÃO 

-- Os predicados são comparações que realizamos para identificar 
-- os valores Verdadeira, Falso ou indefinido. 
-- Utilizamos operadores que atuam na comparação de colunas das tabelas com 
-- dados escalares, funções, outras colunas ou com conjunto de dados. 

/* 
Formatado básico de utilização :

<Coluna> <Operador> <Dados,Função,Coluna,..> 
--------------------------------------------
                  |
		tipo bit ou booliano:
		       0 - Falso
			 1 - Verdadeiro

*/

/*
					=
					>
					<
					>=
					<=
					<>
					IS NULL
					IS NOT NULL 

					!= 
					!>
					!<

*/            

Select *
  From Vendas.Pedido
 Where DataPedido >= '2008-05-06' -- Usando dado Escalar 

 Select *
  From Vendas.Pedido
 Where DataPedido >= GETDATE() -- Usando uma função nativa do SQL SERVER 

 Select *
  From Vendas.Pedido
 Where DataEnvio > DataRequisicao -- Utilizando uma outra coluna.


 -- O resultado de duas expressões com um operador de comparação, 
 -- resulta em um valor do tipo bit ou booliano. Isso é chamado
 -- de expressões boolianas. 
 
 -- Uma expressão também pode ser definida com duas expressões 
 -- e com um operador de comparação.

Select PrimeiroNome , 
       DataAdmissao , CAST ( GETDATE() - DataAdmissao as int )  as TempoDias
  From Rh.Empregado
 Where CAST ( GETDATE() - DataAdmissao as int ) <= 5000




-- Operadores LÓGICOS 

-- Combinam duas ou mais expressões de comparação para avaliar
-- se elas são verdadeiras ou falsas.

/*
	AND            
	OR 
	NOT 
	IN
	BETWEEN 

	ALL
	ANY
	EXISTS
	LIKE
	SOME 

*/

-- Operador lógico AND 
 
 /*
 Ele combina DUAS ou mais expressões boolianas e retorna 
 uma outra expressão booliana verdadeira,
 se TODAS as expressões comparação forem verdadeiras. 

 Expressão 1 AND Expressão 2 
 
 O operador AND tem preferência sobre todos os outros operadores lógicos.
 */

/*
             Verdadeiro   Falso        Desconhecido
------------ ------------ ------------ ------------
Verdadeiro   Verdadeiro   Falso        Desconhecido
Falso        Falso        Falso        Falso       
Desconhecido Desconhecido Falso        Desconhecido

Somente em um caso é que duas expressões com o operador AND é verdadeiro.

*/


 use FundamentosTSQL
 go

 -- Os contatos de clientes que são representantes de vendas 
 -- e moram no Reino Unido (UK).
 -- Temos aqui dois predicados:
 -- 1. Clientes que são representantes de vendas -> Cargo = 'Sales Representative' 
 -- 2. Mora em Londres ->  Pais = 'UK'


 Select RazaoSocial, Contato, Cargo, Pais , Regiao 
   From Vendas.Cliente
  Where Cargo = 'Sales Representative' 
 
 -- 17 linhas 

 Select RazaoSocial, Contato, Cargo, Pais  , Regiao
   From Vendas.Cliente
  Where pais = 'UK'
 
 -- 7 linhas.
 
 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Cargo = 'Sales Representative' and Pais = 'UK'
 
 -- Quantas linhas serão retornada? 

 -- Valor desconhecido  

 -- Quais são contatos de clientes que não tem região e moram no Reino Unido?

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'UK' and Regiao = null 

-- Qual o valor da primeira comparação ? 
-- E o valor da segunda comparação ?     
-- Quantas linhas serão retornadas na instrução acima?



--- Para apresentar os contatos de clientes que moram na França e Alemanha ?

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'France' 
    and Pais = 'Germany'

-- Quantas linhas serão retornada? 

select datepart(dw,getdate()) -- Sexta 

select case when datepart(dw,getdate()) =  6 or datepart(dw,getdate()) = 7
            then 'Hoje é Sexta ou Sábado' 
			else 'Não sei que dia é hoje'
		end as 'Que dia é ?'


/*
O que é armazenado em uma coluna é um dado escalar, único.
Você não tem dois valores em um coluna. Então, não temos 
France e Germany na coluna PAIS para um linha, por exemplo. 
*/
 
 

-- Operador lógico OR 

 /*
 Ele combina Duas ou mais expressões bolianas e retorna 
 uma outra expressão booliana verdadeira  
 se pelo menos UMA das expressões forem verdadeira. 
 
 Expressão 1 OR Expressão 2 
 
 O operador OR é avaliado depois do operador AND.
 */

/*
             Verdadeiro   Falso        Desconhecido
------------ ------------ ------------ ------------
Verdadeiro   Verdadeiro   Verdadeiro   Verdadeiro
Falso        Verdadeiro   Falso        Desconhecido
Desconhecido Verdadeiro   Desconhecido Desconhecido

*/

 -- Os contatos de clientes que são representantes de vendas OU moram no Reino Unido 
 -- Temos aqui dois predicados. 
 -- 1. Clientes que são representantes de vendas. -> Cargo = 'Sales Representative' 
 -- 2. Mora em Londres. -> Pais = 'UK'


 Select RazaoSocial, Contato, Cargo, Pais , Regiao 
   From Vendas.Cliente
  Where Cargo = 'Sales Representative' 
 
 -- 17 linhas 

 Select RazaoSocial, Contato, Cargo, Pais  , Regiao
   From Vendas.Cliente
  Where pais = 'UK'
 
 -- 7 linhas.
 
 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Cargo = 'Sales Representative' or Pais = 'UK'

-- Quantas linhas serão retornadas. 


-- Valor desconhecido  

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'UK' or Regiao = null 

-- Qual o valor da primeira comparação ? 
-- E o valor da segunda comparação ?     
-- Quantas linhas serão retornadas na instrução acima?



--- Para apresentar contatos de clientes que moram na França e Alemanha ?

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'France' OR Pais = 'Germany'

-- Quantas linhas serão retornada? 

select datepart(dw,getdate()) -- Sexta

select case when datepart(dw,getdate()) =  6 OR datepart(dw,getdate()) = 7
            then 'Hoje é Sexta OU Sábado' 
			else 'Não sei que dia é hoje'
		end 



/*
Utilizando os Operadores AND E OR 
*/

/*
É muito comum em comandos SELECT ou outros comandos DML, realizar
operações de comparações entre diversas expressões e muitos casos
utilizarmos os operadores lógicos AND e OR. 
*/

-- Expressão 1 AND Expressão 2 OR Expressão 3
-- Expressão 1 OR Expressão 2 AND Expressão 3


-- Mostrar os clientes do Canada e Usa e o cargo do 
-- contato é Assistente de Marketing ('Marketing Assistant')

-- Montando então a nossa consulta, temos

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'Canada' or Pais = 'USA' and Cargo = 'Marketing Assistant'

/*
RazaoSocial      Contato                 Cargo                Pais     Regiao
---------------- ----------------------- -------------------- -------- ------
Customer EEALV   Bassols, Pilar Colome   Accounting Manager   Canada   BC
*/

-- Qual é mesmo a preferência entre os operadores lógicos?

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'Canada' or Pais = 'USA' and Cargo = 'Marketing Assistant'
        ---------------    ------------     ----------------------------
--Resp. |   CANADA    |    |  CANADA  |     |    Accounting Manager    |
        -----[P]-------    -----[Q]----     ------------[R]-------------

/*
 P   Q   R -> P or Q and R
--- --- ---   ------------
 V   V   V         V
 V   V   F         V
 V   F   V         V
 V   F   F         V 
 F   V   V         V 
 F   V   F         F
 F   F   V         F
 F   F   F         F
 
*/

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where (Pais = 'Canada' or Pais = 'USA') and Cargo = 'Marketing Assistant'
        ---------------    ------------       ----------------------------
     -- |   CANADA    |    |  CANADA  |       |    Accounting Manager    |
        -----[P]-------    -----[Q]----       ------------[R]-------------

/*
 P   Q   R -> P or Q and R  (P or Q) and R
--- --- ---   ------------  --------------
 V   V   V         V              V
 V   V   F         V              F
 V   F   V         V              V
 V   F   F         V              F 
 F   V   V         V              V
 F   V   F         F              F
 F   F   V         F              F
 F   F   F         F              F
*/


-- Operador lógico NOT 

/*
Operador ele nega uma expressão, invertando o seu valor.  
Não funcionar com valor desconhecido. 

*/

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'Canada' 

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where not Pais = 'Canada' 
  
Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais <> 'Canada' 

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where not Pais <> 'Canada' 



Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where NOT (Pais = 'Canada' or Pais = 'USA') and Cargo = 'Marketing Assistant'
             ---------------    ------------     ----------------------------
          -- |   CANADA    |    |  CANADA  |     |    Accounting Manager    |
             -----[P]-------    -----[Q]----     ------------[R]-------------

--- Quem voce está negado ?

/*
 P   Q   R -> NOT (P or Q) and R
--- --- ---   ------------------
 V   V   V            F     
 V   V   F            F    
 V   F   V            F     
 V   F   F            F     
 F   V   V            F     
 F   V   F            F     
 F   F   V            V     
 F   F   F            F     
*/




-- Operador IN - Avalia se um expressão está contida dentro de uma
-- lista de expressões 

Select Case When 0 in (1,2,3,4,5,0) 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

Select Case When 6 in (1,2,3,4,5,0) 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

-- Operador IN é equivalente a vários operadores OR 

Select Case When 0=1 OR 0=2 OR 0=3 OR 0=4 OR 0=5 OR 0=0
            Then 'Verdade' 
			Else 'Falso' 
	   End 


-- Operador Between - Avalia se uma expressão enta contido dentro de 
-- um Intervalo. (De/Até)

Select Case When 5 Between 0 and 10 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

Select Case When 15 Between 0 and 10 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

-- Operador Between é equivalente a duas comparações >= e <= com o 
-- operador logico AND

Select Case When 5 >= 0 and 5 <= 10 
            Then 'Verdade' 
			Else 'Falso' 
	   End 



/*
Utilizando esses predicados com as tabelas do banco de dados 
*/

Use FundamentosTSQL
go

Select Contato, Cargo, Cidade, Regiao 
  From Vendas.Cliente 
 Where Regiao in ('SP','RJ') 

Select * 
  From Vendas.Pedido
 Where iIDPedido in (10252,11077,11071,11000,12007)

--- Equivalente 

Select Contato, Cargo, Cidade, Regiao 
  From Vendas.Cliente 
 Where Regiao = 'SP' or regiao = 'RJ' 

Select * 
  From Vendas.Pedido
 Where iIDPedido = 10252
    or iIDPedido = 11077
    or iIDPedido = 11071
    or iIDPedido = 11000
    or iIDPedido = 12007

Select * 
  From Vendas.Pedido
 Where datapedido between '2006-07-04' and '2006-08-01'

Select * 
  From Vendas.Pedido
 Where iIDPedido between 10252 and 10262

-- Equivalente 

Select * 
  From Vendas.Pedido
 Where datapedido >= '2006-07-04' and datapedido <= '2006-08-01'

Select * 
  From Vendas.Pedido
 Where iIDPedido >= 10252 and iIDPedido <= 10262


/*
Tabela de Prioridades 
*/

-- Expressões complexas com vários operadores, requer que eles
-- tenham precedências entre si.

-- Esse precedencia determina a ordem de execução e consequentemente
-- pode afetar o valor do resultado que voce deseja alcançar. 

/*
Nível	Operadores
1	    ~ (Não de bit a bit)
2       * (Multiplicação), / (Divisão),% (Módulo)
3	    + (Positivo), - (negativo), + (adição) + (concatenar), 
        - (subtração) & (AND bit a bit), ^ (bit a bit exclusivo), | (OR bit a bit)
4	    =, >, <, > =, < =, <>,! =,! >,! < (operadores de comparação)
5	    NOT
6	    AND
7	    BETWEEN, IN, OR, LIKE, SOME, ALL, ANY 
8	    = (Atribuição)
*/

select 4 - 2 + 27 
select 2 + 27 -4

select 4 - 2 + 27 , (4 - 2) + 27 , 4 - (2 + 27)
select 2 + 27 - 4 , (2 + 27) - 4 , 2 + (27 - 4)



