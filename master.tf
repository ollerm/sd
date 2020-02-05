
resource "libvirt_volume" "master" {
  count = "1"
  name  = "master-${count.index}"
  pool = libvirt_pool.vm_pool.name
  source = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  format         = "qcow2"
}



resource "libvirt_domain" "master" {
  count = "1"
  name = "master-${count.index}"
  memory = "2048"
  vcpu  = "2"
  autostart = "true"

  network_interface {
      addresses = ["10.0.100.${20 + count.index}"]
      network_name = "vm_network"
      hostname = "master-${count.index}"
      mac = "f2:9f:71:f6:6a:0${0 + count.index}"
  }

  cpu = {
    mode = "host-passthrough"
  }

  disk {
      volume_id = element(libvirt_volume.master.*.id, count.index)
  }

  cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}
