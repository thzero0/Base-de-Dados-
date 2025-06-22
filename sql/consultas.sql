/*
Listar todas as salas de aula que um professor já utilizou
ao longo das disciplinas que ofereceu.
*/
SELECT DISTINCT s.NomeUnidade, s.NumeroSala

    FROM Professor p 
        JOIN Oferecimento o 
            ON p.NomeProf = o.NomeProf 
            AND p.SobrenomeProf = o.SobrenomeProf 
            AND p.TelefoneProf = o.TelefoneProf
        JOIN SalaDeAula s
            ON s.NomeUnidade = o.NomeUnidadeSala 
            AND s.NumeroSala = o.NumeroSala
    WHERE 
        p.NomeProf = 'Carlos'
        AND p.SobrenomeProf = 'Freitas'
        AND p.TelefoneProf = '(11) 97543-6930';




-- VIEW
/*
Listar todos os alunos com suas respectivas médias escolares,
sendo a média escolar a média das notas de todas as disciplinas
que o aluno já se matriculou.
*/
SELECT 
    a.NomeAluno, 
    a.SobrenomeAluno, 
    a.TelefoneAluno, 
    ROUND(AVG(md.MediaDisciplina), 2) as Media,
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
        ) md
        ON m.NomeAluno = md.NomeAluno
        AND m.SobrenomeAluno = md.SobrenomeAluno
        AND m.TelefoneAluno = md.TelefoneAluno
        AND m.CodigoDisciplina = md.CodigoDisciplina
        AND m.NomeProf = md.NomeProf
        AND m.SobrenomeProf = md.SobrenomeProf
        AND m.TelefoneProf = md.TelefoneProf
        AND m.InicioPeriodoLetivo = md.InicioPeriodoLetivo
    GROUP BY a.NomeAluno, a.SobrenomeAluno, a.TelefoneAluno;



/*
Listar todas as disciplinas que um professor já lecionou 
*/
SELECT
    p.NomeProf, 
    p.SobrenomeProf, 
    p.TelefoneProf,
    d.Codigo, 
    d.Nome, 
    Count(*) as NroVezesMinistradas

    FROM Professor p 
        JOIN Oferecimento o   
            ON o.NomeProf = p.NomeProf
            AND o.SobrenomeProf = p.SobrenomeProf
            AND o.TelefoneProf = p.TelefoneProf 
        JOIN Disciplina d
            ON d.Codigo = o.CodigoDisciplina
    WHERE 
        p.NomeProf = 'Carlos'
        AND p.SobrenomeProf = 'Freitas'
        AND p.TelefoneProf = '(11) 97543-6930'
    GROUP BY p.NomeProf, p.SobrenomeProf, p.TelefoneProf, d.Codigo, d.Nome;


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
    ROUND(AVG(a.NotaDidatica), 2) as MediaDidatica,
    ROUND(AVG(a.NotaMaterial), 2) as MediaMaterial,
    ROUND(AVG(a.RelevanciaConteudo), 2) as MediaRelevanciaConteudo,
    ROUND(AVG(a.InfraestruturaSala), 2) as MediaInfraestruturaSala,
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




-- VIEW
/*
Mostrar todos os departamentos, com a quantidade de cursos ligados
a ele, junto com as informações de contato do professor chefe.
*/
SELECT 
    d.Codigo, 
    d.Nome, 
    d.NomeProfChefe, 
    d.SobrenomeProfChefe, 
    d.TelefoneProfChefe, 
    u.Email as EmailChefe, 
    u.CEP as CEPchefe, 
    u.Numero as NumeroCasaChefe, 
    p.Especializacao as EspecilizacaoChefe, 
    p.Titulacao as TitulacaoChefe,
    Count(c.CodigoUnico) as QtdCursos
        FROM Departamento d 
            LEFT JOIN Curso c ON c.CodigoDepartamento = d.Codigo
            LEFT JOIN Professor p
                ON p.NomeProf = d.NomeProfChefe
                AND p.SobrenomeProf = d.SobrenomeProfChefe
                AND p.TelefoneProf = d.TelefoneProfChefe 
            LEFT JOIN Usuario u
                ON u.Nome = p.NomeProf 
                AND u.Sobrenome = p.SobrenomeProf 
                AND u.Telefone = p.TelefoneProf
        GROUP BY d.Codigo, d.Nome, d.NomeProfChefe, d.SobrenomeProfChefe, d.TelefoneProfChefe, u.Email, u.CEP, u.Numero, p.Especializacao, p.Titulacao;


/*
Fazer uma contagem de porcentagem de alunos que cancelam a matrícula por curso
*/
SELECT 
    c.CodigoUnico, 
    c.Nome, 
    Count(*) as QtdMatriculas,
    (SUM(CASE WHEN m.StatusMatricula = 'cancelada' THEN 1 else 0 END)::float /Count(*)) as PorcentagemMatriculasCanceladas
    
    FROM Curso c 
        LEFT JOIN ComposicaoCurso cc ON cc.CodigoUnicoCurso = c.CodigoUnico 
        LEFT JOIN Oferecimento o ON o.CodigoDisciplina = cc.CodigoDisciplina
        LEFT JOIN Matricula m 
            ON m.CodigoDisciplina = o.CodigoDisciplina
            AND m.NomeProf = o.NomeProf 
            AND m.SobrenomeProf = o.SobrenomeProf
            AND m.TelefoneProf = o.TelefoneProf
            AND m.InicioPeriodoLetivo = o.InicioPeriodoLetivo
    GROUP BY c.CodigoUnico, c.Nome;



/*
Mostrar todas as mensagens enviadas por um usuário na última semana
*/
SELECT m.Texto, m.Time_stamp
    FROM MensagemEnviada me 
        JOIN Mensagem m ON m.idMensagem = me.idMensagem
    WHERE 
        me.NomeRemetente = 'Carlos'
        AND me.SobrenomeRemetente = 'Freitas'
        AND me.TelefoneRemetente = '(11) 97543-6930'
        AND m.Time_stamp >= current_timestamp - INTERVAL '7 days';








