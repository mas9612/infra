data "vsphere_host" "host_33" {
  name          = "10.1.3.33"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}

data "vsphere_host" "host_35" {
  name          = "10.1.3.35"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}
