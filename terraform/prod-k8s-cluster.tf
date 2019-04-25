variable "prod_k8s_instance_ips" {
  default = {
    "0" = "192.168.100.50"
    "1" = "192.168.100.51"
    "2" = "192.168.100.52"
  }
}

variable "prod_k8s_instance_hostnames" {
  default = {
    "0" = "prod-k8s-master-01"
    "1" = "prod-k8s-node-01"
    "2" = "prod-k8s-node-02"
  }
}

resource "vsphere_virtual_machine" "prod-k8s-node" {
  count = 3

  name             = "k800123-${lookup(var.prod_k8s_instance_hostnames, count.index)}"
  resource_pool_id = "${data.vsphere_resource_pool.rp_test.id}"
  datastore_id     = "${data.vsphere_datastore.ds_master.id}"

  num_cpus  = 4
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_dc35.id}"
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
        host_name = "${lookup(var.prod_k8s_instance_hostnames, count.index)}"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "${lookup(var.prod_k8s_instance_ips, count.index)}"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.100.1"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}
