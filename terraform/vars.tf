variable "folder_id" {
  type = string
}

variable "site_name" {
  type        = string
  default = "tripleap.ru."
  description = "DNS-имя сайта"
}

variable "MY_IP" {
  type = string
}
