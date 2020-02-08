use DBExemplo
go

Select * from Exemplo3
go

Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0 
   and Quantidade / Caixa  > 2
   and CAST(Emissao as date) > GETDATE() 

/*

CASE..WHEN..THEN...ELSE...END 

A instru��o Case � um instru��o de linha que pode ser utilizada 
juntamente com instru��es SELECT. N�o � uma instru��o de desvio 
de fluxo de um c�digo estruturado. Na sua concep��o, tem o 
comportamento semelhante a uma instru��o IF ou WHILE das linguagem 
de programa��o. 
Ela � definida como instru��o de linha, pelo seguinte motivo:
*/

select getdate()

Select Case When GETDATE() >= '2016-12-31' -- Quando DataAtual maior que 2017
            Then 'Ano 2017'                -- Ent�o 'Ano 2017' 
			Else 'Outro ano'               -- Caso contrario 'Outro Ano' 
	   End                                 -- Fim
        

/*
CASE WHEN <Express�o logica, predicado, operadores logicos>
     THEN <Resultado, se express�o logica Verdadeira>
	 ...
	 ELSE <Resultado, se express�o logica Falsa> 
END 

CASE WHEN <Express�o logica,...> THEN <Resultado>
	 WHEN <Express�o logica,...> THEN <Resultado>
	 ...
	 ELSE <Resultado, se todos os WHEN forem falso> 
END 

CASE <Express�o> 
     WHEN <Express�o> THEN <Resultado>
	 WHEN <Express�o> THEN <Resultado>
	 ELSE <Resultado, se todos os WHEN forem falso> 
END 
*/

SELECT DatePart(dw,GetDate()) , GetDate()
-- dw significa Day Of Week ou dia da semana. 

Select Case datepart(dw,getdate()) 
            when 1 then 'Domingo' 
	        when 2 then 'Segunda-feira' 
	        when 3 then 'Ter�a-feira' 
	        when 4 then 'Quarta-feira' 
	        when 5 then 'Quinta-feira' 
	        when 6 then 'Sexta-feira' 
	        when 7 then 'S�bado-feira' 
	   End as DiaDaSemana 

-- No exemplo acima, o uso do Else n�o foi necess�rio.

SELECT * FROM EXEMPLO3

Select (Case When Quantidade <= 30 
            Then 'Caixas Pequenas' 
			Else 'Caixas Grandes' 
       End) as TipoCaixa , 
	   Quantidade , 
	   Caixa , 
	   Emissao 
  from Exemplo3

Select Case When Quantidade <= 30  Then 'Caixas Pequenas' 
            When Quantidade <= 190 Then 'Caixas Grandes' 
			Else 'Caixas fora de Medidas' 
       End as TipoCaixa , 
	   Quantidade , 
	   Caixa , 
	   Emissao 
  from Exemplo3


Select Case Quantidade 
            When 10 Then 'Caixa Tipo 1'
			When 20 Then 'Caixa Tipo 2'
			When 30 Then 'Caixa Tipo 3'
			Else 'Caixas Grandes' 
       End as TipoCaixa , 
	   Quantidade , 
	   Caixa , 
	   Emissao 
  from Exemplo3

/*
Utilizando CASE para resolver os erros na clausula WHERE 
*/


Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0 
   and (Case When Caixa = 0 
             Then 0  
			 Else Quantidade / Caixa 
	    End) > 2


Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0 
   and (Case When ISDATE(Emissao) = 1 
             Then CAST(Emissao as date) 
			 Else '1900-01-01'
	    END) > GETDATE() 



Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where Desativado = 0 
   and (Case When Caixa = 0 
             Then 0  
			 Else Quantidade / Caixa 
	    End > 2)
   and (Case When ISDATE(Emissao) =1 
             Then CAST(Emissao as date) 
		 	 Else '1900-01-01'
	    End > GETDATE() )

/*
[DBExemplo].[dbo].[Exemplo3].[Desativado]=(0) AND 
CASE WHEN [Caixa]=(0) 
     THEN (0) 
	 ELSE [Quantidade]/[DBExemplo].[dbo].[Exemplo3].[Caixa] END>(2)

CASE WHEN isdate(CONVERT_IMPLICIT(nvarchar(10),[Emissao],0))=(1) 
     THEN CONVERT(date,[Emissao],0) ELSE '1900-01-01' END >getdate()

*/
/*
Algumas observa��es 
*/

-- Tenter usar outras tecnicas para resolver esses casos.
-- Em um treinamento sobre desempenho de instru��es, a pr�tica acima
-- deve ser evitada para certos cen�rios

-- Um exemplo para evitar a divis�o por zero !! 

Select Id,
       Quantidade,
	   Caixa , 
	   Emissao , 
	   Desativado 
  From Exemplo3
 Where Caixa <> 0 and Quantidade / Caixa  > 2 


Select Id,
       Quantidade,
	   Caixa , 
	   Emissao 
  From Exemplo3
 Where (Quantidade > Caixa * 2 and Caixa <> 0  )


-- N�o importa se um do predicados tem custo menor que outro ou vice-versa
-- Neste exemplo, n�o teremos o erro de Divis�o por Zero!!


 /*
 Como seria para resolver o caso da data de Emissao?
 */

Select Id,
       Quantidade,
	   Caixa , 
	   Emissao  
  From Exemplo3
 Where CAST( try_parse(Emissao as date) as date) > GETDATE() 







/*
Exemplos de Case Aninhados 
*/
Select id , 
       -- Segunda Coluna 
       Case When Quantidade <= 30 
            Then 'Caixa Pequena, ' +
			   ( 
			   Case Quantidade 
					When 10 Then 'Tipo 1'
					When 20 Then 'Tipo 2'
					When 30 Then 'Tipo 3'
			   End 
			   ) 
			When Quantidade <= 60 
			Then 'Caixa Grande, ' + 
			   ( 
			   Case Quantidade 
					When 40 Then 'Tipo 11'
					When 50 Then 'Tipo 12'
					When 60 Then 'Tipo 13'
			   End 
			   ) 
			Else 'Fora de Medida'
	   End as TipoCaixa , 
	   --- 
	   Quantidade , 
	   Caixa , 
	   Emissao 
  from Exemplo3


