resource "yandex_compute_instance" "websrvr2" {
  folder_id                 = var.folder_id
  hostname                  = "websrvr2"
  metadata                  = {
      "install-unified-agent" = "1"
      "serial-port-enable"    = "1"
      "user-data"             = "${templatefile("meta.tftpl", { ubuntu_ssh_pub_key = file("~/.ssh/id_ed25519.pub"), admin_ssh_pub_key = file("/mnt/c/Users/svkov/.ssh/id_rsa.pub")})}"
  }
  name                      = "websrvr2"
  network_acceleration_type = "standard"
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  boot_disk {
      auto_delete = true
      mode        = "READ_WRITE"

      initialize_params {
          block_size = 4096
          image_id   = "fd8fco5lpqbhanbfg2du"
          size       = 18
          type       = "network-hdd"
      }
  }

  network_interface {
      ip_address         = "10.128.0.3"
      ipv4               = true
      ipv6               = false
      nat                = true
      security_group_ids = [yandex_vpc_security_group.default-sg-enppnrrcnrj0bqbq6b9s.id]
      subnet_id          = yandex_vpc_subnet.default-ru-central1-a.id
  }

  placement_policy {
      host_affinity_rules       = []
      placement_group_partition = 0
  }

  resources {
      core_fraction = 20
      cores         = 2
      gpus          = 0
      memory        = 4
  }

  scheduling_policy {
      preemptible = true
  }
}
