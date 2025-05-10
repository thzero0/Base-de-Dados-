SELECT * 
FROM propriedade;


SELECT p.tipo, Count(*) 
FROM propriedade p 
GROUP BY p.tipo;


SELECT L.cidade, Count(*) 
FROM localizacao L JOIN propriedade p 
USING (cep) 
GROUP BY cidade;
ORDER BY count DESC

SELECT r.id_reserva, r.id_propriedade, r.id_usuario, (r.data_check_out - r.data_check_in) as dias_locados, u2.nome as nome_prop, u1.nome as nome_hosp, ROUND(r.preco_total / (r.data_check_out - r.data_check_in), 2) as preco_diaria 
FROM reserva r  
	JOIN usuario u1 ON r.id_usuario = u1.id_usuario
	JOIN propriedade p ON r.id_propriedade = p.id_propriedade
	JOIN usuario u2 ON p.id_locator = u2.id_usuario
WHERE (r.status = 'Confirmada') and (r.data_reserva >= '2025-04-25');


SELECT *
FROM usuario u
WHERE u.tipo = 'Ambos';


SELECT u.nome, L.cidade, COUNT(p.id_propriedade) AS total_prop, COUNT(r.id_reserva) AS total_locacoes
	
FROM usuario u
JOIN localizacao L ON u.cep = L.cep
JOIN propriedade p ON p.id_locator = u.id_usuario
JOIN reserva r ON r.id_propriedade = p.id_propriedade

GROUP BY (u.id_usuario, L.cidade)
HAVING (COUNT(r.id_reserva) >= 5);


SELECT 
 EXTRACT(MONTH from data_reserva), 
 ROUND(AVG(Coalesce(preco_total/(r.data_check_out - r.data_check_in), 0)), 2) as media_preco_total, 
 ROUND(AVG(CASE WHEN r.status = 'Confirmada' AND preco_total IS NOT NULL THEN preco_total/(r.data_check_out - r.data_check_in) ELSE NULL END), 2) as media_preco_confirmadas
FROM 
  reserva r
GROUP BY 
  EXTRACT(MONTH FROM data_reserva);


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


SELECT DISTINCT u1.nome, u1.sobrenome, u1.data_nascimento, u1.tipo
FROM usuario u1
WHERE (u1.tipo = 'Ambos' OR u1.tipo = 'Hospede') 

	AND
	u1.data_nascimento > ALL (
    SELECT u2.data_nascimento
    FROM usuario u2
    WHERE (u2.tipo = 'Ambos' OR u2.tipo = 'Locator') and (u1.id_usuario != u2.id_usuario)
    );

