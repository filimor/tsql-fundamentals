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
Al�m de apresentar os dados, o SELECT permite manipular 
os dados para a apresenta��o
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
-- o T-SQL n�o permite nomes de colunas duplicadas. 

/*
Express�es 
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

-- Incluir uma express�o sem ser coluna

-- Endereco Completo e Telefones em um unica coluna 

Select 'Remetente' , 
       UPPER(Contato), Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais , 
	   Telefone+' - '+ Fax 
  From Vendas.Cliente

-- No caso da tabela de produto, podemos criar um relatorios 
-- do produtos ativos e estimar um aumento de 10% no preco unit�rio

select NomeProduto, PrecoUnitario ,  Desativado 
  from Producao.Produto

Select NomeProduto, PrecoUnitario ,  PrecoUnitario * 1.10
  From Producao.Produto
 Where Desativado = 0

/*
Utiliza��o de alias ou apelidos.
*/

-- Veja esse exemplo, somente a coluna Cargo manteve o t�tulo da coluna.

Select 'Remetente' , 
       UPPER(Contato), Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais , 
	   Telefone+' - '+ Fax 
  From Vendas.Cliente


-- O Alias ou apelido � um recurso que temos para colocar um r�tulo 
-- ou nome na coluna ou express�o. Existe tres forma de fazer
-- isso, mas somente uma ser� recomendada e que utilizarei nos exemplos

-- Alias ao lado da coluna ou express�o
Select 'Remetente' Titulo, 
       UPPER(Contato) Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais Endereco , 
	   Telefone+' - '+ Fax Telefones 
  From Vendas.Cliente

-- Alias antes da coluna ou express�o com o sinal de igualdade 
Select Titulo    = 'Remetente'  , 
       Nome      = UPPER(Contato) , 
	   Cargo, 
       Endereco  = Endereco +',' + Cidade+', '+ CEP+', '+ Pais  , 
	   Telefones = Telefone+' - '+ Fax  
  From Vendas.Cliente

-- A forma no padr�o ANSI com a 'Colunas' as 'Apelido' 
Select 'Remetente'  as Titulo, 
       UPPER(Contato) as Nome, 
       Cargo, 
       Endereco +',' + Cidade+', '+ CEP+', '+ Pais  as Endereco , 
	   Telefone+' - '+ Fax  as Telefones 
  From Vendas.Cliente

/*
Recomendavel usar o padr�o ANSI.
*/

-- Cuidado com a separa��o das colunas ou express�o e esquecer um virgula,
-- Veja o exemplo abaixo :

Select Contato, Cargo Endereco, Cidade , CEP, Pais  
	   Telefone, Fax
  From Vendas.Cliente


/*
Como na cl�usula SELECT podemos colocar alias nas colunas ou express�es,
esses dados s�o enviados para a pr�xima fase e podem ser processados por elas.
Mas esses alias n�o pode ser utilizados pelas fases anteriores.
Motivo � simples, nas fases anteriores, esses alias n�o existem. 
O que existem s�o as colunas
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
Realizando a apresenta��o de dados sem repeti��o utilizando o DISTINCT 
*/

-- Vamos imaginar uma instru��o que apresente o Pais e Cidade dos Clientes

select Pais, Cidade 
  from Vendas.Cliente

-- E em uma r�pida visualiza��o, voce percebe que tem linhas repetidas. 

Select Distinct Pais, Cidade 
  from Vendas.Cliente

-- Colunas que n�o tem efeito no DISTINCT 
-- Colunas que comp�e um PK ou um coluna UNIQUE. 
-- Express�es no SELECT que retornam valores �nicos. 

select distinct iIDCliente ,Pais, Cidade 
  from Vendas.Cliente

select distinct Documento,Pais, Cidade 
  from Vendas.Cliente

Select Distinct Pais, Cidade , NEWID() as ID
  from Vendas.Cliente

  select newid()


/*
Outra forma de distin��o de dados sem o DISTINCT 
*/

select Pais, Cidade 
  from Vendas.Cliente
  group by Pais, Cidade 


/*
*/


