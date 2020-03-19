variable "vsphere_datacenter" {
  description               = "vSphere datacenter"
}
variable "vsphere_cluster" {
  description               = "vSphere Cluster"
}
variable "vm_template" {
  description               = "Template used for create the vSphere virtual machines"
}
############## Vsphere Machine ################
variable "vm_datastore" {
  description   = "Datastore used for the vSphere virtual machine"
  default   = []
}
variable "vm_domain" {
  description               = "Machine should belong to one domain"
  default = ""
}
variable "vm_network" {
  description   = "Network used for the vSphere virtual machine"
  default   = []
}
variable "vm_dns" {
  description               = "DNS of the virtual machine"
  default                   = "8.8.8.8"
}
variable "vm_ip" {
  description   = "IP addess of VM machine"
  default   = []
}
variable "vm_netmask" {
  description   = "Netmask"
  default   = ["24"]
}
variable "vm_gateway" {
  description   = "Gateway"
  default   = []
}
variable "vm_cpu" {
  description   = "CPU"
  default   = [4]
}
variable  "vm_ram" {
  description   = "Memory"
  default   = [8192]
}
variable  "vm_name" {
  description   = "Machine name"
  default   = []
}
variable "vm_linked_clone" {
  description = "Linked Clone"
}

