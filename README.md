# Billinho

O projeto da API Billinho é uma aplicação Phoenix que se conecta a um banco de dados Postgres.

Para rodar a aplicação basta executar o seguinte comando na raiz do projeto

```bash
$ make
```

Esse comando irá executar o `docker-compose`, que será o responsável por:
  - build da imagem
  - baixar as dependências
  - criar o banco de dados
  - rodar as migrations
  - rodar os testes
  - subir a aplicação na porta 4000

Para executar os testes, abra um novo terminal e execute

```bash
$ make test
```

## Postman

Após rodar a aplicação, abra o Postman e importe o arquivo `Billinho.postman_collection.json`, localizado
na raiz do projeto.
Uma coleção chamada `Billinho`, com todos os endpoints, estará disponível para agilizar a interação com a API.

Importe diretamente pelo link abaixo:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/91e2c0b91e81cdcdf574)

## Endpoints da API

```text
# Institutes
GET     /api/v1/institutes
GET     /api/v1/institutes/:id
POST    /api/v1/institutes
PATCH   /api/v1/institutes/:id
PUT     /api/v1/institutes/:id
DELETE  /api/v1/institutes/:id

# Students
GET     /api/v1/students
GET     /api/v1/students/:id
POST    /api/v1/students
PATCH   /api/v1/students/:id
PUT     /api/v1/students/:id
DELETE  /api/v1/students/:id

# Enrollments
GET     /api/v1/enrollments
GET     /api/v1/enrollments/:id
POST    /api/v1/enrollments
PATCH   /api/v1/enrollments/:id
PUT     /api/v1/enrollments/:id
DELETE  /api/v1/enrollments/:id

# Invoices
GET     /api/v1/invoices
```
