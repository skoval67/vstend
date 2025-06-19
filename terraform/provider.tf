# разворачиваем окружение в YC
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "storwize"
    region = "ru-central1"
    key    = "jenkins/infra.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # This option is required for Terraform 1.6.1 or higher.
    skip_s3_checksum            = true # This option is required to describe a backend for Terraform version 1.6.3 or higher.
  }

  required_version = ">= 0.13"
}

# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config  = {
#     endpoints = {
#       s3 = "https://storage.yandexcloud.net"
#     }
#     bucket = "my-terraform"
#     region = "ru-central1"
#     key    = "k8s/k8s.tfstate"

#     skip_region_validation      = true
#     skip_credentials_validation = true
#     skip_requesting_account_id  = true # This option is required to describe a backend for Terraform versions higher than 1.6.1.

#     access_key = ""
#     secret_key = ""
#    }
# }

provider "yandex" {
  zone      = "ru-central1-a"
  folder_id = var.folder_id
}
