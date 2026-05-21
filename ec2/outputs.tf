# 6. Exibe o IP público da instância no console do Terraform
output "instance_public_ip" {
  description = "IP público para conectar via RDP"
  value       = aws_instance.windows_instance.public_ip
}