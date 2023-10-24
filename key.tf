# Define um novo recurso de par de chaves da AWS
resource "aws_key_pair" "keypair_hackweek_chave_matheus" {
  key_name   = "keypair-hackweek-chave-matheus" # Define o nome da chave, que será usado na AWS
  public_key = file("~/.ssh/id_rsa.pub") # Define a chave pública que será usada para a autenticação SSH
}
