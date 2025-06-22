/*
-- VIEW
Mostrar todos os departamentos, com a quantidade de cursos ligados
a ele, junto com as informações de contato do professor chefe.
*/
CREATE VIEW InformacoesDepartamento as 
    SELECT 
        d.Codigo, 
        d.Nome, 
        d.NomeProfChefe, 
        d.SobrenomeProfChefe, 
        d.TelefoneProfChefe, 
        p.Email as EmailChefe, 
        p.CEP as CEPchefe, 
        p.Numero as NumeroCasaChefe, 
        p.Especializacao as EspecilizacaoChefe, 
        p.Titulacao as TitulacaoChefe,
        Count(c.CodigoUnico) as QtdCursos

            FROM Departamento d 
                LEFT JOIN Curso c ON c.CodigoDepartamento = d.Codigo
                LEFT JOIN Professor p
                    ON p.NomeProf = d.NomeProfChefe,
                    AND p.SobrenomeProf = d.SobrenomeProfChefe,
                    AND p.TelefoneProf = d.TelefoneProfChefe 
            GROUP BY d.Codigo, d.Nome, d.NomeProfChefe, d.SobrenomeProfChefe, d.TelefoneProfChefe, p.Email, p.CEP, p.Numero, p.Especializacao, p.Titulacao;

/*
-- CONSULTA USANDO A VIEW DE CIMA
Mostrar os departamentos com mais cursos em ordem decrescente
*/
SELECT i.Codigo, i.Nome, i.QtdCursos
    FROM InformacoesDepartamento i
    ORDER BY i.QtdCursos DESC; 







/*
-- VIEW
Listar todos os alunos com suas respectivas médias escolares,
sendo a média escolar a média das notas de todas as disciplinas
que o aluno já se matriculou.
*/
CREATE VIEW MediasEscolares as 
    SELECT 
        a.NomeAluno, 
        a.SobrenomeAluno, 
        a.TelefoneAluno, 
        AVG(md.MediaDisciplina) as Media, 
        Count(*) as NroDisciplinasCursadas

        FROM ALUNO a
            LEFT JOIN Matricula m 
                ON a.NomeAluno = m.NomeAluno
                AND a.SobrenomeAluno = m.SobrenomeAluno
                AND a.TelefoneAluno = m.TelefoneAluno
            LEFT JOIN (
                SELECT 
                    n.NomeAluno, n.SobrenomeAluno, n.TelefoneAluno, n.CodigoDisciplina, 
                    n.NomeProf, n.SobrenomeProf, n.TelefoneProf, n.InicioPeriodoLetivo, 
                    AVG(n.Nota) as MediaDisciplina
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
        GROUP BY a.Nome, a.Sobrenome, a.Telefone;

/*
-- CONSULTA USANDO A VIEW DE CIMA
Listar todos os alunos que possuem média < 5.0
*/
SELECT me.NomeAluno, me.SobrenomeAluno, me.TelefoneAluno, me.Media
    FROM MediasEscolares me 
    WHERE 
        me.Media < 5.0
        AND me.NroDisciplinasCursadas >= 1;









-- VIEW
/*
Calcular a média das avaliações para cada um dos oferecimentos 
já realizados.
*/
CREATE VIEW MediaAvaliacoesOferecimentos as 
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
        AVG(a.NotaDidatica) as MediaDidatica,
        AVG(a.NotaMaterial) as MediaMaterial,
        AVG(a.RelevanciaConteudo) as MediaRelevanciaConteudo,
        AVG(a.InfraestruturaSala) as MediaInfraestruturaSala,
        Count(*) as NroAvaliacoes
    
        FROM Oferecimento o 
            LEFT JOIN Avaliacao a
                ON o.CodigoDisciplina = a.CodigoDisciplina
                AND o.NomeProf = a.NomeProf
                AND o.SobrenomeProf = a.SobrenomeProf
                AND o.TelefoneProf = a.TelefoneProf
                AND o.InicioPeriodoLetivo = a.InicioPeriodoLetivo
        GROUP BY 
            o.CodigoDisciplina, o.NomeProf, o.SobrenomeProf, o.TelefoneProf, o.InicioPeriodoLetivo, 
            o.TipoPeriodoLetivo, o.MaxAlunos, o.NomeUnidadeSala, o.NumeroSala;

/*
-- CONSULTA USANDO A VIEW DE CIMA
Calcular a média de didática de um professor ao longo de
todas as disciplinas que ele já lecionou.
*/
SELECT p.NomeProf, p.SobrenomeProf, p.TelefoneProf, AVG(ma.MediaDidatica) as MediaDidaticaTotal
    FROM Professor p 
        LEFT JOIN MediaAvaliacoesOferecimentos ma 
            ON ma.NomeProf = p.NomeProf 
            AND ma.SobrenomeProf = p.SobrenomeProf
            AND ma.TelefoneProf = p.TelefoneProf 
    GROUP BY p.NomeProf, p.SobrenomeProf, p.TelefoneProf;