terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://91.160.196.233:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "f#o*G9eemhAt@"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "vm" {
  count       = 2
  name        = "vm-${count.index + 1}"
  target_node = "pve"
  clone       = "debian-12"
  memory      = 4096
  boot        = "order=scsi0"
  scsihw      = "virtio-scsi-single"

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage  = "local-lvm"
          size     = "20G"
          iothread = true
        }
      }
    }
  }

  network {
    id        = 0
    bridge    = "vmbr0"
    model     = "virtio"
    firewall  = true
  }

  ipconfig0 = "ip=dhcp"
}
