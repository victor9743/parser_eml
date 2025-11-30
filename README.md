

# Guia de Instalação e Execução do Projeto

Pré-requisitos Essenciais
Antes de começar, certifique-se de que sua máquina tenha os seguintes softwares instalados:

Git: Para clonar o repositório.<br>
Docker: Incluindo o Docker Compose.

* Clonagem do Repositório
<p>
    Abra seu terminal e clone o código-fonte do projeto usando Git:
</p>
<pre>
    git clone https://github.com/victor9743/parser_eml.git
    cd parser_eml
</pre>

* Configuração do Docker Compose
<p>
    O arquivo docker-compose.yml define três serviços: web (Rails), db (PostgreSQL) e redis.
    Rode os comandos para criar a imagem Docker para o serviço web (Rails) e iniciar todos os serviços em segundo plano:
</p>
<pre>
    docker compose build
    docker compose up -d
</pre>

* Configuração do Banco de Dados
<p>
    Execute estes comandos no terminal, direcionando-os para o container web:
</p>
# Cria o banco de dados

<pre>
    docker compose exec web bundle exec rails db:create
</pre>

# Executa as migrações (cria as tabelas)
<pre>
    docker compose exec web bundle exec rails db:migrate
</pre>

* Execução e Uso
<p>A aplicação Rails está disponível no navegador:</p>
<pre>
    URL: http://localhost:3000
</pre>

* Execução de Testes (RSpec)
<p>Para rodar todos os testes e confirmar que o ambiente está configurado corretamente (incluindo a integração com o Sidekiq/Redis no modo de teste):</p>
<pre>
    docker compose exec web bundle exec rspec
</pre>

# Como enviar um e-mail .eml para processamento.
<p> em seu ambiente vá para: <pre>incoming_emails/new</pre>. Após isso, adicione o arquivo .eml no campo .eml file e depois disso, clique em send. Ao realizar este procedimento, você será redirecionado para a rota rails do projeto.</p>

# Como visualizar os resultados (customers + logs).
<p> Cada solicitação feita, será visualizada na rota raiz do projeto. Para visualizar os resultados, clique na opção details. Nesta opção, terá
todos as informações da solicitação, inclusive os logs.Se houver algum falha na solicitação, será mostrado o retorno do erro.</p>


 