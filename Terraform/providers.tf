terraform {
  # Phiên bản Terraform tối thiểu để chạy code 
  required_version = ">= 1.0.0"

  # Khai báo các nhà cung cấp dịch vụ (Providers) cần tải về
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Sử dụng phiên bản AWS Provider đầu 5.x
    }
  }
}

# Cấu hình cụ thể cho nhà cung cấp AWS
provider "aws" {
  region = var.aws_region # Lấy vùng từ file variables.tf gốc (vd: ap-southeast-1)
}