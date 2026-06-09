output "public_instance_ip" {
  value       = aws_instance.public_ec2.public_ip
  description = "Địa chỉ IP công cộng của máy Public EC2"
}
output "private_instance_ip" {
  value       = aws_instance.private_ec2.private_ip
  description = "Địa chỉ IP nội bộ của máy Private EC2 để SSH từ Bastion Host"
}