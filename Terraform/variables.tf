variable "aws_region" {
  type        = string
  default     = "ap-southeast-1" # Khu vực Singapore
  description = "Khu vực AWS triển khai hạ tầng"
}

variable "my_ip" {
  type        = string
  default     = "104.28.166.47/32" # IP hiện tại
  description = "IP máy tính cá nhân để cho phép SSH vào Public EC2"
}

variable "ami_id" {
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # ID Ubuntu 22.04 LTS tại Singapore (có thể thay đổi theo thời điểm)
  description = "ID của Hệ điều hành sử dụng cho EC2"
}

variable "key_name" {
  type        = string
  default     = "my-aws-key" # CHÚ Ý: Tạo Key Pair trên AWS Console trước và điền tên vào đây
  description = "Tên Key Pair để SSH vào máy chủ"
}