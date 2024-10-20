
### the point of begin 
variable "db_vpc_name" {
  type        = string
  default     = "develop-db"
  description = "VPC network & subnet name"
}
variable "db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Default zone for DB"
}
variable "db_vm_image" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "Docker image"
}
variable "db_vm_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of docker image"
}
variable "db_vm_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID of docker image"
}
variable "db_vm_core" {
  type        = number
  default     = 2
  description = "Core of docker image"
}
variable "db_vm_memory" {
  type        = number
  default     = 2
  description = "Memory of docker image"
} 
variable "db_vm_core_fraction" {
  type        = number
  default     = 20
  description = "Number of core_fraction"
} 
variable "db_vm_preemptible" {
  type        = bool
  default     = true
  description = "TRUE/FALSE of preemptible"
} 
variable "db_vm_network_nat" {
  type        = bool
  default     = true
  description = "TRUE/FALSE of network nat"
} 
### the point of end

resource "yandex_vpc_network" "develop_db" {
  name = var.db_vpc_name
}
resource "yandex_vpc_subnet" "develop_db" {
  name           = var.db_vpc_name
  zone           = var.db_default_zone
  network_id     = yandex_vpc_network.develop_db.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu_db" {
  family = var.db_vm_image
}

resource "yandex_compute_instance" "platform_db" {
  name        = var.db_vm_name
  hostname        = var.db_vm_name 
  platform_id = var.db_vm_platform_id 
  zone           = var.db_default_zone 
  resources {
    cores         = var.db_vm_core  
    memory        = var.db_vm_memory  
    core_fraction = var.db_vm_core_fraction  
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = var.db_vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.db_vm_network_nat
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}