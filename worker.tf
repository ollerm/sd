
resource "libvirt_volume" "worker" {
  count = "4"
  name  = "worker-${count.index}"
  pool = libvirt_pool.vm_pool.name
  source = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  format         = "qcow2"
}

resource "libvirt_domain" "worker" {
  count = "4"
  name = "worker-${count.index}"
  memory = "1024"
  vcpu  = "2"
  autostart = "true"

  network_interface {
    network_id = libvirt_network.vm_network.id
      addresses = ["10.0.100.${30 + count.index}"]
      network_name = "vm_network"
      hostname = "worker-${count.index}"
#      wait_for_lease = true
      mac = "f2:9f:71:f6:6b:0${0 + count.index}"
  }

  cpu = {
    mode = "host-passthrough"
  }

  disk {
      volume_id = element(libvirt_volume.worker.*.id, count.index)
  }

  cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}
