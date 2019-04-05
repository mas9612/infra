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

resource "vsphere_host_port_group" "k801023-edge-pg" {
  name                = "k800123-edge"
  host_system_id      = "${data.vsphere_host.host_35.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.k800123-edge.name}"
}
