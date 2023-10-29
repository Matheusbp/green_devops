# Hackweek_devs2blu_devops - Passo-a-passo!
Este README explica como rodar os scripts que:
 - Provisionam as máquinas da AWS utilizando terraform;
 - Entra na máquina com o runner do github actions com SSH de forma segura;
 - clonam repositório do git com as imagens, buildam e roda.  

## Terraform provisioning

Para provisionar a máquina, entrar nela e buildar a imagem, temos que: 

1. Primeiramente criar uma chave com ssh-keygen. Ex: ssh-keygen -t rsa -b 4096 -f ./id_rsa na pasta base;
2. adicionar id_rsa e id_rsa.pub no gitignore;
3. Criar um arquivo inventory.ini vazio na pasta base;
4. Ir no github repositório > settings > Security > Secrets and variables > Actions e adicionar as variaveis lá, são elas:
	2.1 AWS_ACCESS_KEY_ID - com informações da nossa conta AWS;
	2.2 AWS_SECRET_ACCESS_KEY - com informações da nossa conta AWS;
	2.3 SSH_PRIVATE_KEY - Informações da nossa chave id_rsa privada;
	2.3 SSH_PUBLIC_KEY - Informações da nossa chave id_rsa.pub.
5.	Definir nome da instância em main.tf; 
6.	Definir nome do bucket S3 em backend.tf (local onde ficará o arquivo .tfstate que indica o estado da máquina);
7.	Definir o nome para o par de chaves utilizada na AWS em key.tf;
8.	Conferir se o nome o repositório do git está pegando a imagem correta e que as pastas estão setadas para pegar o Dockerfile e buildar.
9.	Testar a aplicação rodando na VM!

PARA COLOCAR O BD TEMOS QUE CRIAR O BD PODE SER NO WORKBENCH E AI PEGA DBUSER E DBPASS E ADICIONA ISSO NO ENV DENTRO DO LOCAL ONDE SUBIREMOS A APLICAÇÃO.

## Terraform destroy

Para destruir a instância basta dar push na branch destroy: 

1. git checkout main #Esta linha faz com que você mude para a branch chamada "main";  
2. git push origin destroy #Essa linha está enviando a branch local chamada "destroy" para o repositório remoto chamado "origin". Isso está atualizando a branch "destroy" no repositório remoto com as alterações locais;
3. git pull origin main #puxando as alterações da branch "main" do repositório remoto "origin" para a branch local em que você está atualmente. Isso ajuda a manter a branch local atualizada com as últimas alterações do repositório remoto;
4. git checkout destroy # Certifique-se de estar na branch "destroy" antes de mesclar;
5. git merge main #mesclando as alterações da branch "main" na branch atual, que é "destroy". Isso integra as alterações da branch "main" na branch "destroy";
6. git push origin destroy #ai vai desligar a instancia.