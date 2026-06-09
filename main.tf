# Gọi module VPC
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = "ap-southeast-1a"
}

# Gọi module Security Groups
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id # Lấy từ output của module vpc
  my_ip  = var.my_ip         # IP mạng hiện tại 
}

# Gọi module EC2
module "ec2" {
  source   = "./modules/ec2"
  ami_id   = var.ami_id   # ID của Ubuntu hoặc Amazon Linux 2
  key_name = var.key_name # Key pair tạo trên AWS để SSH

  # Lấy dữ liệu truyền từ module vpc sang:
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  # Lấy dữ liệu truyền từ module security_groups sang:
  public_sg_id  = module.security_groups.public_sg_id
  private_sg_id = module.security_groups.private_sg_id
}