data "vsphere_resource_pool" "pool_35" {
  name          = "10.1.3.35/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

data "vsphere_resource_pool" "rp_test" {
  name          = "k800123-test"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

data "vsphere_resource_pool" "rp_production" {
  name          = "k800123-production"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}
