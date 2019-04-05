resource "vsphere_virtual_machine" "edge-01" {
  name             = "k800123-edge-01"
  resource_pool_id = "${vsphere_resource_pool.rp_edge.id}"
  datastore_id     = "${data.vsphere_datastore.ds_master.id}"

  num_cpus  = 2
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_vm_network.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_edge.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.centos7.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.centos7.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.centos7.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.centos7.id}"

    customize {
      linux_options {
        host_name = "edge-01"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "10.1.240.1"
        ipv4_netmask = 16
      }

      network_interface {}

      ipv4_gateway    = "10.1.3.1"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}
