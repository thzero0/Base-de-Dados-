CREATE TABLE localizacao (
    cep VARCHAR(8) PRIMARY KEY,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    bairro VARCHAR(50)
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    telefone VARCHAR(13) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    genero VARCHAR(10) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(50) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    data_nascimento DATE NOT NULL,
    cep VARCHAR(8) NOT NULL,
    FOREIGN KEY (cep) REFERENCES localizacao(cep)
);


CREATE TABLE propriedade (
    id_propriedade INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    n_quartos INT NOT NULL,
    n_banheiros INT NOT NULL,
    preco_p_noite DECIMAL(10, 2) NOT NULL,
    max_hospedes INT NOT NULL,
    min_noites INT NOT NULL,
    max_noites INT NOT NULL,
    taxa_limpeza DECIMAL(10, 2),
    horario_entrada TIME,
    horario_saida TIME,
    cep VARCHAR(8) NOT NULL,
    id_locator INT NOT NULL,
    FOREIGN KEY (cep) REFERENCES localizacao(cep),
    FOREIGN KEY (id_locator) REFERENCES usuario(id_usuario)
);

CREATE TABLE conta_bancaria (
    n_conta VARCHAR(30) PRIMARY KEY,
    n_agencia VARCHAR(30) NOT NULL,
    tipo_conta VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);



CREATE TABLE ponto_interesse (
    nome VARCHAR(100) PRIMARY KEY,
    cep VARCHAR(8) NOT NULL,
    FOREIGN KEY (cep) REFERENCES localizacao(cep)
);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    data_check_in DATE NOT NULL,
    data_check_out DATE NOT NULL,
    n_hospedes INT NOT NULL,
    imposto_pago DECIMAL(10, 2),
    taxa_limpeza DECIMAL(10, 2),
    preco_estadia DECIMAL(10, 2),
    preco_total DECIMAL(10, 2),
    status VARCHAR(15) NOT NULL,
    id_propriedade INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE mensagem (
    id_mensagem INT PRIMARY KEY,
    timestamp_ TIMESTAMP NOT NULL,
    texto TEXT NOT NULL,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    FOREIGN KEY (id_remetente) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_destinatario) REFERENCES usuario(id_usuario)
);

CREATE TABLE regras (
    id_regra INT PRIMARY KEY,
    regra TEXT NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

CREATE TABLE quartos (
    id_quarto INT PRIMARY KEY,
    tipo_camas VARCHAR(50) NOT NULL,
    banheiro_privativo BOOLEAN NOT NULL,
    qtd_camas INT NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

CREATE TABLE comodidades (
    id_comodidade INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

CREATE TABLE datas_disponiveis (
    data_ DATE PRIMARY KEY,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);


CREATE TABLE avaliacao (
    id_avaliacao INT PRIMARY KEY,
    nota_limpeza INT,
    nota_estrutura INT,
    nota_comunicacao INT,
    nota_localizacao INT,
    nota_preco INT,
    id_propriedade INT NOT NULL,
    id_usuario INT NOT NULL,
    id_mensagem INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade),
    FOREIGN KEY (id_mensagem) REFERENCES mensagem(id_mensagem)
);

CREATE TABLE fotos (
    id_foto INT PRIMARY KEY,
    foto BYTEA NOT NULL,
    id_avaliacao INT NOT NULL,
    id_propriedade INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao),
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);