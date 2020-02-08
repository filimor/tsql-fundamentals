USE FundamentosTSQL;

	Select iIDEmpregado,                      -- FASE 5
		   year(DataPedido) as AnoPedido, 
		   count(*) as QuantidadePedido
	  From Vendas.Pedido                      -- FASE 1
	 Where iIDCliente = 71                    -- FASE 2
	 Group by iIDEmpregado,                   -- FASE 3
			  year(DataPedido)
	Having count(*) > 1                       -- FASE 4
	 Order by iIDEmpregado,                   -- FASE 6
			  AnoPedido



/*
Como j� explicado, os dados s�o armazenados em tabelas de forma aleat�ria 
e sem a garantiar de obtermos os dados naturalmente ordenados. 

*/

Select RazaoSocial, Endereco
  From Vendas.Cliente

Select RazaoSocial, Contato
  From Vendas.Cliente

Select RazaoSocial, Cargo
  From Vendas.Cliente

/*
A �nica forma de garantir dados ordenados e usando o ORDER BY 
*/

Select RazaoSocial, Endereco
  From Vendas.Cliente
 Order by RazaoSocial

Select RazaoSocial, Contato
  From Vendas.Cliente
 Order by RazaoSocial


Select RazaoSocial, Cargo
  From Vendas.Cliente
 Order by RazaoSocial


/*
O alias da coluna pode ser utilizado como elementos de ordena��o 
*/

Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  Order by UPPER(Contato) 

-- Como tamb�m a express�o 

Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  Order by UPPER(Contato)

-- Como a coluna  
Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  Order by Contato

/*
A linguagem T-SQL e a ANSI permite a ordena��o pelo n�mero da posi��o 
da coluna ou express�o no SELECT 
*/

Select NomeProduto,                        -- Posicao 1
       PrecoUnitario ,                     -- Posicao 2
	   PrecoUnitario * 1.10 as NovoPreco   -- Posicao 3
  From Producao.Produto
 Where Desativado = 0
 Order by 3

 -- Mas cuidado !!!. N�o recomendo o uso da ordena��o posi��o da coluna.
 -- Imagine que um outra pessoa fa�a a manuten��o 
 -- e inclua uma nova coluna no SELECT 

Select NomeProduto,                        -- Posicao 1
       PrecoUnitario ,                     -- Posicao 2
	   iIDCategoria,                       -- Posicao 3 Mudou !!!
	   PrecoUnitario * 1.10 as NovoPreco   -- Posicao 4
  From Producao.Produto
 Where Desativado = 0
 Order by 3

 -- O correto � utilizar a express�o ou o alias da expressao 

Select NomeProduto, 
       PrecoUnitario ,  
	   iIDCategoria,
	   PrecoUnitario * 1.10 as NovoPreco
  From Producao.Produto
 Where Desativado = 0
 Order by PrecoUnitario * 1.10


/*
Para determinar o sentido da ordena��o, voce pode colocar 
a express�o ASC ou DESC ap�s cada elemento ou coluna do ORDER BY 
*/

Select NomeProduto, 
       PrecoUnitario ,  
	   iIDCategoria,
	   PrecoUnitario * 1.10 as NovoPreco
  From Producao.Produto
 Where Desativado = 0
 Order by PrecoUnitario * 1.10 ASC

 Select NomeProduto, 
       PrecoUnitario ,  
	   iIDCategoria,
	   PrecoUnitario * 1.10 as NovoPreco
  From Producao.Produto
 Where Desativado = 0
 Order by PrecoUnitario * 1.10 DESC
 

 /*
 A T-SQL permite voc� ordenar por uma coluna que N�O est� expl�cita 
 nas cl�usulas do SELECT. 
 */

Select NomeProduto, 
       PrecoUnitario ,  
	   iIDCategoria,
	   PrecoUnitario * 1.10 as NovoPreco
  From Producao.Produto
 Where Desativado = 0
 Order by iIDProduto

/*
Exemplos de erros quando temos no ORDER BY uma coluna que n�o 
tem refer�ncia na instru��o SELECT.
*/

Select Pais, Cidade 
  From Vendas.Cliente
 Group by Pais, Cidade 
 Order by iIDCliente

/*
Msg 8127, Level 16, State 1, Line 158
Column "Vendas.Cliente.iIDCliente" is invalid in the ORDER BY 
clause because it is not contained in either an aggregate 
function or the GROUP BY clause.
*/

set language portuguese


Select Distinct Pais, Cidade 
  From Vendas.Cliente
 Order by iIDCliente

/*
Msg 145, Level 15, State 1, Line 167
ORDER BY items must appear in the select 
list if SELECT DISTINCT is specified.
*/

/*
Utilizando o Alias da coluna 
*/

Select Pais,Cidade , Contato 
  From Vendas.Cliente
 Order by Pais


Select Pais as Pais1,Cidade, Pais as Pais2, Cidade, Contato 
  From Vendas.Cliente
  where Pais = 'Germany'
 Order by Pais1

/*
Msg 209, Level 16, State 1, Line 188
Ambiguous column name 'Pais'.
*/

Select Cli.Pais,Cli.Cidade, Cli.Contato 
  From Vendas.Cliente as Cli
 Order by Cli.Pais 


 Select Cli.Pais as MeuPais,Cli.Cidade, Cli.Contato 
  From Vendas.Cliente as Cli
 Order by MeuPais

 /*
 */


