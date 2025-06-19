resource "yandex_dns_zone" "external_zone" {
  name        = "externalzone"
  description = "externalzone"
  zone        = var.site_name
  public      = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.external_zone.id
  name    = "vault.${var.site_name}"
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.websrvr2.network_interface.0.ip_address]
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.external_zone.id
  name    = "jenkins.${var.site_name}"
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.websrvr2.network_interface.0.ip_address]
}

resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.external_zone.id
  name    = "@"
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.websrvr2.network_interface.0.nat_ip_address]
}

resource "yandex_dns_recordset" "rs4" {
  zone_id = yandex_dns_zone.external_zone.id
  name    = "bastion.${var.site_name}"
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.websrvr2.network_interface.0.nat_ip_address]
}
