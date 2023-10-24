# Define um novo recurso de par de chaves da AWS
resource "aws_key_pair" "keypair_more_green" {
  key_name   = "keypair_more_green" # Define o nome da chave, que será usado na AWS
  public_key = file("~/.ssh/id_rsa.pub") # Define a chave pública que será usada para a autenticação SSH
}
