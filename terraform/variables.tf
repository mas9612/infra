variable "user" {}
variable "password" {}

variable "vsphere_server" {
  default = "10.1.3.30"
}

variable "allow_unverified_ssl" {
  default = true
}
