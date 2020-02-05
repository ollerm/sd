# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

#pool dla wirtualek
resource "libvirt_pool" "vm_pool" {
  name = "vm_pool"
  type = "dir"
  path = "/images/vm"
}

# siec dla wirtulek
resource "libvirt_network" "vm_network" {
   name = "vm_network"
   addresses = ["10.0.100.0/24"]
   dhcp {
    enabled = true
   }
}

# CloudInit
resource "libvirt_cloudinit_disk" "commoninit" {
          name = "commoninit.iso"
          pool = "vm_pool"
          user_data = data.template_file.user_data.rendered
          #network_config = data.template_file.network_config.rendered
        }

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

data "template_file" "network_config" {
  template = "${file("${path.module}/network_config.cfg")}"
}
