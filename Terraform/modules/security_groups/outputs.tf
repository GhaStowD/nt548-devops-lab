output "public_sg_id" {
  value       = aws_security_group.public_sg.id
  description = "ID của Security Group cho Public EC2"
}

output "private_sg_id" {
  value       = aws_security_group.private_sg.id
  description = "ID của Security Group cho Private EC2"
}