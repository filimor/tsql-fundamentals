/*
Criando um banco de dados exemplo
*/

if db_id('DBExemplo') is null 
   
   Create Database DBExemplo

/*
1. Forma mais simplista para criar um 
   banco de dados
2. Por padrão, será criado o schema DBO e 
   todos os objetos criados serão
   incluidos neste esquema.
*/