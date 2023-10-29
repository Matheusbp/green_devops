
# Hackweek Devs2Blu time DevOps 💻

## Introdução 📈

O time DevOps foi responsável pela "dockerização" da aplicação Backend (em C#).

Este README explica:
- A Dockerização das aplicações em C#.
 - O provisionamento da máquina na AWS utilizando Terraform;
 - Como as imagens Docker foram buildadas e todo o mapeamento de portas utilizado com Docker-Compose e fazendo o acesso via Ansible;  - 

**Ao dar push na main, automaticamente inicia-se os processos citados aqui.**

Para provisionar a máquina EC2 na AWS é necessário: 

1.  **Criação do repositório**
	- Criar um repositório no github com .gitignore contendo as chaves geradas (id_rsa e id_rsa.pub) que possibilitarão seu acesso via ansible.
	
2. **Criação de arquivos auxiliares**
	- Cria-se um arquivo inventory.ini vazio na pasta base que será populado, este arquivo é importante pois guardará informações da máquina que está sendo provisionada;

3. **Criar secrets no github para acessarmos a máquina e o Banco de Dados**
	- No repositório adicionar as seguintes secrets em > settings > Security > Secrets and variables > Actions: 
		- AWS_ACCESS_KEY_ID - Chave de acesso da nossa AWS;
		- AWS_SECRET_ACCESS_KEY - Senha da chave de acesso da conta AWS;
		- SSH_PRIVATE_KEY - Informações da nossa chave id_rsa privada;
		- SSH_PUBLIC_KEY - Informações da nossa chave id_rsa.pub;
		- APPSETTINGS - Aqui é o conteúdo do arquivo appsettings.json que guarda as informações de acesso ao banco de dados criados pelo backend.


## Provisionamento da máquina na AWS com Terraform

A seguir tem-se a documentação do arquivo **provisioning.yml** que provisiona a máquia EC2 na AWS.
		
1.  **Checkout do Repositório**:
    
    -   A ação "Checkout code" é usada para obter o código do repositório no qual o workflow está sendo executado.
2.  **Criação de um Bucket S3 AWS**:
    
    -   Cria um bucket S3 na região 'us-east-1' para armazenar o arquivo terraform.tfstate.
3.  **Configuração das Chaves SSH na Instância Provisionada**:
    
    -   Configura as chaves SSH na instância que está sendo provisionada, permitindo acesso seguro.
4.  **Configuração do Terraform**:
    
    -   Configura o ambiente para uso do Terraform.
5.  **Inicialização do Terraform**:
    
    -   Inicializa o Terraform no ambiente de trabalho.
6.  **Aplicação do Terraform**:
    
	   -  Aplica as configurações do Terraform para criar a infraestrutura especificada.
    
7.  **Aguarda a Instância Ficar Pronta**:
    
	  - Espera 20 segundos para garantir que a instância AWS esteja pronta.
8.  **Definição da Variável de Ambiente INSTANCE_IP**:
    
	  - Define a variável de ambiente "instance_ip" com o valor da saída "instance_ip" do arquivo outputs.tf do Terraform.
9.  **Verificação do Status da Instância EC2**:
	- Monitora o status da instância EC2. Se ela estiver pronta, o fluxo de trabalho continua.

11.  **Instalação do Ansible**:
	 - Instala o Ansible para viabilizar o acesso e configuração da máquina provisionada.
	
12.  **Configuração do Arquivo de Inventário Ansible**:
		-  Popula-se o inventário do Ansible chamado "inventory.ini" com o endereço IP da instância criada.

14.  **Adição da Chave Pública do Servidor Remoto**:    
	    - Escaneia a chave pública do servidor remoto (instância EC2) e a adiciona ao arquivo "known_hosts" para estabelecer uma conexão segura.
15.  **Execução do Playbook Ansible**:
		- Executa o playbook Ansible "ansible-playbook-install-docker.yml" na instância criada, usando o arquivo de inventário "inventory.ini" e a chave privada SSH para acesso.