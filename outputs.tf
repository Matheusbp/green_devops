# Este output fornece o endereço IP público da instância EC2
output "instance_ip" {
  value = aws_instance.pc_hackweek_g4_matheus.public_ip
  description = "O IP público da instância EC2"
}
# Este output fornece o ID da instância EC2
output "instance_id" {
  value = aws_instance.pc_hackweek_g4_matheus.id
}
# Este output fornece o nome de domínio público da instância EC2
output "instance_public_dns" {
  value = aws_instance.pc_hackweek_g4_matheus.public_dns
}