# 1. Tạo VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = "Main-VPC" }
}

# 2. Tạo Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "Main-IGW" }
}

# 3. Tạo Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az
  tags                    = { Name = "Public-Subnet" }
}

# 4. Tạo Elastic IP cho NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# 5. Tạo NAT Gateway (Đặt trong Public Subnet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags          = { Name = "Main-NAT-Gateway" }
}

# 6. Tạo Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az
  tags              = { Name = "Private-Subnet" }
}

# 7. Route Table cho Public Subnet (Đi qua IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "Public-Route-Table" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 8. Route Table cho Private Subnet (Đi qua NAT GW)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "Private-Route-Table" }
}

# 9. Quản lý Default Security Group cho VPC
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  # Không khai báo ingress/egress để từ chối toàn bộ traffic mặc định
  tags = {
    Name = "Main-Default-SG"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}