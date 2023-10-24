provider "aws" {
  region = "us-east-1"  # Escolha a região que preferir
}

# Definindo um grupo de segurança (Security Group) na AWS
resource "aws_security_group" "security_group_g4_matheus" {
  name        = "security-group-g4-matheus"
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

  # Regra de saída que permite todo o tráfego de saída

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Permite todo o tráfego de saída
  }
}

# Definindo uma instância EC2 na AWS
resource "aws_instance" "pc_hackweek_g4_matheus" {
  ami           = "ami-053b0d53c279acc90"  # AMI do Ubuntu 18.04
  instance_type = "t2.micro"  # Tipo de instância
  key_name      = aws_key_pair.keypair_hackweek_chave_matheus.key_name # Chave SSH para acessar a instância

  vpc_security_group_ids = [aws_security_group.security_group_g4_matheus.id] # Associando o grupo de segurança à instância

  # Configurando o script de inicialização da instância
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y software-properties-common
              sudo apt-add-repository --yes --update ppa:ansible/ansible
              sudo apt-get install -y ansible
              EOF

  tags = {
    Name = "pc-hackweek-g4-matheus"
    Environment = "dev"
    Application = "backend"
    Class = "DevOps"    
  }
}
