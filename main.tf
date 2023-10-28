provider "aws" {
  region = "us-east-1"  # Escolha a região que preferir
}

# Definindo ou criando (caso ela não exista) um grupo de segurança (Security Group) na AWS
resource "aws_security_group" "security_group_more_green" {
  name        = "security_group_more_green"
  description = "Security Group para SSH, HTTP e porta 8000"

# Regras de ingresso que permitem o tráfego de entrada
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para SSH
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para HTTP
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para a porta 8000
  }

  ingress {
    from_port   = 8081
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para a porta 8082
  }

  ingress {
    from_port   = 8082
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para a porta 8000
  }

  ingress {
    from_port   = 5008
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite qualquer endereço IP para a porta 5008
  }

  # Regra de saída que permite todo o tráfego de saída

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Permite todo o tráfego de saída
  }
}

# Definindo uma instância EC2 na AWS
resource "aws_instance" "vm_more_green" {
  ami           = "ami-053b0d53c279acc90"  # AMI do Ubuntu 18.04
  instance_type = "t2.micro"  # Tipo de instância
  key_name      = aws_key_pair.keypair_more_green.key_name # Chave SSH para acessar a instância

  vpc_security_group_ids = [aws_security_group.security_group_more_green.id] # Associando o grupo de segurança à instância

  # Configurando o script de inicialização da instância
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y software-properties-common
              sudo apt-add-repository --yes --update ppa:ansible/ansible
              sudo apt-get install -y ansible
              EOF

  tags = {
    Name = "vm_more_green"
    Environment = "dev"
    Application = "backend"
    Class = "DevOps"    
  }
}
