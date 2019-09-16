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
module "vsphere_new"{
  source = "../modules/infrastructure/vsphere_new"
  vm_ip = ["172.23.33.30","172.23.33.31"]
  vm_env = "test-server" 
  vm_resource = "172.23.45.15"
#  vm_datastore = "datastore_vm05"
  vsphere_datacenter = "IDC"
#  vm_template = "template_02"
}
