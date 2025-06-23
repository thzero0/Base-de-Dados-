/*
1 - INDEX para otimizar buscas em oferecimentos a partir
de quando ele foi lecionado:
    - (InicioPeriodoLetivo, TipoPeriodoLetivo)
*/
CREATE INDEX OferPorPeriodoLetivo ON Oferecimento USING BRIN (InicioPeriodoLetivo, TipoPeriodoLetivo);
-- DROP INDEX IF EXISTS OferPorPeriodoLetivo;

-- Consulta para validar o INDEX 1
EXPLAIN ANALYZE
SELECT *
    FROM Oferecimento o
    WHERE 
        o.InicioPeriodoLetivo BETWEEN '2024-01-01' AND '2025-01-01'
        AND o.TipoPeriodoLetivo = 'Semestral';






/*
2 - INDEX para otimizar as buscas em matrículas e ver quais
os status de seus pagamentos
    - (StatusMatricula, StatusPagamento)
*/
CREATE INDEX StatusMatricula ON Matricula USING HASH (StatusPagamento);
-- DROP INDEX IF EXISTS StatusMatricula;

-- Consulta para validar o INDEX 2
EXPLAIN ANALYZE
SELECT m.NomeAluno, m.SobrenomeAluno, m.TelefoneAluno, m.CodigoDisciplina, m.DataMatricula, m.StatusMatricula, m.StatusPagamento
    FROM Matricula m 
    WHERE 
        m.StatusPagamento = 'pendente';





/*
3 - INDEX para otimizar o JOIN entre os oferecimentos e os 
professores, já que é comum querer saber disciplinas que 
um professor lecionou
    - FK de Oferecimento (NomeProf, SobrenomeProf, TelefoneProf)
*/
CREATE INDEX OferecimentoJoinProfessor ON Oferecimento (NomeProf, SobrenomeProf, TelefoneProf) ;
-- DROP INDEX IF EXISTS OferecimentoJoinProfessor;

-- Consulta para validar o INDEX 3
EXPLAIN ANALYZE
SELECT o.NomeProf, o.SobrenomeProf, o.TelefoneProf, p.Titulacao, p.Especializacao
    FROM Oferecimento o 
        JOIN Professor p 
            ON o.NomeProf = p.NomeProf 
            AND o.SobrenomeProf = p.SobrenomeProf
            AND o.TelefoneProf = p.TelefoneProf;