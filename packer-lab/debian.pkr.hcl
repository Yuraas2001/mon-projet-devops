variable "proxmox_url" {
  default = "https://91.160.196.233:8006/api2/json"
}

variable "proxmox_user" {
  default = "root@pam"
}

variable "proxmox_password" {
  default = "f#o*G9eemhAt@"
}

variable "vm_name" {
  default = "vm1"
}

packer {
  required_plugins {
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "debian12" {
  proxmox_url              = var.proxmox_url
  username                 = var.proxmox_user
  password                 = var.proxmox_password
  insecure_skip_tls_verify = true

  ssh_username     = "rt"
  ssh_password     = "rt"
  ssh_wait_timeout = "10000s"

  node   = "pve"
  vm_id  = 106
  memory = 2048
  cores  = 2

  template_description = "Debian 12, generated on ${timestamp()}"
  template_name        = "debian-12"
 

  disks {
    disk_size    = "20G"
    storage_pool = "local-lvm"
    format       = "raw"
  }

  network_adapters {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:43:01:AA"
  }

  boot_iso {
  iso_url          = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.3.0-amd64-netinst.iso"
  iso_checksum     = "sha256:c9f09d24b7e834e6834f2ffa565b33d6f1f540d04bd25c79ad9953bc79a8ac02"
  iso_storage_pool = "local"
}

 http_directory = "/home/rt/packer-lab"

  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]
} 

build {
  sources = ["source.proxmox-iso.debian12"]

  provisioner "shell" {
    inline = [
      "echo 'Template Debian 12 créé avec succès'"
    ]
  }
}
