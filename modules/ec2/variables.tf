variable "ami_id" {
  type        = string
  description = "ID của hệ điều hành (AMI)"
}

variable "key_name" {
  type        = string
  description = "Tên cặp khóa Key Pair để SSH"
}

variable "public_subnet_id" {
  type        = string
  description = "ID Subnet công cộng lấy từ module vpc"
}

variable "private_subnet_id" {
  type        = string
  description = "ID Subnet riêng tư lấy từ module vpc"
}

variable "public_sg_id" {
  type        = string
  description = "ID nhóm bảo mật công cộng lấy từ module security_groups"
}

variable "private_sg_id" {
  type        = string
  description = "ID nhóm bảo mật riêng tư lấy từ module security_groups"
}