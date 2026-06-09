output "bastion_public_ip" {
  value       = module.ec2.public_instance_ip
  description = "Địa chỉ IP Public của máy Bastion Host (Public EC2) để SSH từ máy cá nhân."
}

output "private_target_ip" {
  value       = module.ec2.private_instance_ip # (Đảm bảo module ec2 đã có output này)
  description = "Địa chỉ IP nội bộ của máy Private EC2. Dùng IP này để SSH từ trong máy Bastion."
}