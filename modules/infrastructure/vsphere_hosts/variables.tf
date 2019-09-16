#######################################################
#Author Rico
#Create based on Stand alone vSphere
######################
##vCenter Connection##
######################

variable "vsphere_user" {
  description               = "vSphere Username"
}
variable "vsphere_password" {
  description               = "vSphere Password"
}
variable "vsphere_vcenter" {
  description               = "vCenter Server Domain or IP"
}
variable "vsphere_unverified_ssl" {
  description               = "vCenter use a self signed certificate (true/false)"
}
variable "vsphere_datacenter" {
  description               = "vSphere datacenter"
}
variable "vsphere_host" {
  description = "vSphere Host"
}

######################
## vSphere Machine ###
######################

variable "vm_datastore" {
  description               = "Datastore used for the vSphere virtual machines"
}

variable "vm_disk_size" {
  description               = "Datastore used for the vSphere virtual machines. Default is 50GB"
  default = "50"
}

variable "vm_network" {
  description               = "Network used for the vSphere virtual machines"
}

variable "vm_template" {
  description               = "Template used for create the vSphere virtual machines"
}

variable "vm_ip" {
  description               = "IP used for the vSphere virtual machine"
}
variable "vm_netmask" {
  description               = "Netmask of virtual machines"
  default = "24"
}
variable "vm_gateway" {
  description               = "Default Gateway of vSphere virtual machine"
}
variable "vm_dns" {
  description               = "DNS of the virtual machine"
  default                   = "8.8.8.8"
}
variable "vm_domain" {
  description               = "Machine should belong to one domain"
}
variable "vm_linked_clone" {
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  default = "false"
}
variable "vm_cpu" {
  description               = "Number of vCPU for the vSphere machine"
  default                   = "2"
}
variable "vm_ram" {
  description               = "Number of Memory in MB for the virtual machine"
  default                   = "2048"
}
variable "vm_name" {
  description = "The name of machine"
}
#######################################################
