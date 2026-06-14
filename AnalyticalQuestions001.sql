/* MYSQL - Sistema de recomendação - Facebook

Você recebe a lista de amigos do Facebook e a lista de páginas do Facebook que os usuários seguem.

Sua tarefa é criar um novo sistema de recomendação para o Facebook.

Para cada usuário do Facebook, encontre as páginas que esse usuário não segue, mas pelo menos
um de seus amigos o faz.

Produza o ID do usuário e o ID da página que deve ser recomendado a este usuário.

*/

WITH list_friends_pages AS (
    SELECT 
        f.user_id,       
        p.page_id        
    FROM
        users_friends AS f
    INNER JOIN
        users_pages AS p
        ON f.friend_id = p.user_id
)

SELECT DISTINCT
    lfp.user_id,
    lfp.page_id
FROM
    list_friends_pages AS lfp
LEFT JOIN
    users_pages AS up
    ON lfp.user_id = up.user_id
    AND lfp.page_id = up.page_id
WHERE
    up.page_id IS NULL;






/* MYSQL - Encontre todas as postagens às quais reagiram com coração - Facebook

Encontre todas as postagens às quais reagiram com coração. 

Para essas postagens, exiba todas as colunas da tabela facebook_posts

*/

SELECT DISTINCT
    p.post_id,
    p.poster,
    p.post_text,
    p.post_keywords,
    p.post_date
FROM
    facebook_posts p
INNER JOIN
    facebook_reactions r
    ON p.post_id = r.post_id
WHERE
    r.reaction = 'heart'







/* MYSQL - Encontrando registros atualizados - Microsoft

Temos uma tabela com os funcionários e seus salários.

No entanto, alguns dos registros são antigos e contêm informações salariais desatualizadas.

Como não há registro de data e hora, suponha que o salário não diminua com o tempo.

Você pode considerar que o salário atual de um funcionário é o maior valor salarial entre seus registros.

Se vários registros compartilharem o mesmo salário máximo, devolva qualquer um deles.

Exiba seu ID, nome, sobrenome, ID do departamento e salário atual.

Ordene sua lista por ID de funcionário em ordem crescente.


*/

WITH dados_atualizados AS(
SELECT
    id,
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER(
    PARTITION BY id
    ORDER BY salary DESC) AS current_salary
FROM 
    ms_employee_salary
)


SELECT
   id,
   first_name,
   last_name,
   department_id,
   salary
FROM 
    dados_atualizados
WHERE 
    current_salary = 1
ORDER BY
    id ASC





/* MYSQL - Custo total dos pedidos - Amazon/Etsy

Encontre o custo total dos pedidos de cada cliente.

Insira o ID do cliente, o primeiro nome e o custo total do pedido.

Ordene os registros pelo primeiro nome do cliente em ordem alfabética.


*/

SELECT
    c.id,
    c.first_name,
    SUM(o.total_order_cost)
FROM
    customers c
INNER JOIN
    orders o
    ON c.id = o.cust_id
GROUP BY
    c.id,
    c.first_name
ORDER BY
    c.first_name ASC





/* MYSQL - Trabalhadores com os salários mais altos - Amazon/DoorDash

A gerência quer analisar apenas funcionários com cargos oficiais.

Encontre os cargos dos funcionários com o salário mais alto.

Se vários funcionários tiverem o mesmo salário mais alto, inclua todos os seus cargos.


*/

WITH cargos_oficiais AS (
    SELECT 
        t.worker_title,
        w.salary
    FROM
        title t
    INNER JOIN
        worker w
        ON t.worker_ref_id = w.worker_id
)
SELECT
    worker_title
FROM
    cargos_oficiais
WHERE
    salary IN (SELECT MAX(salary) FROM cargos_oficiais);




/* MYSQL - Usuários exclusivos por cliente por mês - Microsoft/Apple/Dell

Escreva uma consulta que retorne o número de usuários únicos por cliente para cada mês. 

Suponha que todos os eventos ocorram no mesmo ano, então o mês precisa estar na saída como um número de 1 a 12.

*/

SELECT
    client_id,
    MONTH(time_id) AS month,
    COUNT(DISTINCT user_id) AS users_num
    
FROM
    fact_events
GROUP BY
    client_id,
    month
ORDER BY
    client_id;