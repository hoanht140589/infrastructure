terraform {
  required_version = ">= 0.12"
}

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
module "vsphere_cluster"{
  source = "../modules/vsphere_cluster"
  vsphere_datacenter = "IDC"
  vm_domain = ""
  vm_name = "test-server"
  vsphere_cluster = "TW-CODE88-01"
  vm_ip = ["172.23.9.14","172.23.9.15"]
  vm_network = "Code88_Internal"
  vm_netmask = "24"
  vm_gateway = "172.23.9.254"
  vm_dns = "172.23.9.1"
  vm_template = "template_02"
  vm_datastore = "Shared-DS-C88-01"
  vm_linked_clone = "false"
}
