/*
PREDICADO LIKE e Introdu��o a pesquisa Textual 
*/

-- Predicado LIKE

/*
Avalia se uma express�o do tipo caracter corresponde a um padr�o
de comportamento de dados espec�fico.
*/

-- Formato 
-- Express�o LIKE '<Padr�o>'

/*
O padr�o pode conter os caracter normais e os chamados curingas. 

Utilizado como predicado no WHERE, HAVING, CASE ou qualquer outra
instru��o que fa�a uma valida��o de uma express�o l�gica.

O predicado LIKE � igual a uma express�o de compara��o. 

Ent�o podemos aplicar junto com outras express�es de compara��o e operadores l�gicos. 
*/

USE FundamentosTSQL
go


Select Contato, Cargo  
  From Vendas.Cliente 
 Where Cargo like 'Owner'
 

-- Padr�es do LIKE 

----------------------------------------------------------------------------------------------------------------
-- % (Porcentagem) -- Se o padr�o est� contido no come�o, 
-- no meio ou no fim da express�o

-- No Come�o : Padr�o%

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
-- _ (Sublinhado) -- Representa um �nico caracter. Quando utilizado em uma posi��o
--  do padr�o, ele considera qualquer caracter. 


-- Mostra os clientes com o telefone com o terceiro caracter "." (Ponto) 
-- Ent�o os dois primeiros caracters n�o importa. Pode ser qualquer caracter. 

Select iIDCliente, RazaoSocial, Contato , Telefone 
  From Vendas.Cliente  
 Where Telefone like '__.%'
 
  
Select iIDCliente, RazaoSocial, Contato , Telefone  
  From Vendas.Cliente  
 Where Substring(Telefone,3,1) = '.'



--------------------------------------------------------------------------------------------------
-- Esse padr�o � uma extens�o do T-SQL e n�o � um padr�o ANSI.

-- [] (Dois colchetes) -- Representa um �nico caracter. Quando utilizado em uma posi��o
--  do padr�o, ele considera os caracteres dentro dos colchetes. 

-- Neste exemplo, estamos avaliando o padr�o de telefone que segue a 
-- m�scara (9) 999-9999, onde queremos avaliar o valor que est� entre
-- par�ntesis.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([0123456789])%'

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([15])%'


  
--------------------------------------------------------------------------------------------------
-- Esse padr�o � uma extens�o do T-SQL e n�o � um padr�o ANSI.

-- [a-z] (Dois colchetes) -- Representa um �nico caracter. Quando utilizado em uma posi��o
--  do padr�o, ele considera dentro da faixa "de" "at�" . 

-- Neste exemplo, estamos avaliando o padr�o de telefone que segue a 
-- m�scara (9) 999-9999, onde queremos avaliar o valor que est� entre
-- par�ntesis de 0 (zero) at� 5.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([0-5])%'

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([012345])%'

--------------------------------------------------------------------------------------------------
-- Esse padr�o � uma extens�o do T-SQL e n�o � um padr�o ANSI.

-- [^a-z] (Dois colchetes) -- Representa um �nico caracter. Quando utilizado em uma posi��o
--  do padr�o, ele nega a lista de caracter ou o intervalo "de" "at�" . 

-- Neste exemplo, estamos avaliando o padr�o de telefone que segue a 
-- m�scara (9) 999-9999, onde queremos avaliar o valor que N�O est� entre
-- par�ntesis de 0 (zero) at� 5.

Select iIDCliente, RazaoSocial, Contato , Telefone 
  from Vendas.Cliente 
  where Telefone like '([^0-5])%'

-- Mas quando voce faz a nega��o do lado externo
-- ao padr�o, o resultado � difentes. 
-- Cuidado !!!

Select iIDCliente, RazaoSocial, Contato , Telefone , *
  from Vendas.Cliente 
  where Telefone not like '([0-5])%'




