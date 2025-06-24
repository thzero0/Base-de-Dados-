# README - Orientações de uso

## Inicialização do PostgreSQL + pgAdmin com Docker Compose

Este ambiente Docker Compose levanta dois containers:

- PostgreSQL: Banco de dados relacional

- pgAdmin: Interface gráfica para gerenciar o banco de dados

### Pré-requisitos

- Docker instalado
- Docker Compose instalado

### Como subir os containers

1. Abra um terminal no mesmo diretório onde está localizado o arquivo `postgres.yaml`.
2. Execute o comando abaixo para iniciar os serviços:

```bash
docker compose -f postgres.yaml up -d
```

Este comando vai baixar as imagens necessárias (caso ainda não estejam localmente) e iniciar os containers definidos.
Como acessar o pgAdmin

Após os containers subirem, abra seu navegador e acesse:

```bash
localhost:5050
```

### Utilizando o PgAdmin

Faça login usando as credenciais definidas no docker-compose:

- E-mail: <admin@admin.com>

- Senha: admin

Depois de logado, clique em “Add New Server” (Adicionar novo servidor).

Na aba “General”, digite um nome qualquer para o servidor (ex: trabalho3).

Vá até a aba “Connection” e preencha os campos assim:

- Host name/address: db

- Port: 5432

- Maintenance database: trabalhofinal

- Username: postgres

- Password: pgadmin

Clique em “Save” e você estará conectado ao banco!

### Atenção

- As queries devem ser executadas separadamente para evitar erros.

- As únicas ações feitas pelo notebook `.ipynb` são a criação da base de dados e o populate dos dados em grande escala, porém, as queries, criação de índices, popular a base de dados para o indexamento e a criação de views são feitas diretamente pelas queries usando os arquivos `.sql` no pgAdmin.

- Antes de usar as queries do `testIndex.sql`, é necessário executar as queries do create e do populate antes, por meio de respectivamente os arquivos `CreateIndex.sql` e `populateIndex.sql`.

### 🛑 Como parar os containers

Para derrubar os containers, execute:

```bash
docker compose -f postgres.yaml down
```

Isso irá parar e remover os containers, mas os dados persistem nos volumes (postgres_data e pgadmin_data).

- Caso queira excluir os volumes, adicione a flag -v ao final do comando

- o Trabalho foi previamente testanto utilizando o PgAdmin e datagrip.
