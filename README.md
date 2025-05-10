# 📚 README - Orientações de uso

## 🚀 Inicialização do PostgreSQL + pgAdmin com Docker Compose

Este ambiente Docker Compose levanta dois containers:

- PostgreSQL: Banco de dados relacional

- pgAdmin: Interface gráfica para gerenciar o banco de dados

### ⚙️ Pré-requisitos

- Docker instalado
- Docker Compose instalado

### 🌐 Como subir os containers

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

### 🛠️ Utilizando o PgAdmin
Faça login usando as credenciais definidas no docker-compose:

- E-mail: admin@admin.com

- Senha: admin

Depois de logado, clique em “Add New Server” (Adicionar novo servidor).

Na aba “General”, digite um nome qualquer para o servidor (ex: trabalho3).

Vá até a aba “Connection” e preencha os campos assim:

- Host name/address: db

- Port: 5432

- Maintenance database: trabalho3

- Username: postgres

- Password: pgadmin

Clique em “Save” e você estará conectado ao banco!


### 🛑 Como parar os containers

Para derrubar os containers, execute:

```bash 
docker compose -f postgres.yaml down
```

Isso irá parar e remover os containers, mas os dados persistem nos volumes (postgres_data e pgadmin_data).
- Caso queira excluir os volumes, adicione a flag -v ao final do comando





