
/*
  Consultas SQL para o projeto de banco de dados
  Grupo: 14
  Alunos:

  -Clara Ernesto de Carvalho - 14559479
  -Gabriel Barbosa dos Santos - 14613991
  -Renan Parpinelli Scarpin - 14712188
  -Thiago Zero Araujo - 11814183

*/

-- 3.3 - Mostre o conteúdo feito para a relação que implementa o conceito de Propriedades do sistema:

-- 3.3.a - Mostre a relação inteira.
SELECT * 
  FROM propriedade; 

--3.3.b - Mostre quantas Propriedades existem de cada categoria (casa inteira, quarto individual, etc.)
SELECT p.tipo, Count(*) 
  FROM propriedade p 
  GROUP BY p.tipo;

--3.3.c - Mostre quantas Propriedades existem de cada Cidade.
SELECT L.cidade, Count(*) AS total
  FROM localizacao L JOIN propriedade p 
  USING (cep) 
  GROUP BY cidade
  ORDER BY total DESC;


-- 3.4 - Mostre as locações que possuem confirmação com data de entrada a partir de 24/04/2025. Indique, para cada uma:
--     - Todos os atributos-chave das relações envolvidas
--     - O total de dias locado
--     - O nome do proprietário e do hóspede
--     - O valor da diária

SELECT r.id_reserva, r.id_propriedade, r.id_usuario, (r.data_check_out - r.data_check_in) as dias_locados, u2.nome as nome_prop, u1.nome as nome_hosp, ROUND(r.preco_total / (r.data_check_out - r.data_check_in), 2) as preco_diaria 
  FROM reserva r  
    JOIN usuario u1 ON r.id_usuario = u1.id_usuario
    JOIN propriedade p ON r.id_propriedade = p.id_propriedade
    JOIN usuario u2 ON p.id_locator = u2.id_usuario
  WHERE (r.status = 'Confirmada') and (r.data_reserva >= '2025-04-25');



-- 3.5 - Mostre:

-- 3.5.a - Quais os usuários que são tanto anfitriões quanto locatários
SELECT *
  FROM usuario u
  WHERE u.tipo = 'Ambos';

-- 3.5.b - Quais anfitriões tiveram pelo menos 5 locações, mostrando seu nome, sua cidade e quantidade de imóveis dos quais ele é dono, e o total de locações
SELECT u.nome, L.cidade, COUNT(DISTINCT p.id_propriedade) AS total_prop, COUNT(r.id_reserva) AS total_locacoes
  FROM usuario u
  JOIN localizacao L ON u.cep = L.cep
  JOIN propriedade p ON p.id_locator = u.id_usuario
  LEFT JOIN reserva r ON r.id_propriedade = p.id_propriedade

  GROUP BY (u.id_usuario, L.cidade)
  HAVING (COUNT(r.id_reserva) >= 5);


-- 3.5.c - O valor médio das diárias de todas as locações que foram feitas e das que foram confirmadas em cada mês para o qual exista alguma locação na base
SELECT 
  EXTRACT(MONTH from data_reserva), 
  ROUND(AVG(Coalesce(preco_total/(r.data_check_out - r.data_check_in), 0)), 2) as media_preco_total, 
  ROUND(AVG(CASE WHEN r.status = 'Confirmada' AND preco_total IS NOT NULL THEN preco_total/(r.data_check_out - r.data_check_in) ELSE NULL END), 2) as media_preco_confirmadas
  FROM 
    reserva r
  GROUP BY 
    EXTRACT(MONTH FROM data_reserva);

-- 3.5.d - Os locatários que são mais jovens do que algum anfitrião
SELECT DISTINCT u1.tipo, u1.nome
  FROM usuario u1
  WHERE (u1.tipo = 'Ambos' OR u1.tipo = 'Hospede') 
    AND
    u1.data_nascimento > ANY (
      SELECT u2.data_nascimento
      FROM usuario u2
      WHERE u2.id_usuario IN (
          SELECT DISTINCT p.id_locator
          FROM propriedade p
      )
  );

-- 3.5.e - Os locatários que são mais jovens do que todos os anfitriões
SELECT DISTINCT u1.nome, u1.sobrenome, u1.data_nascimento, u1.tipo
  FROM usuario u1
  WHERE (u1.tipo = 'Ambos' OR u1.tipo = 'Hospede') 
    AND
    u1.data_nascimento > ALL (
      SELECT u2.data_nascimento
      FROM usuario u2
      WHERE (u2.tipo = 'Ambos' OR u2.tipo = 'Locator') and (u1.id_usuario != u2.id_usuario)
      );

