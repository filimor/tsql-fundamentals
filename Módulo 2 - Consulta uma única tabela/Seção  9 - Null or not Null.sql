/*
A T-SQL da suporte da marca NULL para representar a ausência do dados
*/

use DBExemplo
go

drop table if exists empregado

Create Table Empregado 
(
   id      int         not null,  -- Não aceita NULL
   Nome    varchar(20) not null,  -- Não aceita NULL
   Salario money       null    ,  -- Aceita NULL
   Comissao money      null       -- Aceita NULL
)

go

-- Um valor NULL não pode ser inserido em um coluna que não aceita NULL.

insert into Empregado (id, Nome, Salario, Comissao) 
               values (1 , null, 1000.00, 75.00)


insert into Empregado (id, Nome, Salario, Comissao) 
               values (1,'Jose da Silva'  , 1000.00, 75.00),
                      (2,'Maria da Silva' ,    NULL, NULL),
	                  (3,'Manuel da Silva', 2300.00, 96.00)

Select * From Empregado

Select id, Nome, Salario  
  From Empregado
 Where Salario <= 0 -- Mostra o empregado Maria da Silva?  

 -- Null não é menor que zero !!!

Select id, Nome, Salario  
  From Empregado
 Where Salario > 0

-- Null não é maior que zero !!!    

-- Como mostro as linhas que tem o NULL para salario ???

/*
No exemplo acima, o predicado Salario <= 0 para uma consulta ou 
Salario > 0  para a outra consulta aplica a regra do predicado de 
tres valores:

Verdadeiro
Falso
Desconhecido

Nas duas consultas, cada linha será avalida de acordo com o predicado. 
Se o valor do predicado for verdadeiro, a linha é processada na fase. 

Se o predicado é falso ou desconhecido, ela não será processada. 

*/

Select * From Empregado
where not (Salario < 0)

/*
No exemplo acima, o predicado NOT (Salario < 0) estamos negando um 
predicado. Isso significa que se ele avalia o predicado (Salario < 0) 
como verdadeiro, o NOT avalia ele é como "não verdadeiro" e vice-versa. 

O salário do Jose que é de 1000.00 no predicado Salario <0, é avaliado como FALSO.
Mas temos uma NOT, então ele é avaliado como verdadeiro. Se é verdadeiro, a
linha é processada pela fase. 

Entretando o NULL não foi processado em nenhum dos momentos.

Pelo simples motivo do NULL não é VERDADEIRO e não é FALSO. 

Tudo que é associado com NULL sempre será NULL !!!

*/

Select  1 + null 

Select ((12*2)/2)/(4+null)

Select 'Jose ' + null + 'Silva'

Select GETDATE() + null 

---  Agora um caso muito comum entre os desenvolvedores 

Select 'NULL' 

Select NULL 

-- São instruções totalmente idênticas ??? 

Select 'NULL' + '  Jose ' 

Select NULL + '  Jose '  

-- Cuidado !!!! 

SELECT NULL -- Representação correta de NULO é o marcador NULL sem aspas simples



-- Posso comparar o valor NULL com outro valor NULL. Eles serão idênticos? 

Select Nome 
  From empregado
 Where 1 = 1
 
Select Nome  
  From empregado
 Where null = null
 

-- Neste caso não existe comparação de um valor NULL com outro valor NULL,
-- Não é realizado a comparação de um valor desconhecido 
-- com outro valor desconhecido.


Select * 
  From Empregado
 Where Salario = Comissao 
 

/*
*/

use Fundamentostsql
go

Select RazaoSocial, Cidade, Regiao, Pais 
  From vendas.cliente
 Where Regiao = 'SP'

-- Retornar 6 linhas de 91 linhas da tabela.

Select RazaoSocial, Cidade, Regiao, Pais 
  From Vendas.Cliente
 Where Regiao <> 'SP'




-- Retorna 25 linhas de 91 linhas da tabela. 
-- Mas se temos 6 linhas igual a SP, se o predicado é Regiao <> 'SP', o resultado 
-- esperado seria  85 linhas e não 25. 

/*
Para expressar a ausência de dados em predicados da clausula WHERE,
voce deve utilizar o operador IS NULL 
*/

Select RazaoSocial, Cidade, Regiao, Pais 
  From Vendas.Cliente
 Where Regiao IS NULL 

Select RazaoSocial, Cidade, Regiao, Pais 
  From Vendas.Cliente
 Where Regiao IS NOT NULL 


-- Aqui temos um ponto de atenção.
/*
E se voce precisa saber quem tem a região diferente de SP 
*/

Select RazaoSocial, Cidade, Regiao, Pais 
  From Vendas.Cliente
 Where Regiao IS NULL or Regiao <> 'SP'
 Order by Regiao 
 


-- Comportamento de NULL para Group BY e para Order by !!1

/*
Se o conceito de NULL comparado com NULL não tem efeito, 
pois os valores são desconhecidos e voce não consegue comparar 
valores desconhecidos, o que deve acontecer para 
agrupar ou ordenar valores nulos?
*/

Select Regiao , 
       COUNT(*) as Quantidade 
  From Vendas.Cliente
 Group by Regiao 


 Select Regiao,Cidade,  Pais 
  From Vendas.Cliente
 Order by Regiao desc
 

-- Veja que para o GROUP BY e o ORDER BY, os valores 
-- NULL são considerados iguais???

-- No GROUP BY ele foram agrupados, como se todos os NULL em um único
-- grupo como se fossem iguais
-- e no ORDER BY eles foram classificados antes dos valores presentes. 



 /*
 Na fase de GROUP BY, colunas com valores NULL são ignoradados 
 em funções de agregação. 
 */

use FundamentosTSQL
go

Select *
  From Vendas.ItensPedido

Select *
  From Vendas.ItensPedido
 Where iIDPedido = 10248 
  
Select iIDPedido, 
       COUNT(*) as QuantidadeItens,
       SUM(PrecoUnitario) as TotalVendas , 
   	   SUM(Desconto) as Descontos
  from Vendas.ItensPedido
  group by iIDPedido


/*
Um erro muito comum no desenvolvimento.

Definir uma coluna com valor NULL e definir que 
zero ou espaço em branco tambem são valores ausentes.

*/
use DBExemplo
go 
insert into Empregado (id, Nome, Salario, Comissao) 
               values (4,'Joaquim da Silva' , 1000.00, 75.00),
                      (5,'Miguel da Silva'  ,    NULL, NULL),
	                  (6,'Rodolfo da Silva' ,      0 ,    0)

Select * from Empregado 

-- Pedem um relatório que aponte os empregados que não
-- tem salário 


Select * from Empregado
Where Salario = 0

Select * from Empregado
Where Salario is null 


Select * from Empregado
Where Salario is null or Salario = 0



