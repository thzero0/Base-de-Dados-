/*
Listar todas as salas de aula que um professor já utilizou
ao longo das disciplinas que ofereceu.
*/


-- VIEW
/*
Listar todos os alunos com suas respectivas médias escolares,
sendo a média escolar a média das notas de todas as disciplinas
que o aluno já se matriculou.
*/
SELECT 
    a.Nome, 
    a.Sobrenome, 
    a.Telefone, 
    AVG(md.mediaDisciplina) as Media, 
    Count(*) as NroDisciplinasCursadas
FROM ALUNO a
    LEFT JOIN Matricula m 
        ON a.Nome = m.Nome
        AND a.Sobrenome = m.Sobrenome
        AND a.Telefone = m.Telefone
    LEFT JOIN (
        SELECT 
            n.NomeAluno, n.SobrenomeAluno, n.TelefoneAluno, n.CodigoDisciplina, 
            n.NomeProf, n.SobrenomeProf, n.TelefoneProf, n.InicioPeriodoLetivo, 
            AVG(n.Nota) as mediaDisciplina
        FROM Notas n 
        GROUP BY 
            n.NomeAluno, n.SobrenomeAluno, n.TelefoneAluno, n.CodigoDisciplina, 
            n.NomeProf, n.SobrenomeProf, n.TelefoneProf, n.InicioPeriodoLetivo
    ) as MediaAlunoNessaDisciplina md
    ON m.NomeAluno = md.NomeAluno
    AND m.SobrenomeAluno = md.SobrenomeAluno
    AND m.TelefoneAluno = md.TelefoneAluno
    AND m.CodigoDisciplina = md.CodigoDisciplina
    AND m.NomeProf = md.NomeProf
    AND m.SobrenomeProf = md.SobrenomeProf
    AND m.TelefoneProf = md.TelefoneProf
    AND m.InicioPeriodoLetivo = md.InicioPeriodoLetivo
GROUP BY a.Nome, a.Sobrenome, a.Telefone

-- CONSULTA USANDO A VIEW DE CIMA
/*
Listar todos os alunos que possuem média < 5.0
*/



/*
Listar todas as disciplinas que um professor já lecionou 
*/
SELECT 
    p.NomeProf, 
    p.SobrenomeProf, 
    d.Codigo, 
    d.Nome, 
    Count(*) as nroVezesMinistradas
FROM Professor p 
    JOIN Oferecimento o   
        ON o.NomeProf = p.NomeProf
        AND o.SobrenomeProf = p.SobrenomeProf
        AND o.TelefoneProf = p.TelefoneProf 
    JOIN Disciplina d
        ON d.Codigo = o.CodigoDisciplina
WHERE 
    p.NomeProf = '?'
    AND p.SobrenomeProf = '?'
    AND p.TelefoneProf = '?'
GROUP BY p.NomeProf, p.SobrenomeProf, d.Codigo, d.Nome 


-- VIEW
/*
Calcular a média das avaliações para cada um dos oferecimentos 
já realizados.
*/
SELECT 
    o.CodigoDisciplina, 
    o.NomeProf, 
    o.SobrenomeProf, 
    o.TelefoneProf, 
    o.InicioPeriodoLetivo, 
    o.TipoPeriodoLetivo, 
    o.MaxAlunos, 
    o.NomeUnidadeSala, 
    o.NumeroSala,
    AVG(a.NotaDidatica) as mediaDidatica,
    AVG(a.NotaMaterial) as mediaMaterial,
    AVG(a.RelevanciaConteudo) as mediaRelevanciaConteudo,
    AVG(a.InfraestruturaSala) as mediaInfraestruturaSala,
    Count(*) as nroAvaliacoes
FROM Oferecimento o 
    LEFT JOIN Avaliacao a
        ON o.CodigoDisciplina = a.CodigoDisciplina
        AND o.NomeProf = a.NomeProf
        AND o.SobrenomeProf = a.SobrenomeProf
        AND o.TelefoneProf = a.TelefoneProf
        AND o.InicioPeriodoLetivo = a.InicioPeriodoLetivo
GROUP BY 
    o.CodigoDisciplina, o.NomeProf, o.SobrenomeProf, o.TelefoneProf, o.InicioPeriodoLetivo, 
    o.TipoPeriodoLetivo, o.MaxAlunos, o.NomeUnidadeSala, o.NumeroSala

-- CONSULTA USANDO A VIEW DE CIMA
/*
Calcular a média de didática de um professor ao longo de
todas as disciplinas que ele já lecionou.
*/




-- VIEW
/*
Mostrar todos os departamentos, com a quantidade de cursos ligados
a ele, junto com as informações de contato do professor chefe.
*/
SELECT 
    d.Codigo, 
    d.Nome, 
    d.NomeProf, 
    d.SobrenomeProf, 
    d.TelefoneProf, 
    p.Email, 
    p.CEP, 
    p.Numero, 
    p.Especializacao, 
    p.Titulacao,
    Count(c.CodigoUnico)
FROM Departamento d 
    LEFT JOIN Curso c ON c.CodigoDepartamento = d.Codigo
    LEFT JOIN Professor p
        ON p.NomeProf = d.NomeProf,
        AND p.SobrenomeProf = d.SobrenomeProf,
        AND p.TelefoneProf = d.TelefoneProf 
GROUP BY d.Codigo, d.Nome, d.NomeProf, d.SobrenomeProf, d.TelefoneProf, p.Email, p.CEP, p.Numero, p.Especializacao, p.Titulacao


-- CONSULTA USANDO A VIEW DE CIMA
/*
Mostrar os departamentos com mais cursos em ordem decrescente
*/


/*
Fazer uma contagem de porcentagem de alunos que cancelam a matrícula por curso
*/
SELECT 
    c.CodigoUnico, 
    c.Nome, 
    Count(*) as qtdMatriculas,
    (SUM(CASE WHEN m.StatusMatricula = 'cancelada' THEN 1 else 0)/Count(*)) as porcentagemMatriculasCanceladas
FROM Curso c 
    LEFT JOIN ComposicaoCurso cc ON cc.CodigoUnicoCurso = c.CodigoUnico 
    LEFT JOIN Oferecimento o ON o.CodigoDisciplina = cc.CodigoDisciplina
    LEFT JOIN Matricula m 
        ON m.CodigoDisciplina = o.CodigoDisciplina
        AND m.NomeProf = o.NomeProf 
        AND m.SobrenomeProf = o.SobrenomeProf
        AND m.TelefoneProf = o.TelefoneProf
        AND m.InicioPeriodoLetivo = o.InicioPeriodoLetivo
GROUP BY c.CodigoUnico, c.Nome









