/*
PREDICADO LIKE e Introdução a pesquisa Textual 
*/

-- Predicado LIKE

/*
Avalia se uma expressão do tipo caracter corresponde a um padrão
de comportamento de dados específico.
*/

-- Formato 
-- Expressão LIKE '<Padrão>'

/*
O padrão pode conter os caracter normais e os chamados curingas. 

Utilizado como predicado no WHERE, HAVING, CASE ou qualquer outra
instrução que faça uma validação de uma expressão lógica.

O predicado LIKE é igual a uma expressão de comparação. 

Então podemos aplicar junto com outras expressões de comparação e operadores lógicos. 
*/

USE FundamentosTSQL
go


Select Contato, Cargo  
  From Vendas.Cliente 
 Where Cargo like 'Owner'
 

-- Padrões do LIKE 

----------------------------------------------------------------------------------------------------------------
-- % (Porcentagem) -- Se o padrão está contido no começo, 
-- no meio ou no fim da expressão

-- No Começo : Padrão%

Select * 
  from Vendas.Cliente 
 where Contato like 'Smith%'

 Select * 
  from Vendas.Cliente 
 where Contato like '% John'

 Select * 
  from Vendas.Cliente 
 where Contato like '%Jr.%'

--------------------------------------------------------------------------------------------------
-- _ (Sublinhado) -- Representa um único caracter. Quando utilizado em uma posição
--  do padrão, ele considera qualquer caracter. 


-- Mostra os clientes com o telefone com o terceiro caracter "." (Ponto) 
-- Então os dois primeiros caracters não importa. Pode ser qualquer caracter. 

Select iIDCliente, RazaoSocial, Contato , Telefone 
  From Vendas.Cliente  
 Where Telefone like '__.%'
 
  
Select iIDCliente, RazaoSocial, Contato , Telefone  
  From Vendas.Cliente  
 Where Substring(Telefone,3,1) = '.'



--------------------------------------------------------------------------------------------------
-- Esse padrão é uma extensão do T-SQL e não é um padrão ANSI.

-- [] (Dois colchetes) -- Representa um único caracter. Quando utilizado em uma posição
--  do padrão, ele considera os caracteres dentro dos colchetes. 

-- Neste exemplo, estamos avaliando o padrão de telefone que segue a 
-- máscara (9) 999-9999, onde queremos avaliar o valor que está entre
-- parêntesis.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([0123456789])%'

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([15])%'


  
--------------------------------------------------------------------------------------------------
-- Esse padrão é uma extensão do T-SQL e não é um padrão ANSI.

-- [a-z] (Dois colchetes) -- Representa um único caracter. Quando utilizado em uma posição
--  do padrão, ele considera dentro da faixa "de" "até" . 

-- Neste exemplo, estamos avaliando o padrão de telefone que segue a 
-- máscara (9) 999-9999, onde queremos avaliar o valor que está entre
-- parêntesis de 0 (zero) até 5.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([0-5])%'

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([012345])%'

--------------------------------------------------------------------------------------------------
-- Esse padrão é uma extensão do T-SQL e não é um padrão ANSI.

-- [^a-z] (Dois colchetes) -- Representa um único caracter. Quando utilizado em uma posição
--  do padrão, ele nega a lista de caracter ou o intervalo "de" "até" . 

-- Neste exemplo, estamos avaliando o padrão de telefone que segue a 
-- máscara (9) 999-9999, onde queremos avaliar o valor que NÃO está entre
-- parêntesis de 0 (zero) até 5.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([^0-5])%'

-- Mas quando voce faz a negação do lado externo
-- ao padrão, o resultado é difentes. 
-- Cuidado !!!

Select iIDCliente, RazaoSocial, Contato , Telefone , *
  from Vendas.Cliente 
  where Telefone not like '([0-5])%'




