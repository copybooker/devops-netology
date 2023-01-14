terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = " "
  cloud_id  = "b1g6nk59s8hiat0cn0a6"
  folder_id = "b1go4m0rdbdnsnvamp1v"
  zone = "<default-ru-central1-a>"
}

resource "yandex_compute_instance" "ubuntu-22-04-lts-v20221031" {
  name = "ubuntu-22-04-lts"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8haecqq3rn9ch89eua"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
