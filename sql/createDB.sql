DROP TABLE IF EXISTS Unidade CASCADE;
-- Criação da tabela Unidade
CREATE TABLE
    Unidade (
        NomeUnidade VARCHAR(50) PRIMARY KEY,
        Cidade VARCHAR(50) NOT NULL,
        Estado VARCHAR(50) NOT NULL,
        Pais VARCHAR(50) NOT NULL,
        Predio VARCHAR(50),
        Bloco VARCHAR(50),
        CONSTRAINT UQ_Unidade UNIQUE (Cidade, Estado, Pais)
    );

DROP TABLE IF EXISTS SalaDeAula CASCADE;
-- Criação da tabela SalaDeAula
CREATE TABLE
    SalaDeAula (
        NomeUnidade VARCHAR(50) NOT NULL,
        NumeroSala INTEGER NOT NULL,
        QtdLimite INTEGER NOT NULL,
        CONSTRAINT PK_SalaDeAula PRIMARY KEY (NomeUnidade, NumeroSala),
        CONSTRAINT FK_UnidadeSala FOREIGN KEY (NomeUnidade) REFERENCES Unidade (NomeUnidade)
    );

DROP TABLE IF EXISTS Usuario CASCADE;
-- Criação da tabela Usuario
CREATE TABLE
    Usuario (
        Nome VARCHAR(50),
        Sobrenome VARCHAR(200),
        Telefone VARCHAR(20),
        Sexo VARCHAR(20),
        Email VARCHAR(50) UNIQUE NOT NULL,
        DataNasc DATE,
        CEP VARCHAR(15),
        Numero VARCHAR(15),
        TipoUsuario t_tipoUsuario NOT NULL,
        Senha VARCHAR(50) NOT NULL,
        CONSTRAINT PK_Usuario PRIMARY KEY (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS Aluno CASCADE;
-- Criação da tabela Aluno
CREATE TABLE
    Aluno (
        NomeAluno VARCHAR(50),
        SobrenomeAluno VARCHAR(200),
        TelefoneAluno VARCHAR(20),
        NomeUnidade VARCHAR(50) REFERENCES Unidade (NomeUnidade),
        CONSTRAINT PK_Aluno PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno),
        CONSTRAINT FK_Usuario FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno) REFERENCES Usuario (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS Professor CASCADE;
-- Criação da tabela Professor
CREATE TABLE
    Professor (
        NomeProf VARCHAR(50),
        SobrenomeProf VARCHAR(200),
        TelefoneProf VARCHAR(20),
        Especializacao VARCHAR(100),
        Titulacao VARCHAR(100),
        NomeUnidade VARCHAR(50) REFERENCES Unidade (NomeUnidade),
        CONSTRAINT PK_Professor PRIMARY KEY (NomeProf, SobrenomeProf, TelefoneProf),
        CONSTRAINT FK_UsuarioProfessor FOREIGN KEY (NomeProf, SobrenomeProf, TelefoneProf) REFERENCES Usuario (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS FuncionarioAdministrativo CASCADE;
-- Criação da tabela FuncionarioAdministrativo
CREATE TABLE
    FuncionarioAdministrativo (
        NomeAdm VARCHAR(50),
        SobrenomeAdm VARCHAR(200),
        TelefoneAdm VARCHAR(20),
        CONSTRAINT PK_FuncionarioAdministrativo PRIMARY KEY (NomeAdm, SobrenomeAdm, TelefoneAdm),
        CONSTRAINT FK_UsuarioFuncionario FOREIGN KEY (NomeAdm, SobrenomeAdm, TelefoneAdm) REFERENCES Usuario (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS Departamento CASCADE;
-- Criação da tabela Departamento
CREATE TABLE
    Departamento (
        Codigo INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        Nome VARCHAR(50) NOT NULL,
        NomeProfChefe VARCHAR(50),
        SobrenomeProfChefe VARCHAR(200),
        TelefoneProfChefe VARCHAR(20),
        CONSTRAINT FK_ProfChefe FOREIGN KEY (
            NomeProfChefe,
            SobrenomeProfChefe,
            TelefoneProfChefe
        ) REFERENCES Professor (NomeProf, SobrenomeProf, TelefoneProf)
    );

DROP TABLE IF EXISTS Curso CASCADE;
-- Criação da tabela Curso
CREATE TABLE
    Curso (
        CodigoUnico INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        Nome VARCHAR(50) NOT NULL,
        Nivel t_nivel NOT NULL,
        CargaHoraria INTEGER NOT NULL,
        NumeroVagas INTEGER NOT NULL,
        Ementa VARCHAR(500),
        CodigoDepartamento INTEGER REFERENCES Departamento (Codigo),
        NomeUnidadeSalaPadrao VARCHAR(50),
        NumeroSalaPadrao INTEGER,
        NomeUnidadeCurso VARCHAR(50) REFERENCES Unidade (NomeUnidade),
        CONSTRAINT FK_SalaPadrao FOREIGN KEY (NomeUnidadeSalaPadrao, NumeroSalaPadrao) REFERENCES SalaDeAula (NomeUnidade, NumeroSala)
    );


DROP TABLE IF EXISTS Disciplina CASCADE;
-- Criação da tabela Disciplina
CREATE TABLE
    Disciplina (
        Codigo INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        Nome VARCHAR(50) NOT NULL,
        QtdAulasSemanais INTEGER NOT NULL,
        MaterialDidatico VARCHAR(300),
        NomeUnidade VARCHAR(50) REFERENCES Unidade (NomeUnidade)
    );




DROP TABLE IF EXISTS Oferecimento CASCADE;
-- Criação da tabela Oferecimento
CREATE TABLE
    Oferecimento (
        CodigoDisciplina INTEGER NOT NULL REFERENCES Disciplina (Codigo),
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        TipoPeriodoLetivo t_tipoPeriodoLetivo NOT NULL,
        MaxAlunos INTEGER NOT NULL,
        NomeUnidadeSala VARCHAR(50),
        NumeroSala INTEGER,
        CONSTRAINT PK_Oferecimento PRIMARY KEY (
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ),
        CONSTRAINT FK_ProfessorOferecimento FOREIGN KEY (
            NomeProf,
            SobrenomeProf,
            TelefoneProf
        ) REFERENCES Professor (NomeProf, SobrenomeProf, TelefoneProf),
        CONSTRAINT FK_SalaOferecimento FOREIGN KEY (NomeUnidadeSala, NumeroSala) REFERENCES SalaDeAula (NomeUnidade, NumeroSala)
    );


DROP TABLE IF EXISTS Mensagem CASCADE;
-- Criação da tabela Mensagem
CREATE TABLE
    Mensagem (
        IdMensagem INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        Time_stamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        Texto TEXT NOT NULL
    );

DROP TABLE IF EXISTS Aviso CASCADE;
-- Criação da tabela Aviso
CREATE TABLE
    Aviso (
        IdAviso INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        Time_stamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        Texto TEXT NOT NULL,
        NomeUsuario VARCHAR(50) NOT NULL,
        SobrenomeUsuario VARCHAR(200) NOT NULL,
        TelefoneUsuario VARCHAR(20) NOT NULL,
        CONSTRAINT FK_AvisoUsuario FOREIGN KEY (
            NomeUsuario,
            SobrenomeUsuario,
            TelefoneUsuario
        ) REFERENCES Usuario (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS ProfDiscResponsaveis CASCADE;
-- Criação da tabela ProfDiscResponsaveis
CREATE TABLE
    ProfDiscResponsaveis (
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        CodigoDisciplina INTEGER NOT NULL REFERENCES Disciplina (Codigo),
        CONSTRAINT PK_ProfDiscResponsaveis PRIMARY KEY (
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            CodigoDisciplina
        ),
        CONSTRAINT FK_ProfessorResponsavel FOREIGN KEY (
            NomeProf,
            SobrenomeProf,
            TelefoneProf
        ) REFERENCES Professor (NomeProf, SobrenomeProf, TelefoneProf)
    );

DROP TABLE IF EXISTS Matricula CASCADE;
-- Criação da tabela Matricula
CREATE TABLE
    Matricula (
        NomeAluno VARCHAR(50) NOT NULL,
        SobrenomeAluno VARCHAR(200) NOT NULL,
        TelefoneAluno VARCHAR(20) NOT NULL,
        CodigoDisciplina INTEGER NOT NULL,
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        DataMatricula DATE NOT NULL,
        StatusMatricula VARCHAR(20) NOT NULL,
        Taxas NUMERIC(10, 2) NOT NULL,
        StatusPagamento VARCHAR(20) NOT NULL,

        CONSTRAINT PK_Matricula PRIMARY KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno,
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ),
        CONSTRAINT FK_AlunoMatricula FOREIGN KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno
        ) REFERENCES Aluno (NomeAluno, SobrenomeAluno, TelefoneAluno),
        CONSTRAINT FK_OferecimentoMatricula FOREIGN KEY (
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ) REFERENCES Oferecimento (CodigoDisciplina, NomeProf, SobrenomeProf, TelefoneProf, InicioPeriodoLetivo)
    );

DROP TABLE IF EXISTS DataLimiteDeMatricula CASCADE;
-- Criação da tabela DataLimiteDeMatricula
CREATE TABLE
    DataLimiteDeMatricula (
        CodigoDisciplina INTEGER NOT NULL,
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        DataLimite DATE NOT NULL,
        CONSTRAINT PK_DataLimiteDeMatricula PRIMARY KEY (
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ),
        CONSTRAINT FK_OferecimentoDataLimite FOREIGN KEY (
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ) REFERENCES Oferecimento (CodigoDisciplina, NomeProf, SobrenomeProf, TelefoneProf, InicioPeriodoLetivo)
    );

DROP TABLE IF EXISTS Avaliacao CASCADE;
-- Criação da tabela Avaliacao
CREATE TABLE
    Avaliacao (
        NomeAluno VARCHAR(50) NOT NULL,
        SobrenomeAluno VARCHAR(200) NOT NULL,
        TelefoneAluno VARCHAR(20) NOT NULL,
        CodigoDisciplina INTEGER NOT NULL,
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        Comentario TEXT,
        NotaDidatica INTEGER,
        NotaMaterial INTEGER,
        RelevanciaConteudo INTEGER,
        InfraestruturaSala INTEGER,
        CONSTRAINT PK_Avaliacao PRIMARY KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno,
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ),
        CONSTRAINT FK_OferecimentoAvaliacao FOREIGN KEY (
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ) REFERENCES Oferecimento (CodigoDisciplina, NomeProf, SobrenomeProf, TelefoneProf, InicioPeriodoLetivo),
        CONSTRAINT FK_AlunoAvaliacao FOREIGN KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno
        ) REFERENCES Aluno (NomeAluno, SobrenomeAluno, TelefoneAluno)
    );


DROP TABLE IF EXISTS PreReqDisciplina CASCADE;
-- Criação da tabela PreReqDisciplina
CREATE TABLE
    PreReqDisciplina (
        CodigoUnicoCurso INTEGER NOT NULL REFERENCES Curso (CodigoUnico),
        CodigoDisciplina INTEGER NOT NULL REFERENCES Disciplina (Codigo),
        CONSTRAINT PK_PreReqDisciplina PRIMARY KEY (CodigoUnicoCurso, CodigoDisciplina)
    );

DROP TABLE IF EXISTS ComposicaoCurso CASCADE;
-- Criação da tabela ComposicaoCurso
CREATE TABLE
    ComposicaoCurso (
        CodigoUnicoCurso INTEGER NOT NULL REFERENCES Curso (CodigoUnico),
        CodigoDisciplina INTEGER NOT NULL REFERENCES Disciplina (Codigo),
        CONSTRAINT PK_ComposicaoCurso PRIMARY KEY (CodigoUnicoCurso, CodigoDisciplina)
    );

DROP TABLE IF EXISTS PreReqCurso CASCADE;
-- Criação da tabela PreReqCurso
CREATE TABLE
    PreReqCurso (
        CodigoCurso INTEGER NOT NULL REFERENCES Curso (CodigoUnico),
        CodigoCursoPreReq INTEGER NOT NULL REFERENCES Curso (CodigoUnico),
        CONSTRAINT PK_PreReqCurso PRIMARY KEY (CodigoCurso, CodigoCursoPreReq)
    );

DROP TABLE IF EXISTS MensagemEnviada CASCADE;
-- Criação da tabela MensagemEnviada
CREATE TABLE
    MensagemEnviada (
        IdMensagem INTEGER NOT NULL REFERENCES Mensagem (IdMensagem),
        NomeDestinatario VARCHAR(50) NOT NULL,
        SobrenomeDestinatario VARCHAR(200) NOT NULL,
        TelefoneDestinatario VARCHAR(20) NOT NULL,
        NomeRemetente VARCHAR(50) NOT NULL,
        SobrenomeRemetente VARCHAR(200) NOT NULL,
        TelefoneRemetente VARCHAR(20) NOT NULL,
        CONSTRAINT PK_MensagemEnviada PRIMARY KEY (
            IdMensagem,
            NomeDestinatario,
            SobrenomeDestinatario,
            TelefoneDestinatario 
        ),
        CONSTRAINT FK_MensagemEnviadaDestinatario FOREIGN KEY (
            NomeDestinatario,
            SobrenomeDestinatario,
            TelefoneDestinatario
        ) REFERENCES Usuario (Nome, Sobrenome, Telefone),
        CONSTRAINT FK_MensagemEnviadaRemetente FOREIGN KEY (
            NomeRemetente,
            SobrenomeRemetente,
            TelefoneRemetente
        ) REFERENCES Usuario (Nome, Sobrenome, Telefone)
    );

DROP TABLE IF EXISTS Notas CASCADE;
-- Criação da tabela Notas
CREATE TABLE
    Notas (
        IdNota INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        NomeAluno VARCHAR(50) NOT NULL,
        SobrenomeAluno VARCHAR(200) NOT NULL,
        TelefoneAluno VARCHAR(20) NOT NULL,
        CodigoDisciplina INTEGER NOT NULL,
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        Nota NUMERIC(5, 2) NOT NULL,
        CONSTRAINT FK_MatriculaNotas FOREIGN KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno,
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ) REFERENCES Matricula (
            NomeAluno, 
            SobrenomeAluno, 
            TelefoneAluno, 
            CodigoDisciplina, 
            NomeProf, 
            SobrenomeProf, 
            TelefoneProf, 
            InicioPeriodoLetivo
        )
    );

DROP TABLE IF EXISTS Bolsas CASCADE;
-- Criação da tabela Bolsas
CREATE TABLE
    Bolsas (
        IdBolsa INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        NomeAluno VARCHAR(50) NOT NULL,
        SobrenomeAluno VARCHAR(200) NOT NULL,
        TelefoneAluno VARCHAR(20) NOT NULL,
        CodigoDisciplina INTEGER NOT NULL,
        NomeProf VARCHAR(50) NOT NULL,
        SobrenomeProf VARCHAR(200) NOT NULL,
        TelefoneProf VARCHAR(20) NOT NULL,
        InicioPeriodoLetivo DATE NOT NULL,
        Bolsa NUMERIC(5,2) NOT NULL,
        CONSTRAINT FK_MatriculaBolsas FOREIGN KEY (
            NomeAluno,
            SobrenomeAluno,
            TelefoneAluno,
            CodigoDisciplina,
            NomeProf,
            SobrenomeProf,
            TelefoneProf,
            InicioPeriodoLetivo
        ) REFERENCES Matricula (
            NomeAluno, 
            SobrenomeAluno, 
            TelefoneAluno, 
            CodigoDisciplina, 
            NomeProf, 
            SobrenomeProf, 
            TelefoneProf, 
            InicioPeriodoLetivo
        )
    );