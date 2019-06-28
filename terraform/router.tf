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
    network_id = "${data.vsphere_network.nw_k800123_edge.id}"
    # network_id   = "${data.vsphere_network.nw_k800123_edge_33.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

  network_interface {
    network_id = "${data.vsphere_network.nw_k800123_edge.id}"
    # network_id   = "${data.vsphere_network.nw_k800123_edge_34.id}"
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

      network_interface {
        ipv4_address = "192.168.97.1"
        ipv4_netmask = 30
      }

      network_interface {
        ipv4_address = "192.168.97.5"
        ipv4_netmask = 30
      }

      network_interface {
        ipv4_address = "192.168.97.9"
        ipv4_netmask = 30
      }
      ipv4_gateway    = "10.1.3.1"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}

resource "vsphere_virtual_machine" "tor35-01" {
  name             = "k800123-tor35-01"
  resource_pool_id = "${vsphere_resource_pool.rp_tor35.id}"
  datastore_id     = "${data.vsphere_datastore.ds_master.id}"

  num_cpus  = 2
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_edge.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

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
        host_name = "tor35-01"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "192.168.97.10"
        ipv4_netmask = 30
      }

      network_interface {
        ipv4_address = "192.168.100.1"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.97.9"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}

resource "vsphere_virtual_machine" "tor33-01" {
  name             = "k800123-tor33-01"
  resource_pool_id = "${vsphere_resource_pool.rp_tor33.id}"
  datastore_id     = "${data.vsphere_datastore.ds_bachelor-33.id}"

  num_cpus  = 2
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_edge_33.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_dc33.id}"
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
        host_name = "tor33-01"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "192.168.97.2"
        ipv4_netmask = 30
      }

      network_interface {
        ipv4_address = "192.168.98.1"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.97.1"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}

resource "vsphere_virtual_machine" "tor34-01" {
  name             = "k800123-tor34-01"
  resource_pool_id = "${vsphere_resource_pool.rp_tor34.id}"
  datastore_id     = "${data.vsphere_datastore.ds_bachelor-34.id}"

  num_cpus  = 2
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.centos7.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.centos7.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_edge_34.id}"
    adapter_type = "${data.vsphere_virtual_machine.centos7.network_interface_types[0]}"
  }

  network_interface {
    network_id   = "${data.vsphere_network.nw_k800123_dc34.id}"
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
        host_name = "tor34-01"
        domain    = "k800123.firefly.kutc.kansai-u.ac.jp"
      }

      network_interface {
        ipv4_address = "192.168.97.6"
        ipv4_netmask = 30
      }

      network_interface {
        ipv4_address = "192.168.99.1"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.97.5"
      dns_server_list = ["10.1.3.21", "10.1.3.80"]
    }
  }
}
