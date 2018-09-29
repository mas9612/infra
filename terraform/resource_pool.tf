data "vsphere_resource_pool" "rp_test" {
  name          = "k800123-test"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}
