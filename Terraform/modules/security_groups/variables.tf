variable "vpc_id" {
  type        = string
  description = "ID của VPC được truyền từ module vpc sang"
}

variable "my_ip" {
  type        = string
  description = "IP máy tính của bạn để cấu hình SSH"
}