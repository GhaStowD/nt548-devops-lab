# Public Security Group (Chỉ cho phép IP SSH vào cổng 22)
resource "aws_security_group" "public_sg" {
  name        = "public-ec2-sg"
  description = "Allow SSH from specific IP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # IP máy tính cá nhân
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"] #EC2 ra được internet qua IPv6 nếu cần
  }
}

# Private Security Group (Chỉ cho phép Public EC2 nhảy vào qua cổng 22)
resource "aws_security_group" "private_sg" {
  name        = "private-ec2-sg"
  description = "Allow SSH only from Public EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "DevOps-Lab-Public-SG"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id] # Chỉ nhận từ Public SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}