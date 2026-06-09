variable "vpc_cidr" {
  type        = string
  description = "Dải IP cho VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Dải IP cho Public Subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Dải IP cho Private Subnet"
}

variable "az" {
  type        = string
  description = "Availability Zone để triển khai"
}