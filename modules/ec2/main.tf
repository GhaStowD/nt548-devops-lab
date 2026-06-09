# =================================================================
# 1. TỰ ĐỘNG TÌM AMI UBUNTU 22.04 LTS MỚI NHẤT
# =================================================================
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # ID của Canonical (nhà phát triển Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# =================================================================
# 2. TỰ ĐỘNG KHAI BÁO KEY PAIR LÊN AWS
# =================================================================
resource "aws_key_pair" "deployer" {
  key_name = "my-aws-key"

  # Đọc file public key nằm cùng thư mục module ec2 này
  public_key = file("${path.module}/id_rsa.pub")
}

# =================================================================
# 3. TẠO PUBLIC EC2 (BASTION HOST)
# =================================================================
resource "aws_instance" "public_ec2" {
  ami                    = data.aws_ami.ubuntu.id # Dùng AMI tự động tìm
  instance_type          = "t3.micro"             # <--- Đã sửa thành t3.micro để hợp lệ gói Free Tier
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = aws_key_pair.deployer.key_name # Dùng Key Pair tự động tạo ở trên

  tags = { Name = "Public-EC2-Instance" }
}

# =================================================================
# 4. TẠO PRIVATE EC2
# =================================================================
resource "aws_instance" "private_ec2" {
  ami                    = data.aws_ami.ubuntu.id # Dùng AMI tự động tìm
  instance_type          = "t3.micro"             # để hợp lệ gói Free Tier
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = aws_key_pair.deployer.key_name # Dùng Key Pair tự động tạo ở trên

  tags = { Name = "Private-EC2-Instance" }
}