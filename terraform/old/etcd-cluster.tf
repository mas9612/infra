variable "etcd-instance_ips" {
  default = {
    "0" = "10.1.240.121"
    "1" = "10.1.240.122"
    "2" = "10.1.240.123"
  }
}

variable "etcd-instance_hostnames" {
  default = {
    "0" = "etcd-01"
    "1" = "etcd-02"
    "2" = "etcd-03"
  }
}

resource "vsphere_resource_pool" "etcd" {
  name                    = "k800123-etcd"
  parent_resource_pool_id = "${data.vsphere_resource_pool.pool_35.id}"
}

resource "vsphere_virtual_machine" "etcd-node" {
  count = 3

  name             = "k800123-${lookup(var.etcd-instance_hostnames, count.index)}"
  resource_pool_id = "${vsphere_resource_pool.etcd.id}"
  datastore_id     = "${data.vsphere_datastore.ds_master.id}"

  num_cpus  = 2
  memory    = 2048
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_vm_network.id}"
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
        host_name = "${lookup(var.etcd-instance_hostnames, count.index)}"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "${lookup(var.etcd-instance_ips, count.index)}"
        ipv4_netmask = 16
      }

      ipv4_gateway    = "10.1.3.1"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}
