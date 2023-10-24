terraform {
  backend "s3" {
    bucket         = "bucket-more-green"  # Nome do bucket S3 onde o estado do Terraform será armazenado
    key            = "terraform.tfstate"  # Nome do arquivo no bucket que conterá o estado do Terraform
    region         = "us-east-1" # Região da AWS onde o bucket S3 está localizado
    encrypt        = true # Habilitar a criptografia do estado do Terraform
    
  }
}
