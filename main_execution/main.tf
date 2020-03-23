terraform {
  required_version = ">= 0.12"
}

module "vm_machine01" {
  var_disks = [{
     unit_number = 0
     size = "40"
  },
  ]
  source = "../modules"
  vsphere_datacenter = "IRELAND-DC"
#  module_name = ["test_machine_01","test-machine-02"]
  vm_name = ["test-machine-01","test-machine-02"]
  vm_cpu = ["8","8"]
#  vm_ram = ["16384"]
  vm_ram = ["8192","8192"]
  #vm_domain = ""
  vsphere_cluster = "CLUSTER-01"
  vm_ip = ["127.0.0.10","127.0.0.11"]
  vm_network = ["TestNetwork","TestNetwork"]
  vm_netmask = ["24","24"]
  vm_gateway = ["127.0.0.1","127.0.0.1"]
  vm_dns = "127.0.0.1"
  vm_template = "ubuntu18"
  vm_datastore = ["Test_DataStore_01","Test_DataStore_01"]
  vm_linked_clone = "false"
}
