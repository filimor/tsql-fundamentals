/*
EXPRESS�ES, OPERADORES E PREDICADOS 
*/


/*
EXPRESS�ES 

Combina��o de valores e operadores que o SQL avalia para 
obter um resultado. 

*/
use FundamentosTSQL
go

Select 'Aos Cuidados de:' as Titulo, 
       Contato 
  From Vendas.Cliente

-- Contato e a constante 'Aos Cuidados de:' , no contexto de execu��o 
-- da instru��o acima s�o classificados como express�o simples 

Select NomeProduto, 
       PrecoUnitario,
       PrecoUnitario * 1.15 as NovoPreco 
  From Producao.Produto

-- Um calculo matem�tico acima � classificada 
-- como uma express�o complexa.

Select PrimeiroNome , 
       DataAdmissao , GETDATE() - DataAdmissao as TempoDias
  From Rh.Empregado

-- Express�es quando combinadas com operadores, que podem gera um valor
-- com o mesmo tipo de dados.  

-- Para gerar tipos de dados diferentes, o SQL pode realizar a 
-- chamada convers�o impl�cita ou ent�o ser� necess�rio
-- utilizar fun��es de convers�o (CAST ou CONVERT) ou fun��es 
-- espec�ficas que tratam o tipo de dado. 

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

-- Exemplo usando fun��o que trata o mesmo tipo de dado. 
  Select PrimeiroNome , 
       DataAdmissao , DATEDIFF(d,DataAdmissao,GETDATE() )  as Tempo
  From Rh.Empregado



/*
OPERADORES 

S�mbolo que especifica a a��o que ser� realizada em uma ou
mais express�es. 

*/

-- Operadores ARITM�TICOS 
/*
					+ 
					- 
					* 
					/ 
					%
*/

Select 3+4 as Soma, 
       4-2 as Subtra��o, 
	   5*2 as Multiplica��o ,
	   12/2 as Divis�o,
   	   15/7 as Divis�o,
       15%7 as M�dulo 

Select NomeProduto, 
	   PrecoUnitario * 1.15 + 2.00 
  From Producao.Produto

-- Operadores aritm�ticos como 3+4, por exemplo, s�o chamados 
-- tamb�m de express�es 



/*
Opera��o aritm�ticas com tipos de dados diferentes. 
*/

Select case when 10/3 > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end as 'Atividade' 

-- Se as duas express�es s�o do mesmo tipo de dado,
-- o resultado ser� do mesmo tipo de dado.

select 10/3





Select case when 10/3.0 > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end as 'Atividade'

-- Neste exemplo temos a convers�o implicita dos dados. O valor 
-- 3.0 que � do tipo NUMERIC tem prioridade no tipo INT que � 
-- o valor 10. Ent�o o valor 10 � convertido para 10.0 implicitamente.

-- Utilizando a fun��o CAST 
Select case when 10/ cast( 3 as numeric ) > 3
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as 'Atividade' 


-- Outro exemplo utilizando caracter 

Select case when '10 ' + 5  = 15
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as 'Atividade'


-- Neste outro exemplo temos novamente a convers�o implicita. 
-- O valor 5 que � do tipo INT tem prioridade no tipo CHAR que � 
-- o valor '10 '. Ent�o o valor '10 ' � convertido para 10 implicitamente.

Select case when 'Valor 10 ' + 5  = 15
            then 'Execute processo A' 
			else 'Execute processo B' 
       end  as Resultado 


-- https://docs.microsoft.com/pt-br/sql/t-sql/data-types/data-type-precedence-transact-sql




-- Operadores de COMPARA��O 

-- Os predicados s�o compara��es que realizamos para identificar 
-- os valores Verdadeira, Falso ou indefinido. 
-- Utilizamos operadores que atuam na compara��o de colunas das tabelas com 
-- dados escalares, fun��es, outras colunas ou com conjunto de dados. 

/* 
Formatado b�sico de utiliza��o :

<Coluna> <Operador> <Dados,Fun��o,Coluna,..> 
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
 Where DataPedido >= GETDATE() -- Usando uma fun��o nativa do SQL SERVER 

 Select *
  From Vendas.Pedido
 Where DataEnvio > DataRequisicao -- Utilizando uma outra coluna.


 -- O resultado de duas express�es com um operador de compara��o, 
 -- resulta em um valor do tipo bit ou booliano. Isso � chamado
 -- de express�es boolianas. 
 
 -- Uma express�o tamb�m pode ser definida com duas express�es 
 -- e com um operador de compara��o.

Select PrimeiroNome , 
       DataAdmissao , CAST ( GETDATE() - DataAdmissao as int )  as TempoDias
  From Rh.Empregado
 Where CAST ( GETDATE() - DataAdmissao as int ) <= 5000




-- Operadores L�GICOS 

-- Combinam duas ou mais express�es de compara��o para avaliar
-- se elas s�o verdadeiras ou falsas.

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

-- Operador l�gico AND 
 
 /*
 Ele combina DUAS ou mais express�es boolianas e retorna 
 uma outra express�o booliana verdadeira,
 se TODAS as express�es compara��o forem verdadeiras. 

 Express�o 1 AND Express�o 2 
 
 O operador AND tem prefer�ncia sobre todos os outros operadores l�gicos.
 */

/*
             Verdadeiro   Falso        Desconhecido
------------ ------------ ------------ ------------
Verdadeiro   Verdadeiro   Falso        Desconhecido
Falso        Falso        Falso        Falso       
Desconhecido Desconhecido Falso        Desconhecido

Somente em um caso � que duas express�es com o operador AND � verdadeiro.

*/


 use FundamentosTSQL
 go

 -- Os contatos de clientes que s�o representantes de vendas 
 -- e moram no Reino Unido (UK).
 -- Temos aqui dois predicados:
 -- 1. Clientes que s�o representantes de vendas -> Cargo = 'Sales Representative' 
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
 
 -- Quantas linhas ser�o retornada? 

 -- Valor desconhecido  

 -- Quais s�o contatos de clientes que n�o tem regi�o e moram no Reino Unido?

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'UK' and Regiao = null 

-- Qual o valor da primeira compara��o ? 
-- E o valor da segunda compara��o ?     
-- Quantas linhas ser�o retornadas na instru��o acima?



--- Para apresentar os contatos de clientes que moram na Fran�a e Alemanha ?

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'France' 
    and Pais = 'Germany'

-- Quantas linhas ser�o retornada? 

select datepart(dw,getdate()) -- Sexta 

select case when datepart(dw,getdate()) =  6 or datepart(dw,getdate()) = 7
            then 'Hoje � Sexta ou S�bado' 
			else 'N�o sei que dia � hoje'
		end as 'Que dia � ?'


/*
O que � armazenado em uma coluna � um dado escalar, �nico.
Voc� n�o tem dois valores em um coluna. Ent�o, n�o temos 
France e Germany na coluna PAIS para um linha, por exemplo. 
*/
 
 

-- Operador l�gico OR 

 /*
 Ele combina Duas ou mais express�es bolianas e retorna 
 uma outra express�o booliana verdadeira  
 se pelo menos UMA das express�es forem verdadeira. 
 
 Express�o 1 OR Express�o 2 
 
 O operador OR � avaliado depois do operador AND.
 */

/*
             Verdadeiro   Falso        Desconhecido
------------ ------------ ------------ ------------
Verdadeiro   Verdadeiro   Verdadeiro   Verdadeiro
Falso        Verdadeiro   Falso        Desconhecido
Desconhecido Verdadeiro   Desconhecido Desconhecido

*/

 -- Os contatos de clientes que s�o representantes de vendas OU moram no Reino Unido 
 -- Temos aqui dois predicados. 
 -- 1. Clientes que s�o representantes de vendas. -> Cargo = 'Sales Representative' 
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

-- Quantas linhas ser�o retornadas. 


-- Valor desconhecido  

 Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'UK' or Regiao = null 

-- Qual o valor da primeira compara��o ? 
-- E o valor da segunda compara��o ?     
-- Quantas linhas ser�o retornadas na instru��o acima?



--- Para apresentar contatos de clientes que moram na Fran�a e Alemanha ?

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'France' OR Pais = 'Germany'

-- Quantas linhas ser�o retornada? 

select datepart(dw,getdate()) -- Sexta

select case when datepart(dw,getdate()) =  6 OR datepart(dw,getdate()) = 7
            then 'Hoje � Sexta OU S�bado' 
			else 'N�o sei que dia � hoje'
		end 



/*
Utilizando os Operadores AND E OR 
*/

/*
� muito comum em comandos SELECT ou outros comandos DML, realizar
opera��es de compara��es entre diversas express�es e muitos casos
utilizarmos os operadores l�gicos AND e OR. 
*/

-- Express�o 1 AND Express�o 2 OR Express�o 3
-- Express�o 1 OR Express�o 2 AND Express�o 3


-- Mostrar os clientes do Canada e Usa e o cargo do 
-- contato � Assistente de Marketing ('Marketing Assistant')

-- Montando ent�o a nossa consulta, temos

Select RazaoSocial, Contato, Cargo, Pais , Regiao
   From Vendas.Cliente
  Where Pais = 'Canada' or Pais = 'USA' and Cargo = 'Marketing Assistant'

/*
RazaoSocial      Contato                 Cargo                Pais     Regiao
---------------- ----------------------- -------------------- -------- ------
Customer EEALV   Bassols, Pilar Colome   Accounting Manager   Canada   BC
*/

-- Qual � mesmo a prefer�ncia entre os operadores l�gicos?

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


-- Operador l�gico NOT 

/*
Operador ele nega uma express�o, invertando o seu valor.  
N�o funcionar com valor desconhecido. 

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

--- Quem voce est� negado ?

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




-- Operador IN - Avalia se um express�o est� contida dentro de uma
-- lista de express�es 

Select Case When 0 in (1,2,3,4,5,0) 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

Select Case When 6 in (1,2,3,4,5,0) 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

-- Operador IN � equivalente a v�rios operadores OR 

Select Case When 0=1 OR 0=2 OR 0=3 OR 0=4 OR 0=5 OR 0=0
            Then 'Verdade' 
			Else 'Falso' 
	   End 


-- Operador Between - Avalia se uma express�o enta contido dentro de 
-- um Intervalo. (De/At�)

Select Case When 5 Between 0 and 10 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

Select Case When 15 Between 0 and 10 
            Then 'Verdade' 
			Else 'Falso' 
	   End 

-- Operador Between � equivalente a duas compara��es >= e <= com o 
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

-- Express�es complexas com v�rios operadores, requer que eles
-- tenham preced�ncias entre si.

-- Esse precedencia determina a ordem de execu��o e consequentemente
-- pode afetar o valor do resultado que voce deseja alcan�ar. 

/*
N�vel	Operadores
1	    ~ (N�o de bit a bit)
2       * (Multiplica��o), / (Divis�o),% (M�dulo)
3	    + (Positivo), - (negativo), + (adi��o) + (concatenar), 
        - (subtra��o) & (AND bit a bit), ^ (bit a bit exclusivo), | (OR bit a bit)
4	    =, >, <, > =, < =, <>,! =,! >,! < (operadores de compara��o)
5	    NOT
6	    AND
7	    BETWEEN, IN, OR, LIKE, SOME, ALL, ANY 
8	    = (Atribui��o)
*/

select 4 - 2 + 27 
select 2 + 27 -4

select 4 - 2 + 27 , (4 - 2) + 27 , 4 - (2 + 27)
select 2 + 27 - 4 , (2 + 27) - 4 , 2 + (27 - 4)



