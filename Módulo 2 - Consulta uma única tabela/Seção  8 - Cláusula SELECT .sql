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
Além de apresentar os dados, o SELECT permite manipular 
os dados para a apresentação
*/			  

/*
-- Ordem nas colunas 
*/

Select RazaoSocial, Contato, Cargo, Endereco 
  From Vendas.Cliente

Select Cargo, Endereco , RazaoSocial, Contato 
  From Vendas.Cliente

Select Cargo, Cargo, Endereco , Endereco ,RazaoSocial, Contato 
  From Vendas.Cliente

-- Para realizar consultas, o T-SQL permite duplicar nome de colunas. 
-- Mas essa regra deve ser evitada e em certos casos 
-- (como CTE, views e subconsultas)
-- o T-SQL não permite nomes de colunas duplicadas. 

/*
Expressões 
*/

Select Contato, Cargo, 
       Endereco, Cidade , CEP, Pais , 
	   Telefone, Fax
  From Vendas.Cliente

Select Contato, Cargo, 
       Endereco, Cidade , CEP, Pais , 
	   Telefone, Fax
  From Vendas.Cliente

-- Contato sempre em letra maiusculas

Select UPPER(Contato), Cargo, 
       Endereco, Cidade , CEP, Pais , 
	   Telefone, Fax
  From Vendas.Cliente

-- Endereco Completo e Telefones em um unica coluna 

Select UPPER(Contato), Cargo, 
       Endereco +', ' + Cidade+', '+ CEP+', '+ Pais , 
	   Telefone+' - '+ Fax 
  From Vendas.Cliente

-- Incluir uma expressão sem ser coluna

-- Endereco Completo e Telefones em um unica coluna 

Select 'Remetente' , 
       UPPER(Contato), Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais , 
	   Telefone+' - '+ Fax 
  From Vendas.Cliente

-- No caso da tabela de produto, podemos criar um relatorios 
-- do produtos ativos e estimar um aumento de 10% no preco unitário

select NomeProduto, PrecoUnitario ,  Desativado 
  from Producao.Produto

Select NomeProduto, PrecoUnitario ,  PrecoUnitario * 1.10
  From Producao.Produto
 Where Desativado = 0

/*
Utilização de alias ou apelidos.
*/

-- Veja esse exemplo, somente a coluna Cargo manteve o título da coluna.

Select 'Remetente' , 
       UPPER(Contato), Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais , 
	   Telefone+' - '+ Fax 
  From Vendas.Cliente


-- O Alias ou apelido é um recurso que temos para colocar um rótulo 
-- ou nome na coluna ou expressão. Existe tres forma de fazer
-- isso, mas somente uma será recomendada e que utilizarei nos exemplos

-- Alias ao lado da coluna ou expressão
Select 'Remetente' Titulo, 
       UPPER(Contato) Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais Endereco , 
	   Telefone+' - '+ Fax Telefones 
  From Vendas.Cliente

-- Alias antes da coluna ou expressão com o sinal de igualdade 
Select Titulo    = 'Remetente'  , 
       Nome      = UPPER(Contato) , 
	   Cargo, 
       Endereco  = Endereco +',' + Cidade+', '+ CEP+', '+ Pais  , 
	   Telefones = Telefone+' - '+ Fax  
  From Vendas.Cliente

-- A forma no padrão ANSI com a 'Colunas' as 'Apelido' 
Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente

/*
Recomendavel usar o padrão ANSI.
*/

-- Cuidado com a separação das colunas ou expressão e esquecer um virgula,
-- Veja o exemplo abaixo :

Select Contato, Cargo Endereco, Cidade , CEP, Pais  
	   Telefone, Fax
  From Vendas.Cliente


/*
Como na cláusula SELECT podemos colocar alias nas colunas ou expressões,
esses dados são enviados para a próxima fase e podem ser processados por elas.
Mas esses alias não pode ser utilizados pelas fases anteriores.
Motivo é simples, nas fases anteriores, esses alias não existem. 
O que existem são as colunas
*/

-- Com a coluna que existe.
Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  where Cargo = 'Owner'

-- Com o uso de uma Alias.

Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  Where Nome = 'RAY, MIKE'

-- Corrigindo o problema 
Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente
  where UPPER(Contato) = 'RAY, MIKE'


 -- Exemplo com o Having 

Select YEAR(DataPedido) as AnoPedido,  
       iIDEmpregado, 
       COUNT(*) as QuantidadePedido
  From Vendas.Pedido                   
 Where iIDCliente = 71                 
 Group by YEAR(DataPedido) ,           
          iIDEmpregado 
 Having QuantidadePedido > 1    


-- Utilizando alias de tabela e alias de coluna

Select 'Remetente'  as Titulo, 
       UPPER(Cliente.Contato) as Nome, 
       Cliente.Cargo, 
       Cliente.Endereco +',' + Cliente.Cidade+', '+ Cliente.CEP+', '+ Cliente.Pais as Endereco , 
	   Cliente.Telefone+' - '+ Cliente.Fax  as Telefones 
  From Vendas.Cliente as Cliente
 Where Cliente.Cargo = 'Owner'


 Select 'Remetente'  as Titulo, 
       UPPER(Cliente.Contato) as Nome, 
       Cliente.Cargo, 
       Cliente.Endereco +',' + Cliente.Cidade+', '+ Cliente.CEP+', '+ Cliente.Pais as Endereco , 
	   Cliente.Telefone+' - '+ Cliente.Fax  as Telefones 
  From Vendas.Cliente as Cliente
 Where UPPER(Cliente.Contato) = 'RAY, MIKE'
 
 -- Hummm, problema de desempenho..... ops ...


/*
Realizando a apresentação de dados sem repetição utilizando o DISTINCT 
*/

-- Vamos imaginar uma instrução que apresente o Pais e Cidade dos Clientes

select Pais, Cidade 
  from Vendas.Cliente

-- E em uma rápida visualização, voce percebe que tem linhas repetidas. 

Select Distinct Pais, Cidade 
  from Vendas.Cliente

-- Colunas que não tem efeito no DISTINCT 
-- Colunas que compõe um PK ou um coluna UNIQUE. 
-- Expressões no SELECT que retornam valores únicos. 

select distinct iIDCliente ,Pais, Cidade 
  from Vendas.Cliente

select distinct Documento,Pais, Cidade 
  from Vendas.Cliente

Select Distinct Pais, Cidade , NEWID() as ID
  from Vendas.Cliente

  select newid()


/*
Outra forma de distinção de dados sem o DISTINCT 
*/

select Pais, Cidade 
  from Vendas.Cliente
  group by Pais, Cidade 


/*
*/


