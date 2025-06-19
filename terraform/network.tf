locals {
  websrvr2_ingresses = [
    { port : "22", cidr : [var.MY_IP] },
    { protocol : "AH", port : 0, cidr : ["0.0.0.0/0"] },
    { protocol : "ESP", port : 0, cidr : ["0.0.0.0/0"] },
    { protocol : "UDP", port : "500", cidr : ["0.0.0.0/0"] },
    { protocol : "UDP", port : "4500", cidr : ["0.0.0.0/0"] },
    { protocol : "UDP", port : "1701", cidr : ["0.0.0.0/0"] },
    { protocol : "ICMP", port : 0, cidr : ["0.0.0.0/0"] }
  ]
}

resource "yandex_vpc_security_group" "default-sg-enppnrrcnrj0bqbq6b9s" {
  description = "Default security group for network"
  folder_id   = var.folder_id
  name        = "default-sg-${yandex_vpc_network.default.id}"
  network_id  = yandex_vpc_network.default.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }

  dynamic "ingress" {
    for_each = local.websrvr2_ingresses
    content {
      protocol          = lookup(ingress.value, "protocol", "TCP")
      v4_cidr_blocks    = lookup(ingress.value, "cidr", [])
      security_group_id = lookup(ingress.value, "sg_id", "")
      port              = lookup(ingress.value, "port", [])
    }
  }
}

resource "yandex_vpc_security_group" "vm_group_sg" {
  name       = "vm-group-sg"
  network_id = yandex_vpc_network.default.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }

  ingress {
    protocol          = "ANY"
    description       = "Allow incoming traffic from members of the same security group"
    from_port         = 0
    to_port           = 65535
    predefined_target = "self_security_group"
  }
}

resource "yandex_vpc_network" "default" {
  folder_id                 = var.folder_id
  name                      = "default"
}

resource "yandex_vpc_subnet" "default-ru-central1-a" {
  description    = "Auto-created default subnet for zone ru-central1-a in default"
  folder_id      = var.folder_id
  name           = "default-ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = [
      "10.128.0.0/24",
  ]
  zone           = "ru-central1-a"
}
