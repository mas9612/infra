provider "vsphere" {
  user                 = "${var.user}"
  password             = "${var.password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
}
