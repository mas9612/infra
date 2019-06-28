data "vsphere_network" "nw_vm_network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

resource "vsphere_host_virtual_switch" "k800123-edge" {
  name           = "vSwitchK800123Edge"
  host_system_id = "${data.vsphere_host.host_35.id}"

  network_adapters = []
  active_nics      = []
  standby_nics     = []
}

resource "vsphere_host_port_group" "k800123-edge-pg" {
  name                = "k800123-edge"
  host_system_id      = "${data.vsphere_host.host_35.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.k800123-edge.name}"
}

data "vsphere_network" "nw_k800123_edge_33" {
  name          = "k800123-edge-33"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}

data "vsphere_network" "nw_k800123_edge_34" {
  name          = "k800123-edge-34"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}

data "vsphere_network" "nw_k800123_edge" {
  name          = "k800123-edge"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

resource "vsphere_host_virtual_switch" "k800123-dc35" {
  name           = "vSwitchk800123Dc35"
  host_system_id = "${data.vsphere_host.host_35.id}"

  network_adapters = []
  active_nics      = []
  standby_nics     = []
}

resource "vsphere_host_port_group" "k800123-dc35-pg" {
  name                = "k800123-dc35"
  host_system_id      = "${data.vsphere_host.host_35.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.k800123-dc35.name}"
}

data "vsphere_network" "nw_k800123_dc35" {
  name          = "k800123-dc35"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

data "vsphere_network" "nw_k800123_dc33" {
  name          = "k800123-dc33"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}

data "vsphere_network" "nw_k800123_dc34" {
  name          = "k800123-dc34"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}
