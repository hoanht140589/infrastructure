terraform {
  required_version = ">= 0.12"
}

<<<<<<< HEAD
module "vm_machine01" {
  var_disks = [{
     unit_number = 0
     size = "50"
  },
  {
     unit_number = 1
     size = "70"
  }
  ]
  source = "../modules/infrastructure/vsphere_cluster"
  vsphere_datacenter = "V-Datacenter"
  module_name = "test_machine_01"
  vm_name = "test-machine-01"
  vm_cpu = 8
  vm_ram = 16384
  vm_domain = ""
  vsphere_cluster = "CLUSTER-01"
  vm_ip = ["127.0.0.1"]
  vm_network = "localhost"
  vm_netmask = "24"
  vm_gateway = "127.0.0.1"
  vm_dns = "127.0.0.1"
  vm_template = "ubuntu16_baseos"
  vm_datastore = "datastore01"
  vm_linked_clone = "false"
}
module "vm_machine02" {
  source = "../modules/infrastructure/vsphere_cluster"
  vsphere_datacenter = "V-Datacenter"
  module_name = "test_machine_02"
  vm_name = "test-machine-02"
  vm_cpu = 8
  vm_ram = 16384
  vm_domain = ""
  vsphere_cluster = "CLUSTER-01"
  vm_ip = ["127.0.0.1"]
  vm_network = "localhost"
  vm_netmask = "24"
  vm_gateway = "127.0.0.1"
  vm_dns = "127.0.0.1"
  vm_template = "ubuntu16_baseos"
  vm_datastore = "datastore01"
  vm_linked_clone = "false"
}

=======
#module "vsphere_hosts"{
#  source = "../modules/infrastructure/vsphere_hosts"
#  vsphere_vcenter = "vcenter01"
#  vsphere_user = "administrator@vsphere.local"
#  vsphere_password = "SharpEar!"
#  vsphere_unverified_ssl = "true"
#  vsphere_datacenter = "IDC"
#  vsphere_host = "172.23.45.15"
#  vm_name = "ansible06"
#  vm_datastore = "datastore_vm05"
#  vm_network = "MM_Cleanroom"
#  vm_netmask = "24"
#  vm_gateway = "172.23.33.254"
#  vm_dns = "8.8.8.8"
#  vm_domain = ""
#  vm_template = "template_02"
#  vm_linked_clone = "false"
#  vm_cpu = "4"
#  vm_ram = "8192"
#  vm_ip = "172.23.33.29"
#  vm_disk_size = "70"
#}
#module "vsphere_cluster"{
#  source = "../modules/infrastructure/vsphere_cluster"
#  vsphere_datacenter = "IDC"
#  vm_domain = ""
#  vm_name = "test-server"
#  vsphere_cluster = "TW-CODE88-01"
#  vm_ip = ["172.23.9.14","172.23.9.15"]
#  vm_network = "Code88_Internal"
#  vm_netmask = "24"
#  vm_gateway = "172.23.9.254"
#  vm_dns = "172.23.9.1"
#  vm_template = "template_02"
#  vm_datastore = "Shared-DS-C88-01"
#  vm_linked_clone = "false"
#}
module "machine_01" {
  source = "../modules/infrastructure/vsphere_cluster"
  vsphere_datacenter = "IDC"
  module_name = "machine-01"
  vm_domain = ""
  vm_name = "test-server-01"
  vsphere_cluster = "TW-CODE88-01"
  vm_ip = ["172.23.9.14"]
  vm_network = "Code88_Internal"
  vm_netmask = "24"
  vm_gateway = "172.23.9.254"
  vm_dns = "172.23.9.1"
  vm_template = "template_02"
  vm_datastore = "Shared-DS-C88-01"
  vm_linked_clone = "false"
}

module "machine_02" {
  source = "../modules/infrastructure/vsphere_cluster"
  vsphere_datacenter = "IDC"
  module_name = "machine-02"
  vm_domain = ""
  vm_name = "test-server-02"
  vsphere_cluster = "TW-CODE88-01"
  vm_ip = ["172.23.9.15"]
  vm_network = "Code88_Internal"
  vm_netmask = "24"
  vm_gateway = "172.23.9.254"
  vm_dns = "172.23.9.1"
  vm_template = "template_02"
  vm_datastore = "Shared-DS-C88-01"
  vm_linked_clone = "false"
}
>>>>>>> 970590400ab73261461ef2bc64f12726927e5904
