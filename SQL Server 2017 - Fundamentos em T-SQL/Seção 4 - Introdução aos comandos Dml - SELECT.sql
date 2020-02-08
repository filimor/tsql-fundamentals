/*
SELECT - Recupera dados de uma tabela, 
         permite realizar tratamentos dos dados e retorna a informações 
*/


select 1 

select 1+2

select 5+4 as Resultado

select 'Jose da Silva' as Nome

select 'Jose' + ' da ' + 'Silva' as Nome

select 40 , 'Jose da Silva ' , '2017-08-09'

select 40 as Idade, 'Jose da Silva ' as Nome, '2017-08-09' as DataAtual

select 10 + ' Jose '

select 10 + ' 40'

select Jose + 10

select 10 + 5 * 2  as Resultado

select (10 + 5) * 2  as Resultado







-- Forma mais simples do SELECT com pesquisa em tabelas.

USE FundamentosTSQL
GO
SELECT * FROM Vendas.Cliente

-- Selecionando as colunas

Select RazaoSocial, Endereco, CEP From Vendas.Cliente

Select CEP ,Endereco, RazaoSocial From Vendas.Cliente

-- Incluir alias ou apelido no nome das colunas 

Select RazaoSocial as Empresa, Endereco as Local, CEP as CodigoPostal From Vendas.Cliente

-- Realizar operações de concatenação ou matemáticas

Select RazaoSocial, Endereco+', '+ Cidade + ', ' + CEP as Endereco from Vendas.Cliente

Select PrimeiroNome+' '+UltimoNome as Nome, Cargo, Salario/12 * 3  as SalarioMensal from Rh.Empregado

-- Organizando o código para uma melhor leitura. 

Select RazaoSocial as Empresa, 
       Endereco as Local, 
	   CEP as CodigoPostal 
  From Vendas.Cliente

/*
Filtrando linhas 
*/

-- Apresentado apenas um cliente
Select * 
  From Vendas.Cliente
 Where iIDCliente = 1

-- Apresentando os clientes do Pais Brazil.

Select * 
  From Vendas.Cliente
 Where Pais = 'Brazil' 

-- Monstrando os Empregados com salario menor que 50.000 anual 

Select *
  From rh.Empregado
 Where Salario < 50000

-- Apresentando os Clientes do Pais Brazil e do estado do Rio de Janeiro 

Select * 
  From Vendas.Cliente
 Where Pais = 'Brazil' 
   and Cidade = 'Rio de Janeiro'

-- Mostrar todos os pedidos solicitado em 2006!!

Select *
  From Vendas.Pedido
 Where DataPedido >= '2006-01-01' 
   and DataPedido <= '2007-01-01'

-- Mostrar os Pedidos enviados para o Rio de Janeiro e Sao Paulo.

Select *
  From Vendas.Pedido
 Where shipCidade = 'Rio de Janeiro' 
    or shipCidade = 'Sao Paulo'

-- Ordernar os resultados

Select RazaoSocial, Contato, Pais , Cidade 
  From Vendas.Cliente
 Order by Pais

Select RazaoSocial, Contato, Pais , Cidade 
  From Vendas.Cliente
 Order by Pais,Cidade 

Select PrimeiroNome +' '+  UltimoNome as Nome, Cargo , DataAdmissao 
  From rh.Empregado
 Order by PrimeiroNome

Select PrimeiroNome +' '+  UltimoNome as Nome, Cargo , DataAdmissao 
  From rh.Empregado
 Order by Nome

Select PrimeiroNome +' '+  UltimoNome as Nome, Cargo , DataAdmissao 
  From rh.Empregado
 Order by 1

 -- Selecionando dados Distintos e Agrupando os dados e gerando novos valores.

 Select Cidade  
   from Vendas.Cliente

 Select Distinct Cidade  
   from Vendas.Cliente

Select Cidade  , 
       count(*) as TotalClientes
  from Vendas.Cliente
 Group by Cidade 

Select Cidade, 
       count(*) as TotalClientes
  From Vendas.Cliente
 Group by Cidade 
 Order by TotalClientes Desc


Select Cidade  , 
       count(*) as TotalClientes
  From Vendas.Cliente
 Group by Cidade 
Having count(*) >= 2
 Order by TotalClientes Desc







