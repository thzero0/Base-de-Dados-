INSERT INTO Oferecimento (
    CodigoDisciplina,
    NomeProf,
    SobrenomeProf,
    TelefoneProf,
    InicioPeriodoLetivo,
    TipoPeriodoLetivo,
    MaxAlunos,
    NomeUnidadeSala,
    NumeroSala
)
SELECT
    d.Codigo,
    p.NomeProf,
    p.SobrenomeProf,
    p.TelefoneProf,
    -- Pegar data aleatoria de 2020-01-01 em ate 5 anos depois
    (DATE '2020-01-01' + (floor(random()*1825)::int) * INTERVAL '1 day')::date,
    -- pegar tipo aleatorio
    (ARRAY['Semestral','Anual'])[floor(random()*2)+1]::t_tipoPeriodoLetivo,
    (floor(random()*100 + 10))::int,
    -- pra nao dar conflito com a SalaDeAula
    NULL,
    NULL
-- Pegar uma disciplina e um professor aleatorio
FROM
    generate_series(1,1000000) AS gs(i)
    CROSS JOIN LATERAL (
      SELECT Codigo
      FROM Disciplina
      ORDER BY random()
      LIMIT 1
    ) AS d
    CROSS JOIN LATERAL (
      SELECT NomeProf, SobrenomeProf, TelefoneProf
      FROM Professor
      ORDER BY random()
      LIMIT 1
    ) AS p
ON CONFLICT  DO NOTHING
;