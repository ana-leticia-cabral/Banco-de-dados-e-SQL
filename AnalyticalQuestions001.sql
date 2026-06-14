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






/* MYSQL - Número de remessas por mês - Amazon

Escreva uma consulta que calculará o número de remessas por mês.

A chave exclusiva para uma remessa é uma combinação de shipment_id e sub_id.

Produza o year_month no formato YYYY-MM e o número de remessas naquele mês.

*/

SELECT
    DATE_FORMAT(shipment_date, '%Y-%m') AS yearmonth,
    COUNT(DISTINCT shipment_id, sub_id) AS number_shipments
FROM
    amazon_shipment
GROUP BY
    yearmonth
ORDER BY
    yearmonth





/* MYSQL - Altos rendimentos em departamentos de apoio - Uber/Spotify/Amazon

A equipe de RH está revisando pacotes de remuneração para funcionários em funções de suporte.

Eles querem identificar pessoas com altos rendimentos nos departamentos de RH e Administração para um estudo de avaliação comparativa salarial.

Encontre todos os funcionários que ganham mais de US$ 80.000 e trabalham no departamento de RH ou administrativo.

Retorne first_name, last_name, department, salary.

*/

SELECT COUNT(salary)
FROM techcorp_workforce
WHERE salary > 80000; # 26

SELECT COUNT(department)
FROM techcorp_workforce
WHERE department = 'HR'; # 10

SELECT COUNT(department)
FROM techcorp_workforce
WHERE department = 'Admin'; # 8

SELECT 
    first_name,
    last_name,
    department,
    salary
FROM 
    techcorp_workforce
WHERE
    (department = 'HR' OR department = 'Admin')
    AND salary > 80000;