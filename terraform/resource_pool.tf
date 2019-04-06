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

data "vsphere_resource_pool" "rp_k800123_35" {
  name          = "18M7119 Yamazaki"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

resource "vsphere_resource_pool" "rp_edge" {
  name                    = "k800123-edge"
  parent_resource_pool_id = "${data.vsphere_resource_pool.rp_k800123_35.id}"
}

resource "vsphere_resource_pool" "rp_tor35" {
  name                    = "k800123-tor35"
  parent_resource_pool_id = "${data.vsphere_resource_pool.rp_k800123_35.id}"
}
