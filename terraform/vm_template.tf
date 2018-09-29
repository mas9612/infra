data "vsphere_virtual_machine" "centos7" {
  name          = "k800123-CentOS7-base"
  datacenter_id = "${data.vsphere_datacenter.dc_master.id}"
}
