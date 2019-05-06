data "vsphere_datastore" "ds_bachelor" {
  name          = "Datastore"
  datacenter_id = "${data.vsphere_datacenter.dc_bachelor.id}"
}

data "vsphere_datastore" "ds_master" {
  name          = "Datastore"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}

data "vsphere_datastore" "ds_iso" {
  name          = "iso-images"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}
