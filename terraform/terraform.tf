terraform {
  backend "etcdv3" {
    endpoints = ["10.1.240.121:2380", "10.1.240.122:2380", "10.1.240.123:2380"]
    lock      = true
    prefix    = "terraform-state/"
  }
}
