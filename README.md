

<h2>Guia de Instalação e Execução do Projeto</h2>

Pré-requisitos Essenciais
Antes de começar, certifique-se de que sua máquina tenha os seguintes softwares instalados:

*Git: Para clonar o repositório.
*Docker: Incluindo o Docker Compose.

Instalação

* Clonagem do Repositório
Abra seu terminal e clone o código-fonte do projeto usando Git:

git clone https://github.com/victor9743/parser_eml.git
cd parser_eml

* Configuração do Docker Compose
O arquivo docker-compose.yml define três serviços: web (Rails), db (PostgreSQL) e redis.
Rode os comandos para criar a imagem Docker para o serviço web (Rails) e iniciar todos os serviços em segundo plano:
<pre>
docker compose build
docker compose up -d
</pre>

* Configuração do Banco de Dados
Execute estes comandos no terminal, direcionando-os para o container web:

# Cria o banco de dados
docker compose exec web bundle exec rails db:create

# Executa as migrações (cria as tabelas)
docker compose exec web bundle exec rails db:migrate

* Execução e Uso
A aplicação Rails está disponível no navegador:

URL: http://localhost:3000

* Execução de Testes (RSpec)
Para rodar todos os testes e confirmar que o ambiente está configurado corretamente (incluindo a integração com o Sidekiq/Redis no modo de teste):

docker compose exec web bundle exec rspec