output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID của VPC vừa tạo"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "ID của Public Subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
  description = "ID của Private Subnet"
}