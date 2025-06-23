-- Rode as duas linhas abaixo para desativar busca por index
SET enable_seqscan = off;
SET enable_bitmapscan = off;
-- Rode as duas linhas abaixo para ativar busca por index
SET enable_seqscan = on;
SET enable_bitmapscan = on;
-- Consulta para validar o INDEX 1
DROP INDEX IF EXISTS OfferPorPeriodoLetivo;
EXPLAIN ANALYZE
SELECT *
    FROM Oferecimento o
    WHERE 
        o.InicioPeriodoLetivo BETWEEN '2024-01-01' AND '2025-01-01';

-- Consulta para validar o INDEX 2
EXPLAIN ANALYZE
SELECT m.NomeAluno, m.SobrenomeAluno, m.TelefoneAluno, m.CodigoDisciplina, m.DataMatricula, m.StatusMatricula, m.StatusPagamento
    FROM Matricula m 
    WHERE 
        m.StatusPagamento = 'pendente';

-- Consulta para validar o INDEX 3
EXPLAIN ANALYZE
SELECT o.NomeProf, o.SobrenomeProf, o.TelefoneProf, p.Titulacao, p.Especializacao
    FROM Oferecimento o 
        JOIN Professor p 
            ON o.NomeProf = p.NomeProf 
            AND o.SobrenomeProf = p.SobrenomeProf
            AND o.TelefoneProf = p.TelefoneProf;