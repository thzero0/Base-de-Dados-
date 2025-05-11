
/*
  Consultas SQL para o projeto de banco de dados
  Grupo: 14
  Alunos:

  -Clara Ernesto de Carvalho - 14559479
  -Gabriel Barbosa dos Santos - 14613991
  -Renan Parpinelli Scarpin - 14712188
  -Thiago Zero Araujo - 11814183

*/

-- Criação da tabela localizacao
DROP TABLE IF EXISTS localizacao CASCADE;
CREATE TABLE localizacao (
    cep VARCHAR(8) PRIMARY KEY,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    bairro VARCHAR(50)
);

-- Criação da tabela usuario
DROP TABLE IF EXISTS usuario CASCADE;
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

-- Criação da tabela propriedade
DROP TABLE IF EXISTS propriedade CASCADE;
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

-- Criação da tabela conta_bancaria
DROP TABLE IF EXISTS conta_bancaria CASCADE;
CREATE TABLE conta_bancaria (
    n_conta VARCHAR(30) PRIMARY KEY,
    n_agencia VARCHAR(30) NOT NULL,
    tipo_conta VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


-- Criação da tabela ponto_interesse
DROP TABLE IF EXISTS ponto_interesse CASCADE;
CREATE TABLE ponto_interesse (
    nome VARCHAR(100) PRIMARY KEY,
    cep VARCHAR(8) NOT NULL,
    FOREIGN KEY (cep) REFERENCES localizacao(cep)
);


-- Criação da tabela reserva
DROP TABLE IF EXISTS reserva CASCADE;
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

-- Criação da tabela mensagem
DROP TABLE IF EXISTS mensagem CASCADE;
CREATE TABLE mensagem (
    id_mensagem INT PRIMARY KEY,
    timestamp_ TIMESTAMP NOT NULL,
    texto TEXT NOT NULL,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    FOREIGN KEY (id_remetente) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_destinatario) REFERENCES usuario(id_usuario)
);

-- Criação da tabela regras
DROP TABLE IF EXISTS regras CASCADE;
CREATE TABLE regras (
    id_regra INT PRIMARY KEY,
    regra TEXT NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

-- Criação da tabela quartos
DROP TABLE IF EXISTS quartos CASCADE;
CREATE TABLE quartos (
    id_quarto INT PRIMARY KEY,
    tipo_camas VARCHAR(50) NOT NULL,
    banheiro_privativo BOOLEAN NOT NULL,
    qtd_camas INT NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

-- Criação da tabela comodidades
DROP TABLE IF EXISTS comodidades CASCADE;
CREATE TABLE comodidades (
    id_comodidade INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);

-- Criação da tabela datas_disponiveis
DROP TABLE IF EXISTS datas_disponiveis CASCADE;
CREATE TABLE datas_disponiveis (
    id_data INT PRIMARY KEY,
    data_ DATE NOT NULL,
    id_propriedade INT NOT NULL,
    FOREIGN KEY (id_propriedade) REFERENCES propriedade(id_propriedade)
);


-- Criação da tabela avaliacao
DROP TABLE IF EXISTS avaliacao CASCADE;
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

-- Criação da tabela fotos
DROP TABLE IF EXISTS fotos CASCADE;
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


-- Inserção de dados na tabela localizacao
INSERT INTO localizacao (cep, cidade, estado, pais, bairro)
VALUES
('12345678', 'São Paulo', 'SP', 'Brasil', 'Jardins'),
('87654321', 'Rio de Janeiro', 'RJ', 'Brasil', NULL),
('34567890', 'Belo Horizonte', 'MG', 'Brasil', 'Savassi'),
('45678901', 'Curitiba', 'PR', 'Brasil', 'Batel'),
('56789012', 'Florianópolis', 'SC', 'Brasil', NULL),
('67890123', 'Porto Alegre', 'RS', 'Brasil', 'Moinhos de Vento'),
('78901234', 'Recife', 'PE', 'Brasil', NULL),
('89012345', 'Fortaleza', 'CE', 'Brasil', 'Meireles'),
('90123456', 'Salvador', 'BA', 'Brasil', NULL),
('01234567', 'Campinas', 'SP', 'Brasil', 'Cambuí'),
('11223344', 'Uberlândia', 'MG', 'Brasil', NULL),
('22334455', 'Natal', 'RN', 'Brasil', 'Ponta Negra'),
('33445566', 'Manaus', 'AM', 'Brasil', 'Adrianópolis'),
('44556677', 'Belém', 'PA', 'Brasil', NULL),
('55667788', 'João Pessoa', 'PB', 'Brasil', 'Tambaú'),
('66778899', 'São Luís', 'MA', 'Brasil', 'Renascença'),
('77889900', 'Teresina', 'PI', 'Brasil', 'Ilhotas'),
('88990011', 'Aracaju', 'SE', 'Brasil', '13 de Julho'),
('99001122', 'Campo Grande', 'MS', 'Brasil', 'Centro'),
('10111213', 'Cuiabá', 'MT', 'Brasil', 'Duque de Caxias'),
('12131415', 'Vitória', 'ES', 'Brasil', NULL),
('13141516', 'Joinville', 'SC', 'Brasil', NULL),
('14151617', 'São José dos Campos', 'SP', 'Brasil', 'Jardim Aquarius'),
('15161718', 'Londrina', 'PR', 'Brasil', 'Gleba Palhano'),
('16171819', 'Ribeirão Preto', 'SP', 'Brasil', 'Jardim Botânico'),
('17181920', 'Maringá', 'PR', 'Brasil', 'Zona 7'),
('18192021', 'Niterói', 'RJ', 'Brasil', NULL),
('19202122', 'Blumenau', 'SC', 'Brasil', 'Victor Konder'),
('20212223', 'Pelotas', 'RS', 'Brasil', NULL),
('21222324', 'Feira de Santana', 'BA', 'Brasil', 'Kalilândia'),
('30303030', 'Belo Horizonte', 'MG', 'Brasil', 'Funcionários'),
('40404040', 'Rio de Janeiro', 'RJ', 'Brasil', NULL),
('50505050', 'Curitiba', 'PR', 'Brasil', 'Água Verde'),
('60606060', 'Florianópolis', 'SC', 'Brasil', 'Trindade'),
('70707070', 'Porto Alegre', 'RS', 'Brasil', NULL),
('80808080', 'Fortaleza', 'CE', 'Brasil', 'Aldeota'),
('81818181', 'Salvador', 'BA', 'Brasil', 'Rio Vermelho'),
('82828282', 'Campinas', 'SP', 'Brasil', 'Taquaral'),
('83838383', 'Uberlândia', 'MG', 'Brasil', NULL),
('84848484', 'Natal', 'RN', 'Brasil', 'Lagoa Nova'),
('85858585', 'Manaus', 'AM', 'Brasil', 'Centro');

-- Inserção de dados na tabela ponto_interesse
INSERT INTO ponto_interesse (nome, cep) 
VALUES 
('Parque Ibirapuera', '12345678'),
('Museu do Amanhã', '87654321'),
('Praça da Liberdade', '34567890'),
('Jardim Botânico', '45678901'),
('Praia da Joaquina', '56789012'),
('Parque da Redenção', '67890123'),
('Instituto Ricardo Brennand', '78901234'),
('Praia de Iracema', '89012345'),
('Elevador Lacerda', '90123456'),
('Lagoa do Taquaral', '01234567'),
('Parque do Sabiá', '11223344'),
('Forte dos Reis Magos', '22334455'),
('Teatro Amazonas', '33445566'),
('Estação das Docas', '44556677'),
('Farol do Cabo Branco', '55667788'),
('Espigão Costeiro', '66778899'),
('Palácio de Karnak', '77889900'),
('Orla do Bairro 13 de Julho', '88990011'),
('Parque das Nações Indígenas', '99001122'),
('Museu do Morro da Caixa DÁgua Velha', '10111213'),
('Praia de Camburi', '12131415'),
('Parque Caieiras', '13141516'),
('Parque Vicentina Aranha', '14151617'),
('Igapó Lake', '15161718'),
('Parque Curupira', '16171819'),
('Parque do Ingá', '17181920'),
('Campo de São Bento', '18192021'),
('Museu da Família Colonial', '19202122'),
('Theatro Sete de Abril', '20212223'),
('Parque da Cidade', '21222324');

-- Inserção de dados na tabela usuario
INSERT INTO usuario (id_usuario, nome, sobrenome, telefone, cpf, genero, endereco, email, senha, tipo, data_nascimento, cep)
VALUES
(10, 'Ana', 'Silva', '11999999901', '12345678901', 'Feminino', 'Rua das Palmeiras 10', 'ana.silva@email.com', 'senha123', 'Locador', '1985-06-12', '30303030'),
(11, 'Bruno', 'Souza', '11999999902', '12345678902', 'Masculino', 'Rua dos Cedros 44', 'bruno.souza@email.com', 'senha123', 'Hospede', '1990-03-22', '40404040'),
(12, 'Camila', 'Oliveira', '11999999903', '12345678903', 'Feminino', 'Rua da Aurora 77', 'camila.o@email.com', 'senha123', 'Ambos', '1995-01-10', '34567890'),
(13, 'Diego', 'Costa', '11999999904', '12345678904', 'Masculino', 'Avenida Brasil 210', 'diego.costa@email.com', 'senha123', 'Locador', '1982-12-03', '50505050'),
(14, 'Eduarda', 'Martins', '11999999905', '12345678905', 'Feminino', 'Rua do Limoeiro 90', 'eduarda@email.com', 'senha123', 'Hospede', '1998-05-18', '60606060'),
(15, 'Felipe', 'Almeida', '11999999906', '12345678906', 'Masculino', 'Rua Nova 55', 'felipe@email.com', 'senha123', 'Ambos', '1987-08-09', '70707070'),
(16, 'Giovana', 'Rocha', '11999999907', '12345678907', 'Feminino', 'Rua do Vento 33', 'giovana@email.com', 'senha123', 'Hospede', '2000-11-15', '78901234'),
(17, 'Henrique', 'Pereira', '11999999908', '12345678908', 'Masculino', 'Rua do Sol 12', 'henrique@email.com', 'senha123', 'Locador', '1975-02-26', '80808080'),
(18, 'Isabela', 'Ramos', '11999999909', '12345678909', 'Feminino', 'Rua Campo Verde 99', 'isabela@email.com', 'senha123', 'Ambos', '1989-04-07', '81818181'),
(19, 'João', 'Batista', '11999999910', '12345678910', 'Masculino', 'Rua dos Pinhais 120', 'joao@email.com', 'senha123', 'Hospede', '1993-07-29', '01234567'),
(20, 'Karina', 'Lopes', '11999999911', '12345678911', 'Feminino', 'Rua do Vale 18', 'karina@email.com', 'senha123', 'Ambos', '1984-10-21', '82828282'),
(21, 'Lucas', 'Moraes', '11999999912', '12345678912', 'Masculino', 'Rua das Laranjeiras 51', 'lucas@email.com', 'senha123', 'Hospede', '1992-06-30', '83838383'),
(22, 'Mariana', 'Castro', '11999999913', '12345678913', 'Feminino', 'Rua Aurora 10', 'mariana@email.com', 'senha123', 'Locador', '1996-03-01', '84848484'),
(23, 'Nicolas', 'Barbosa', '11999999914', '12345678914', 'Masculino', 'Rua 7 de Setembro 200', 'nicolas@email.com', 'senha123', 'Ambos', '1994-09-14', '85858585'),
(24, 'Olívia', 'Ferreira', '11999999915', '12345678915', 'Feminino', 'Rua do Céu 101', 'olivia@email.com', 'senha123', 'Hospede', '1999-01-11', '55667788'),
(25, 'Pedro', 'Gonçalves', '11999999916', '12345678916', 'Masculino', 'Rua do Horizonte 17', 'pedro@email.com', 'senha123', 'Ambos', '1986-08-03', '66778899'),
(26, 'Quezia', 'Teixeira', '11999999917', '12345678917', 'Feminino', 'Rua das Indústrias 30', 'quezia@email.com', 'senha123', 'Locador', '1983-04-18', '77889900'),
(27, 'Rafael', 'Lima', '11999999918', '12345678918', 'Masculino', 'Rua do Sol Nascente 8', 'rafael@email.com', 'senha123', 'Hospede', '1997-10-25', '88990011'),
(28, 'Sabrina', 'Farias', '11999999919', '12345678919', 'Feminino', 'Rua das Ondas 66', 'sabrina@email.com', 'senha123', 'Ambos', '2001-02-14', '99001122'),
(29, 'Thiago', 'Cavalcante', '11999999920', '12345678920', 'Masculino', 'Rua do Ipê 99', 'thiago@email.com', 'senha123', 'Locador', '1980-12-20', '10111213'),
(30, 'Úrsula', 'Rezende', '11999999921', '12345678921', 'Feminino', 'Rua da Manhã 70', 'ursula@email.com', 'senha123', 'Ambos', '1988-07-09', '12131415'),
(31, 'Victor', 'Henrique', '11999999922', '12345678922', 'Masculino', 'Rua da Serra Azul 14', 'victor@email.com', 'senha123', 'Hospede', '1991-06-06', '13141516'),
(32, 'Wanda', 'Paz', '11999999923', '12345678923', 'Feminino', 'Rua do Design 23', 'wanda@email.com', 'senha123', 'Ambos', '1990-09-19', '14151617'),
(33, 'Xavier', 'Amaral', '11999999924', '12345678924', 'Masculino', 'Rua do Ipê Roxo 17', 'xavier@email.com', 'senha123', 'Hospede', '1985-05-02', '15161718'),
(34, 'Yasmin', 'Alves', '11999999925', '12345678925', 'Feminino', 'Rua do Horizonte Azul 40', 'yasmin@email.com', 'senha123', 'Locador', '2000-12-01', '16171819'),
(35, 'Zeca', 'Pinto', '11999999926', '12345678926', 'Masculino', 'Rua das Árvores 111', 'zeca@email.com', 'senha123', 'Ambos', '1995-07-07', '17181920'),
(36, 'Aline', 'Carvalho', '11999999927', '12345678927', 'Feminino', 'Rua do Luar 91', 'aline@email.com', 'senha123', 'Locador', '1987-03-23', '18192021'),
(37, 'Breno', 'Moreira', '11999999928', '12345678928', 'Masculino', 'Rua das Magnólias 101', 'breno@email.com', 'senha123', 'Hospede', '1993-02-12', '19202122'),
(38, 'Cíntia', 'Sales', '11999999929', '12345678929', 'Feminino', 'Rua da Alegria 14', 'cintia@email.com', 'senha123', 'Ambos', '1998-11-27', '20212223'),
(39, 'Davi', 'Neves', '11999999930', '12345678930', 'Masculino', 'Rua Nova Esperança 18', 'davi@email.com', 'senha123', 'Ambos', '1996-04-04', '21222324'),
(40, 'Mateus', 'Sales', '11999999931', '12345678931', 'Masculino', 'Rua da Alegria 14', 'mateus@email.com', 'senha123', 'Hospede', '2005-11-27', '20212223'),
(41, 'Paulo', 'Neves', '11999999932', '12345678932', 'Masculino', 'Rua Nova Esperança 18', 'paulo@email.com', 'senha123', 'Hospede', '2003-04-04', '21222324');

-- Inserção de dados na tabela propriedade
INSERT INTO propriedade (id_propriedade, nome, endereco, tipo, n_quartos, n_banheiros, preco_p_noite, max_hospedes, min_noites, max_noites, taxa_limpeza, horario_entrada, horario_saida, cep, id_locator)
VALUES
(1, 'Casa do Lago', 'Rua das Águas 123', 'Casa inteira', 3, 2, 350.00, 6, 2, 15, 50.00, '14:00', '11:00', '12345678', 10),
(2, 'Suíte Azul', 'Rua das Flores 88', 'Quarto individual', 1, 1, 120.00, 2, 1, 10, NULL, '15:00', '10:00', '50505050', 12),
(3, 'Hostel Central', 'Avenida Brasil 45', 'Quarto compartilhado', 1, 2, 60.00, 4, 1, 7, 10.00, NULL, '12:00', '34567890', 13),
(4, 'Refúgio da Serra', 'Rua do Pinheiro 321', 'Casa inteira', 4, 3, 500.00, 8, 3, 20, 80.00, '16:00', NULL, '45678901', 13),
(5, 'Apê Moderno', 'Rua Nova 77', 'Casa inteira', 2, 2, 280.00, 4, 2, 10, NULL, NULL, '10:00', '56789012', 15),
(6, 'Quarto Zen', 'Rua Sakura 12', 'Quarto individual', 1, 1, 90.00, 1, 1, 5, 15.00, '12:00', '09:00', '67890123', 18),
(7, 'Quarto Compartilhado Roots', 'Rua das Palmeiras 56', 'Quarto compartilhado', 1, 1, 55.00, 6, 1, 7, NULL, '17:00', '11:00', '78901234', 18),
(8, 'Vila Vintage', 'Rua do Sol 89', 'Casa inteira', 5, 4, 750.00, 10, 3, 30, 100.00, '15:00', '10:00', '89012345', 18),
(9, 'Apê da Júlia', 'Avenida Central 456', 'Casa inteira', 2, 1, 230.00, 3, 2, 15, NULL, '13:00', '11:00', '90123456', 18),
(10, 'Suíte Tranquila', 'Rua do Vento 102', 'Quarto individual', 1, 1, 110.00, 2, 1, 8, 10.00, NULL, NULL, '22334455', 18),
(11, 'Loft Industrial', 'Rua das Indústrias 500', 'Casa inteira', 1, 1, 310.00, 2, 2, 12, 25.00, '15:00', '11:00', '22334455', 20),
(12, 'Quarto da Clara', 'Rua do Limoeiro 78', 'Quarto individual', 1, 1, 100.00, 1, 1, 6, NULL, '13:00', '09:00', '22334455', 22),
(13, 'Hostel Raízes', 'Rua das Árvores 31', 'Quarto compartilhado', 1, 1, 45.00, 5, 1, 4, 8.00, '16:00', '12:00', '22334455', 22),
(14, 'Casa Verde', 'Rua Campo Verde 64', 'Casa inteira', 3, 2, 370.00, 6, 2, 18, NULL, NULL, '10:30', '44556677', 25),
(15, 'Estúdio Central', 'Rua 7 de Setembro 89', 'Casa inteira', 1, 1, 200.00, 2, 1, 10, 20.00, '13:30', NULL, '55667788', 25),
(16, 'Suíte da Montanha', 'Rua da Serra Azul 17', 'Quarto individual', 1, 1, 125.00, 2, 1, 9, NULL, NULL, '09:00', '55667788', 28),
(17, 'Quarto Roots', 'Rua do Ipê 111', 'Quarto compartilhado', 1, 1, 50.00, 4, 1, 5, 6.00, '14:00', '10:00', '55667788', 28),
(18, 'Casa da Beira', 'Rua do Rio 90', 'Casa inteira', 4, 3, 480.00, 7, 2, 20, 70.00, NULL, '10:00', '88990011', 28),
(19, 'Apê Solar', 'Rua Aurora 45', 'Casa inteira', 2, 1, 260.00, 3, 2, 12, NULL, NULL, NULL, '99001122', 38),
(20, 'Quarto na Vila', 'Rua dos Pinhais 12', 'Quarto individual', 1, 1, 95.00, 2, 1, 6, 12.00, '16:00', '10:00', '10111213', 30),
(21, 'Studio Zen', 'Rua do Sol Nascente 3', 'Casa inteira', 1, 1, 195.00, 2, 2, 14, 18.00, NULL, NULL, '12131415', 30),
(22, 'Quarto Aconchegante', 'Rua do Vale 20', 'Quarto individual', 1, 1, 105.00, 2, 1, 7, 10.00, '14:00', '09:00', '10111213', 30),
(23, 'Hostel dos Sonhos', 'Rua dos Cedros 55', 'Quarto compartilhado', 1, 1, 60.00, 6, 1, 5, NULL, NULL, '10:00', '14151617', 32),
(24, 'Casa da Colina', 'Rua das Laranjeiras 22', 'Casa inteira', 3, 2, 400.00, 5, 2, 16, 50.00, '12:30', '11:30', '14151617', 32),
(25, 'Apê Azul', 'Rua do Céu 77', 'Casa inteira', 2, 1, 270.00, 4, 2, 13, 30.00, NULL, '10:00', '16171819', 34),
(26, 'Suíte do Mar', 'Rua das Ondas 90', 'Quarto individual', 1, 1, 115.00, 1, 1, 7, NULL, '13:00', NULL, '17181920', 35),
(27, 'Quarto do Sol', 'Rua da Manhã 21', 'Quarto compartilhado', 1, 1, 58.00, 4, 1, 6, 10.00, NULL, NULL, '18192021', 35),
(28, 'Casa Branca', 'Rua do Horizonte 101', 'Casa inteira', 4, 3, 520.00, 9, 3, 21, NULL, '15:00', '11:00', '19202122', 15),
(29, 'Estúdio Minimalista', 'Rua do Design 5', 'Casa inteira', 1, 1, 210.00, 2, 1, 11, 22.00, '14:00', '10:00', '20212223', 12),
(30, 'Quarto da Guerra', 'Rua da Alegria 10', 'Quarto individual', 1, 1, 100.00, 2, 1, 8, 10.00, NULL, NULL, '21222324', 10),
(31, 'Casa da Esperança', 'Rua das Laranjeiras 22', 'Casa inteira', 3, 2, 400.00, 5, 2, 16, 50.00, '12:30', '11:30', '21222324', 32),
(32, 'Apê Laranja', 'Rua do Céu 77', 'Casa inteira', 2, 1, 270.00, 4, 2, 13, 30.00, NULL, '10:00', '21222324', 34),
(33, 'Suíte do Mar', 'Rua das Ondas 90', 'Quarto individual', 1, 1, 115.00, 1, 1, 7, NULL, '13:00', NULL, '21222324', 35),
(34, 'Quarto do Sol', 'Rua da Manhã 21', 'Quarto compartilhado', 1, 1, 58.00, 4, 1, 6, 10.00, NULL, NULL, '21222324', 35),
(35, 'Casa Branca', 'Rua do Horizonte 101', 'Casa inteira', 4, 3, 520.00, 9, 3, 21, NULL, '15:00', '11:00', '21222324', 15),
(36, 'Estúdio Minimalista', 'Rua do Design 5', 'Casa inteira', 1, 1, 210.00, 2, 1, 11, 22.00, '14:00', '10:00', '21222324', 12),
(37, 'Quarto da Paz', 'Rua da Alegria 10', 'Quarto individual', 1, 1, 100.00, 2, 1, 8, 10.00, NULL, NULL, '21222324', 10),
(38, 'Casa da Esperança', 'Rua das Laranjeiras 22', 'Casa inteira', 3, 2, 400.00, 5, 2, 16, 50.00, '12:30', '11:30', '21222324', 10),
(39, 'Apê Laranja', 'Rua do Céu 77', 'Casa inteira', 2, 1, 270.00, 4, 2, 13, 30.00, NULL, '10:00', '21222324', 10),
(40, 'Suíte do Mar', 'Rua das Ondas 90', 'Quarto individual', 1, 1, 115.00, 1, 1, 7, NULL, '13:00', NULL, '21222324', 10),
(41, 'Quarto do Sol', 'Rua da Manhã 21', 'Quarto compartilhado', 1, 1, 58.00, 4, 1, 6, 10.00, NULL, NULL, '21222324', 10),
(42, 'Casa Branca', 'Rua do Horizonte 101', 'Casa inteira', 4, 3, 520.00, 9, 3, 21, NULL, '15:00', '11:00', '21222324', 10),
(43, 'Estúdio Minimalista', 'Rua do Design 5', 'Casa inteira', 1, 1, 210.00, 2, 1, 11, 22.00, '14:00', '10:00', '21222324', 10),
(44, 'Quarto da Paz', 'Rua da Alegria 10', 'Quarto individual', 1, 1, 100.00, 2, 1, 8, 10.00, NULL, NULL, '21222324', 10),
(45, 'Loft Industrial', 'Rua das Indústrias 500', 'Casa inteira', 1, 1, 310.00, 2, 2, 12, 25.00, '15:00', '11:00', '85858585', 23),
(46, 'Quarto da Clara', 'Rua do Limoeiro 78', 'Quarto individual', 1, 1, 100.00, 1, 1, 6, NULL, '13:00', '09:00', '85858585', 23),
(47, 'Hostel Raízes', 'Rua das Árvores 31', 'Quarto compartilhado', 1, 1, 45.00, 5, 1, 4, 8.00, '16:00', '12:00', '85858585', 23),
(48, 'Casa Verde', 'Rua Campo Verde 64', 'Casa inteira', 3, 2, 370.00, 6, 2, 18, NULL, NULL, '10:30', '85858585', 23),
(49, 'Estúdio Central', 'Rua 7 de Setembro 89', 'Casa inteira', 1, 1, 200.00, 2, 1, 10, 20.00, '13:30', NULL, '85858585', 23),
(50, 'Suíte da Montanha', 'Rua da Serra Azul 17', 'Quarto individual', 1, 1, 125.00, 2, 1, 9, NULL, NULL, '09:00', '85858585', 23),
(51, 'Quarto Roots', 'Rua do Ipê 111', 'Quarto compartilhado', 1, 1, 50.00, 4, 1, 5, 6.00, '14:00', '10:00', '85858585', 23),
(52, 'Casa da Beira', 'Rua do Rio 90', 'Casa inteira', 4, 3, 480.00, 7, 2, 20, 70.00, NULL, '10:00', '85858585', 23);

-- Inserção de dados na tabela regras
INSERT INTO regras (id_regra, regra, id_propriedade)
VALUES
(1, 'Proibido fumar nas dependências', 1),
(2, 'Não é permitido fazer festas ou eventos', 2),
(3, 'Animais de estimação não são permitidos', 3),
(4, 'Check-in após as 14:00 e check-out até às 12:00', 4),
(5, 'É necessário apresentar documento de identidade no check-in', 5),
(6, 'A propriedade deve ser mantida limpa durante a estadia', 6),
(7, 'É proibido o uso de velas ou equipamentos de fogo', 7),
(8, 'O consumo de álcool é permitido apenas nas áreas externas', 8),
(9, 'Não são permitidos visitantes não registrados', 9),
(10, 'O uso de barbeadores e secadores de cabelo é restrito a áreas específicas', 10),
(11, 'Em caso de dano à propriedade, o hóspede será responsabilizado', 11),
(12, 'É proibido o uso de eletrodomésticos de alto consumo sem autorização', 12),
(13, 'A limpeza da casa será realizada apenas uma vez por semana', 13),
(14, 'Os hóspedes devem seguir as regras de silêncio entre 22:00 e 07:00', 14),
(15, 'A propriedade não oferece serviços de transporte', 15),
(16, 'O ar condicionado deve ser desligado quando não estiver em uso', 16),
(17, 'É permitido o uso de churrasqueira somente nas áreas externas', 17),
(18, 'Não é permitida a realização de modificações na decoração', 18),
(19, 'Os hóspedes devem respeitar o limite de ocupação da propriedade', 19),
(20, 'É proibido deixar lixo fora dos locais adequados', 20),
(21, 'A propriedade oferece estacionamento, sujeito à disponibilidade', 21),
(22, 'O hóspede deve fornecer informações de chegada com pelo menos 24 horas de antecedência', 22),
(23, 'O uso da piscina é permitido apenas durante o horário de funcionamento', 23),
(24, 'Não são permitidos animais domésticos sem autorização prévia', 24),
(25, 'A utilização da área de lazer é permitida apenas para os hóspedes registrados', 25),
(26, 'A propriedade não se responsabiliza por objetos esquecidos durante a estadia', 26),
(27, 'A vigilância por câmeras de segurança é feita apenas em áreas externas', 27),
(28, 'O uso de roupas de cama e banho é exclusivo da propriedade', 28),
(29, 'Os hóspedes devem cumprir as normas de segurança contra incêndio', 29),
(30, 'É proibido o uso de drogas ilícitas nas dependências da propriedade', 30);

-- Inserção de dados na tabela quartos
INSERT INTO quartos (id_quarto, tipo_camas, banheiro_privativo, qtd_camas, id_propriedade)
VALUES
(1, 'Cama de casal', TRUE, 1, 1),
(2, 'Cama de solteiro', FALSE, 2, 1),
(3, 'Cama de casal', TRUE, 1, 2),
(4, 'Cama de solteiro', TRUE, 2, 2),
(5, 'Cama de casal', FALSE, 1, 3),
(6, 'Cama de solteiro', FALSE, 1, 3),
(7, 'Cama de casal', TRUE, 2, 4),
(8, 'Cama de solteiro', TRUE, 3, 4),
(9, 'Cama de casal', FALSE, 1, 5),
(10, 'Cama de solteiro', TRUE, 2, 5),
(11, 'Cama de casal', TRUE, 1, 6),
(12, 'Cama de solteiro', FALSE, 1, 6),
(13, 'Cama de casal', TRUE, 2, 7),
(14, 'Cama de solteiro', TRUE, 3, 7),
(15, 'Cama de casal', FALSE, 2, 8),
(16, 'Cama de solteiro', TRUE, 1, 8),
(17, 'Cama de casal', TRUE, 2, 9),
(18, 'Cama de solteiro', FALSE, 1, 9),
(19, 'Cama de casal', TRUE, 1, 10),
(20, 'Cama de solteiro', TRUE, 2, 10),
(21, 'Cama de casal', FALSE, 2, 11),
(22, 'Cama de solteiro', TRUE, 1, 11),
(23, 'Cama de casal', TRUE, 2, 12),
(24, 'Cama de solteiro', TRUE, 3, 12),
(25, 'Cama de casal', FALSE, 1, 13),
(26, 'Cama de solteiro', TRUE, 2, 13),
(27, 'Cama de casal', TRUE, 2, 14),
(28, 'Cama de solteiro', FALSE, 3, 14),
(29, 'Cama de casal', TRUE, 1, 15),
(30, 'Cama de solteiro', TRUE, 2, 15),
(31, 'Cama de casal', TRUE, 2, 16),
(32, 'Cama de solteiro', FALSE, 1, 16),
(33, 'Cama de casal', TRUE, 1, 17),
(34, 'Cama de solteiro', TRUE, 2, 17),
(35, 'Cama de casal', FALSE, 1, 18),
(36, 'Cama de solteiro', FALSE, 1, 18),
(37, 'Cama de casal', TRUE, 2, 19),
(38, 'Cama de solteiro', TRUE, 3, 19),
(39, 'Cama de casal', FALSE, 1, 20),
(40, 'Cama de solteiro', TRUE, 2, 20),
(41, 'Cama de casal', TRUE, 1, 21),
(42, 'Cama de solteiro', FALSE, 1, 21),
(43, 'Cama de casal', TRUE, 2, 22),
(44, 'Cama de solteiro', TRUE, 3, 22),
(45, 'Cama de casal', FALSE, 2, 23),
(46, 'Cama de solteiro', TRUE, 1, 23),
(47, 'Cama de casal', TRUE, 2, 24),
(48, 'Cama de solteiro', FALSE, 1, 24),
(49, 'Cama de casal', TRUE, 1, 25),
(50, 'Cama de solteiro', TRUE, 2, 25),
(51, 'Cama de casal', FALSE, 2, 26),
(52, 'Cama de solteiro', TRUE, 1, 26),
(53, 'Cama de casal', TRUE, 2, 27),
(54, 'Cama de solteiro', TRUE, 3, 27),
(55, 'Cama de casal', FALSE, 1, 28),
(56, 'Cama de solteiro', FALSE, 1, 28),
(57, 'Cama de casal', TRUE, 2, 29),
(58, 'Cama de solteiro', TRUE, 2, 29),
(59, 'Cama de casal', TRUE, 1, 30),
(60, 'Cama de solteiro', TRUE, 2, 30);

-- Inserção de dados na tabela comodidades
INSERT INTO comodidades (id_comodidade, nome, id_propriedade)
VALUES
(1, 'Wi-Fi', 1),
(2, 'Ar condicionado', 2),
(3, 'Piscina', 3),
(4, 'Cozinha equipada', 4),
(5, 'Estacionamento', 5),
(6, 'Aquecedor', 6),
(7, 'Lava-louças', 7),
(8, 'Churrasqueira', 8),
(9, 'Banheira', 9),
(10, 'TV a cabo', 10),
(11, 'Micro-ondas', 11),
(12, 'Lavadora de roupas', 12),
(13, 'Secadora de roupas', 13),
(14, 'Espaço para eventos', 14),
(15, 'Elevador', 15),
(16, 'Academia', 16),
(17, 'Quartos com varanda', 17),
(18, 'Forno', 18),
(19, 'Ferro de passar', 19),
(20, 'Serviço de limpeza', 20),
(21, 'Toalhas e lençóis', 21),
(22, 'Área de lazer', 22),
(23, 'Café da manhã incluso', 23),
(24, 'Frigobar', 24),
(25, 'Cama extra', 25),
(26, 'Fogão', 26),
(27, 'Ventilador', 27),
(28, 'Jardim', 28),
(29, 'Suporte para bagagem', 29),
(30, 'Serviço de transporte', 30),
(31, 'Travesseiros extras', 1),
(32, 'Secador de cabelo', 2),
(33, 'Detector de fumaça', 3),
(34, 'Kit de primeiros socorros', 4),
(35, 'Roupões', 5),
(36, 'Mesa de trabalho', 6),
(37, 'Tapetes antialérgicos', 7),
(38, 'Berço disponível', 8),
(39, 'Vista para o mar', 9),
(40, 'Serviço de quarto', 10),
(41, 'Cofre', 11),
(42, 'Espelho de corpo inteiro', 12),
(43, 'Ambiente climatizado', 13),
(44, 'Sistema de som ambiente', 14),
(45, 'Smart TV', 15),
(46, 'Iluminação natural', 16),
(47, 'Cobertores extras', 17),
(48, 'Purificador de ar', 18),
(49, 'Cadeiras reclináveis', 19),
(50, 'Área externa privativa', 20),
(51, 'Tomada perto da cama', 21),
(52, 'Fechadura eletrônica', 22),
(53, 'Utensílios de cozinha', 23),
(54, 'Isolamento acústico', 24),
(55, 'Espaço kids', 25),
(56, 'Filtro de água', 26),
(57, 'Rádio-relógio', 27),
(58, 'Banheiro adaptado', 28),
(59, 'Lareira', 29),
(60, 'Chaleira elétrica', 30),
(61, 'Mesa de jantar', 1),
(62, 'Produtos de higiene', 2),
(63, 'Entrada privativa', 3),
(64, 'Caixa de som Bluetooth', 4),
(65, 'Controle de temperatura', 5),
(66, 'Toalheiro aquecido', 6),
(67, 'Máquina de café', 7),
(68, 'Cortinas blackout', 8),
(69, 'Relógio despertador', 9),
(70, 'Varal de roupas', 10),
(71, 'Acesso por elevador', 11),
(72, 'Roteador dedicado', 12),
(73, 'Assentos ergonômicos', 13),
(74, 'TV com streaming', 14),
(75, 'Sala de estar', 15),
(76, 'Painéis solares', 16),
(77, 'Piso aquecido', 17),
(78, 'Conjunto de panelas', 18),
(79, 'Ventilação natural', 19),
(80, 'Garrafa de água cortesia', 20),
(81, 'Espreguiçadeiras', 21),
(82, 'Tomadas USB', 22),
(83, 'Caixa térmica', 23),
(84, 'Vassoura e rodo', 24),
(85, 'Janela panorâmica', 25),
(86, 'Tábua de passar', 26),
(87, 'Luz de leitura', 27),
(88, 'Cesto de roupas', 28),
(89, 'Luminária de cabeceira', 29),
(90, 'Câmera de segurança', 30);

-- Inserção de dados na tabela datas_disponiveis
INSERT INTO datas_disponiveis (id_data, data_, id_propriedade)
VALUES
(1, '2025-05-10', 1),
(2, '2025-05-11', 1),
(3, '2025-05-12', 2),
(4, '2025-05-13', 2),
(5, '2025-05-14', 2),
(6, '2025-05-15', 3),
(7, '2025-05-16', 3),
(8, '2025-05-17', 3),
(9, '2025-05-18', 4),
(10, '2025-05-19', 4),
(11, '2025-05-20', 5),
(12, '2025-05-21', 5),
(13, '2025-05-22', 5),
(14, '2025-05-23', 6),
(15, '2025-05-24', 6),
(16, '2025-05-25', 7),
(17, '2025-05-26', 7),
(18, '2025-05-27', 8),
(19, '2025-05-28', 8),
(20, '2025-05-29', 9),
(21, '2025-05-30', 9),
(22, '2025-05-31', 10),
(23, '2025-06-01', 10),
(24, '2025-06-02', 11),
(25, '2025-06-03', 11),
(26, '2025-06-04', 12),
(27, '2025-06-05', 12),
(28, '2025-06-06', 13),
(29, '2025-06-07', 13),
(30, '2025-06-08', 14),
(31, '2025-06-09', 14),
(32, '2025-06-10', 15),
(33, '2025-06-11', 15),
(34, '2025-06-12', 16),
(35, '2025-06-13', 16),
(36, '2025-06-14', 17),
(37, '2025-06-15', 17),
(38, '2025-06-16', 18),
(39, '2025-06-17', 18),
(40, '2025-06-18', 19),
(41, '2025-06-19', 19),
(42, '2025-06-20', 20),
(43, '2025-06-21', 20),
(44, '2025-06-22', 21),
(45, '2025-06-23', 21),
(46, '2025-06-24', 22),
(47, '2025-06-25', 22),
(48, '2025-06-26', 23),
(49, '2025-06-27', 23),
(50, '2025-06-28', 24),
(51, '2025-06-29', 24),
(52, '2025-06-30', 25);

-- Inserção de dados na tabela reserva
INSERT INTO reserva (id_reserva, data_reserva, data_check_in, data_check_out, n_hospedes, imposto_pago, taxa_limpeza, preco_estadia, preco_total, status, id_propriedade, id_usuario)
VALUES 
(1, '2025-05-01', '2025-05-05', '2025-05-10', 2, 50, 30, 200, 300, 'Confirmada', 1, 11),
(2, '2025-05-02', '2025-05-06', '2025-05-08', 1, 20, 25, 100, 145, 'Confirmada', 2, 11),
(3, '2025-05-03', '2025-05-07', '2025-05-09', 3, 30, NULL, 150, 215, 'Pendente', 3, 12),
(4, '2025-05-04', '2025-05-08', '2025-05-12', 2, NULL, 40, 180, 260, 'Confirmada', 4, 14),
(5, '2025-05-05', '2025-05-09', '2025-05-11', 2, 15, 20, NULL, 125, 'Cancelada', 5, 14),
(6, '2025-05-06', '2025-05-10', '2025-05-15', 1, 10, 30, 120, NULL, 'Confirmada', 6, 15),
(7, '2025-05-07', '2025-05-11', '2025-05-13', 4, 60, 50, 250, 360, 'Confirmada', 7, 16),
(8, '2025-05-08', '2025-05-12', '2025-05-14', 2, NULL, 20, 100, 145, 'Pendente', 8, 18),
(9, '2025-05-09', '2025-05-13', '2025-05-15', 1, 20, NULL, 120, 170, 'Confirmada', 9, 19),
(10, '2025-06-10', '2025-06-14', '2025-06-18', 5, 80, 60, NULL, 440, 'Confirmada', 10, 19),
(11, '2025-06-11', '2025-06-15', '2025-06-17', 3, 35, 30, 150, NULL, 'Cancelada', 11, 20),
(12, '2025-06-12', '2025-06-16', '2025-06-18', 2, 30, 25, 140, 195, 'Confirmada', 12, 21),
(13, '2025-06-13', '2025-06-17', '2025-06-19', 4, 45, 40, 200, 285, 'Pendente', 13, 23),
(14, '2025-06-14', '2025-06-18', '2025-06-20', 2, 20, 30, 110, 160, 'Confirmada', 14, 23),
(15, '2025-06-15', '2025-06-19', '2025-06-21', 1, 10, 15, 80, 105, 'Confirmada', 15, 24),
(16, '2025-06-16', '2025-06-20', '2025-06-22', 3, 25, 25, 130, 180, 'Cancelada', 16, 25),
(17, '2025-06-17', '2025-06-21', '2025-06-23', 2, 40, NULL, 150, 225, 'Confirmada', 17, 27),
(18, '2025-06-18', '2025-06-22', '2025-06-24', 4, 60, 55, 230, 345, 'Confirmada', 18, 27),
(19, '2025-06-19', '2025-06-23', '2025-06-25', 1, 10, 20, 90, NULL, 'Pendente', 19, 28),
(20, '2025-06-20', '2025-06-24', '2025-06-26', 3, 30, NULL, 140, 200, 'Confirmada', 20, 30),
(21, '2025-06-21', '2025-06-25', '2025-06-27', 2, 25, 20, NULL, 145, 'Cancelada', 21, 30),
(22, '2025-06-22', '2025-06-26', '2025-06-30', 1, 10, 25, 110, 145, 'Confirmada', 22, 31),
(23, '2025-05-23', '2025-05-27', '2025-05-29', 3, NULL, 35, 140, 205, 'Confirmada', 23, 32),
(24, '2025-05-24', '2025-05-28', '2025-06-01', 5, 70, 60, 300, 430, 'Confirmada', 24, 33),
(25, '2025-05-25', '2025-05-29', '2025-05-31', 2, 20, 25, NULL, 145, 'Cancelada', 50, 35),
(26, '2025-05-26', '2025-05-30', '2025-06-01', 1, NULL, 15, 90, 115, 'Confirmada', 26, 35),
(31, '2025-05-01', '2025-05-05', '2025-05-10', 2, 50, 30, 200, 300, 'Confirmada', 31, 11),
(32, '2025-05-02', '2025-05-06', '2025-05-08', 1, 20, 25, 100, 145, 'Confirmada', 32, 11),
(33, '2025-05-03', '2025-05-07', '2025-05-09', 3, 30, NULL, 150, 215, 'Pendente', 33, 12),
(34, '2025-05-04', '2025-05-08', '2025-05-12', 2, NULL, 40, 180, 260, 'Confirmada', 34, 14),
(35, '2025-07-05', '2025-07-09', '2025-07-11', 2, 15, 20, NULL, 125, 'Cancelada', 35, 14),
(36, '2025-07-06', '2025-07-10', '2025-07-15', 1, 10, 30, 120, NULL, 'Confirmada', 36, 15),
(37, '2025-07-07', '2025-07-11', '2025-07-13', 4, 60, 50, 250, 360, 'Confirmada', 37, 16),
(38, '2025-07-08', '2025-07-12', '2025-07-14', 2, NULL, 20, 100, 145, 'Pendente', 38, 18),
(39, '2025-07-09', '2025-07-13', '2025-07-15', 1, 20, NULL, 120, 170, 'Confirmada', 39, 19),
(40, '2025-07-10', '2025-07-14', '2025-07-18', 5, 80, 60, NULL, 440, 'Confirmada', 40, 19),
(41, '2025-07-11', '2025-07-15', '2025-07-17', 3, 35, 30, 150, NULL, 'Cancelada', 41, 20),
(42, '2025-07-12', '2025-07-16', '2025-07-18', 2, 30, 25, 140, 195, 'Confirmada', 42, 21),
(43, '2025-07-13', '2025-07-17', '2025-07-19', 4, 45, 40, 200, 285, 'Pendente', 43, 23),
(44, '2025-05-14', '2025-05-18', '2025-05-20', 2, 20, 30, 110, 160, 'Confirmada', 44, 23),
(45, '2025-05-15', '2025-05-19', '2025-05-21', 1, 10, 15, 80, 105, 'Confirmada', 45, 24),
(46, '2025-05-16', '2025-05-20', '2025-05-22', 3, 25, 25, 130, 180, 'Cancelada', 46, 25),
(47, '2025-05-17', '2025-05-21', '2025-05-23', 2, 40, NULL, 150, 225, 'Confirmada', 47, 27),
(48, '2025-05-18', '2025-05-22', '2025-05-24', 4, 60, 55, 230, 345, 'Confirmada', 48, 27),
(49, '2025-05-19', '2025-05-23', '2025-05-25', 1, 10, 20, 90, NULL, 'Pendente', 49, 28),
(50, '2025-05-20', '2025-05-24', '2025-05-26', 3, 30, NULL, 140, 200, 'Confirmada', 50, 30),
(51, '2025-05-21', '2025-05-25', '2025-05-27', 2, 25, 20, NULL, 145, 'Cancelada', 51, 30);

-- Inserção de dados na tabela conta_bancaria
INSERT INTO conta_bancaria (n_conta, n_agencia, tipo_conta, id_usuario)
VALUES
('100001', '1234', 'Corrente', 10),
('100003', '3456', 'Corrente', 12),
('100005', '5678', 'Poupança', 13),
('100006', '6789', 'Corrente', 15),
('100007', '7890', 'Poupança', 15),
('100008', '8901', 'Corrente', 18),
('100009', '9012', 'Poupança', 18),
('100011', '2233', 'Poupança', 20),
('100012', '3344', 'Corrente', 22),
('100014', '5566', 'Poupança', 23),
('100015', '6677', 'Corrente', 25),
('100016', '7788', 'Poupança', 25),
('100017', '8899', 'Corrente', 26),
('100019', '1010', 'Corrente', 28),
('100020', '1212', 'Corrente', 29),
('100021', '1313', 'Poupança', 30),
('100023', '1515', 'Corrente', 32),
('100025', '1717', 'Corrente', 34),
('100026', '1818', 'Corrente', 35),
('100027', '1919', 'Poupança', 36),
('100029', '2121', 'Poupança', 38),
('100030', '2222', 'Corrente', 39);

-- Inserção de dados na tabela mensagem
INSERT INTO mensagem (id_mensagem, timestamp_, texto, id_remetente, id_destinatario)
VALUES
(1, '2025-05-01 10:05:12', 'Olá, gostaria de confirmar a reserva para o próximo fim de semana!', 10, 11),
(2, '2025-05-02 11:12:45', 'Sua propriedade está incrível, vamos agendar para o mês que vem.', 12, 13),
(3, '2025-05-02 14:21:33', 'Gostaria de saber mais sobre o preço para 3 pessoas em novembro.', 13, 14),
(4, '2025-05-03 09:32:08', 'O check-in foi ótimo, muito obrigado pela hospitalidade!', 14, 15),
(5, '2025-05-03 16:42:25', 'Estamos pensando em alterar as datas do check-in, você tem disponibilidade?', 15, 16),
(6, '2025-05-04 08:05:59', 'Eu gostaria de cancelar minha reserva para a próxima semana.', 16, 17),
(7, '2025-05-05 10:15:27', 'Oi, tem como me enviar mais fotos da casa?', 17, 18),
(8, '2025-05-06 11:24:36', 'Estou esperando uma confirmação para o pagamento, você pode ajudar?', 18, 19),
(9, '2025-05-06 15:30:19', 'A casa tem piscina? Gostaria de mais detalhes.', 19, 20),
(10, '2025-05-07 18:00:47', 'Tivemos um pequeno problema com a reserva, pode nos ajudar a resolver?', 20, 21),
(11, '2025-05-08 09:15:02', 'Olá, gostaria de saber se há estacionamento disponível para hóspedes.', 21, 22),
(12, '2025-05-08 12:40:33', 'Como faço para adicionar mais uma pessoa à minha reserva?', 22, 23),
(13, '2025-05-09 10:22:19', 'Estou tendo problemas para pagar, poderia me dar alguma orientação?', 23, 24),
(14, '2025-05-10 08:56:48', 'Eu fiz uma reserva, mas não encontrei as instruções do check-in.', 24, 25),
(15, '2025-05-10 14:05:39', 'Você pode confirmar a reserva para o próximo fim de semana?', 25, 26),
(16, '2025-05-11 09:05:59', 'Oi, tem alguma recomendação de restaurantes próximos?', 26, 27),
(17, '2025-05-12 11:42:14', 'Estou com dúvidas sobre o processo de cancelamento, poderia me explicar?', 27, 28),
(18, '2025-05-13 10:10:30', 'Preciso mudar a data do meu check-in. Existe disponibilidade?', 28, 29),
(19, '2025-05-13 13:17:58', 'Gostaria de saber mais sobre o bairro onde a propriedade está localizada.', 29, 30),
(20, '2025-05-14 09:20:05', 'Estou em busca de uma propriedade para 4 pessoas, o que você tem disponível?', 30, 31),
(21, '2025-05-14 15:25:19', 'Você aceita animais de estimação em sua propriedade?', 31, 32),
(22, '2025-05-15 08:45:13', 'Quais são as opções de transporte público para a região?', 32, 33),
(23, '2025-05-16 09:05:59', 'Gostaria de saber se há Wi-Fi disponível no local.', 33, 34),
(24, '2025-05-16 14:33:11', 'O valor da diária é fixo ou há variações de acordo com a temporada?', 34, 35),
(25, '2025-05-17 16:47:22', 'Você pode confirmar os detalhes do meu check-out?', 35, 36),
(26, '2025-05-18 10:18:33', 'Como funciona o pagamento da taxa de limpeza?', 36, 37),
(27, '2025-05-19 12:40:55', 'A casa oferece utensílios de cozinha? Preciso saber antes de reservar.', 37, 38),
(28, '2025-05-20 14:59:02', 'Posso adicionar mais noites à minha reserva?', 38, 39),
(29, '2025-05-21 13:27:01', 'Estou buscando informações sobre a segurança da área, você pode ajudar?', 39, 10),
(30, '2025-05-21 17:10:40', 'Gostaria de saber se a propriedade aceita pagamento via cartão de crédito.', 10, 12);

-- Inserção de dados na tabela avaliacao
INSERT INTO avaliacao (id_avaliacao, nota_limpeza, nota_estrutura, nota_comunicacao, nota_localizacao, nota_preco, id_propriedade, id_usuario, id_mensagem)
VALUES
(1, 4.5, 4.0, 5.0, 4.8, 4.2, 21, 18, 1),
(2, NULL, 3.0, 4.0, 3.8, 3.7, 17, 33, 2),
(3, 5.0, 5.0, 5.0, 5.0, 5.0, 10, 23, 3),
(4, 4.0, NULL, 4.0, 4.2, 4.3, 3, 30, 4),
(5, 2.5, 3.0, 3.0, NULL, 2.9, 28, 19, 5),
(6, 3.5, 4.0, 3.8, 4.1, 3.9, 2, 35, 6),
(7, NULL, 4.8, 4.9, 5.0, 4.7, 8, 16, 7),
(8, 4.0, 3.8, 4.5, NULL, 4.0, 5, 14, 8),
(9, 2.0, 2.5, 2.0, 2.1, 2.3, 25, 24, NULL),
(10, 4.5, 4.2, NULL, 4.4, 4.5, 6, 20, NULL),
(11, NULL, NULL, 3.5, 3.2, 3.1, 24, 27, NULL),
(12, 5.0, 4.9, 5.0, 5.0, 4.8, 9, 11, 12),
(13, 4.0, 4.0, 4.0, NULL, 4.0, 18, 38, NULL),
(14, 3.8, 3.6, 4.0, 3.9, NULL, 1, 12, 14),
(15, NULL, 2.8, 3.0, 2.7, 2.6, 11, 37, 15),
(16, 4.7, NULL, 4.6, 4.8, 4.6, 26, 27, 16),
(17, 3.5, 3.0, NULL, 3.3, 3.4, 13, 15, 17),
(18, 5.0, 5.0, 5.0, 5.0, 5.0, 30, 11, 18),
(19, 4.0, 4.1, 4.2, 4.3, 4.0, 20, 14, 19),
(20, NULL, 2.2, 2.5, NULL, 2.3, 16, 25, 20),
(21, 3.5, 3.8, 4.0, 4.0, 3.9, 22, 37, 21),
(22, 4.0, 4.0, 4.0, NULL, 4.0, 4, 30, NULL),
(23, 4.3, NULL, 4.2, 4.5, 4.1, 27, 18, 23),
(24, 2.0, 2.5, 2.8, NULL, 2.6, 7, 32, 24),
(25, 5.0, 5.0, 4.9, 5.0, 5.0, 12, 31, NULL),
(26, NULL, 3.8, NULL, 3.6, 3.5, 14, 28, NULL),
(27, 4.0, 4.1, 4.3, 4.2, 4.0, 19, 39, NULL),
(28, 3.0, 3.2, 3.0, 3.1, NULL, 23, 35, NULL),
(29, 4.9, 5.0, NULL, 4.9, 5.0, 29, 21, 29),
(30, 2.5, 2.5, 2.5, 2.5, 2.5, 15, 23, 30);

-- Inserção de dados na tabela fotos
INSERT INTO fotos (id_foto, foto, id_avaliacao, id_propriedade, id_usuario)
VALUES
(1, 'foto1.jpg', 1, 21, 18),
(2, 'foto2.jpg', 2, 17, 33),
(3, 'foto3.jpg', 3, 10, 23),
(4, 'foto4.jpg', 4, 3, 30),
(5, 'foto5.jpg', 5, 28, 19),
(6, 'foto6.jpg', 6, 2, 35),
(7, 'foto7.jpg', 7, 8, 16),
(8, 'foto8.jpg', 8, 5, 14),
(9, 'foto9.jpg', 9, 25, 24),
(10, 'foto10.jpg', 10, 6, 20),
(11, 'foto11.jpg', 11, 24, 27),
(12, 'foto12.jpg', 12, 19, 11),
(13, 'foto13.jpg', 13, 18, 38),
(14, 'foto14.jpg', 14, 1, 12),
(15, 'foto15.jpg', 15, 11, 37),
(16, 'foto16.jpg', 16, 26, 27),
(17, 'foto17.jpg', 17, 13, 15),
(18, 'foto18.jpg', 18, 30, 11),
(19, 'foto19.jpg', 19, 20, 14),
(20, 'foto20.jpg', 20, 16, 25);
