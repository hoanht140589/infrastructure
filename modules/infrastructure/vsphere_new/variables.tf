#variables.tf for vsphere_hosts
######################
##vCenter Connection##
######################
variable "vsphere_datacenter" {
  description               = "vSphere datacenter"
}
#Comment vsphere_host if you want to use cluster and vice versa
#variable "vsphere_host" {
#  description = "vSphere Host"
#}

#variable "vSphere_cluster" {
#  description = "vSphere Cluster"
#}

######################
## vSphere Machine ###
######################
#This section is used for defining your vm_machine with input.
#Machine need below information
#vm_name
#vm_ip
#vm_network
#vm_datastore
#vm_disk_size
variable vm_machine_name {
  description = "Still thinking"
  default = "test-machine"
}

variable vm_datastore {
  description = "Datastore hosts the machine"
  type = "map"
  default = {
#    mid_staging = ""
#    app_staging = ""
#    db_staging = ""
#    mid_production = ""
#    app_production = ""
#    db_production = ""
#    monitor = ""
    test-server = "datastore_vm05"
  }
}

variable vm_resource {
  description = "Resource host VM machine"
}
variable vm_resource_cluster {
  description = "Cluster of resource"
  type = "map"
  default = {
    "172.23.45.22" = "TW-CODE88-01"
    "172.23.45.25" = "TW-CODE88-01"
    "172.23.45.14" = "TW-LOKI-01"
    "172.23.45.24" = "TW-LOKI-01"
  }
}

variable vm_datastore_cluster {
  description = "Cluser of datastore"
  type = "map"
  default = {
    # mid_staging = ""
    # app_staging = ""
    # db_staging = ""
    # mid_production = ""
    # app_production = ""
    # db_production = ""
    # monitor = ""
  }
}

variable vm_cpu {
  description = "Number of vCPU need to assign to machine"
  default = "2"
}
variable vm_memory {
  description = "Amount of Memories need to assign to machine"
  default = "4096"
}
variable vm_ip {
  #We need to apply list for this.
  description = "IP address for machine"
#  type = list(object({ip})
  default = ["127.0.0.1"]
  # type = "map"
  # default = {
  #   mid_staging = "172.18.196."
  #   app_staging = "172.18.108."
  #   db_staging = "172.18.111."
  #   mid_production = "172.18.96."
  #   app_production = "172.18.8."
  #   db_production = "172.18.11."
  #   monitor = "172.18.18."
  # }
}
variable vm_network {
  description = "Netmask for machine"
  type = "map"
  default = {
#    mid_staging = "255.255.252.0"
#    app_staging = "255.255.252.0"
#    db_staging = "255.255.252.0"
#    mid_production = "255.255.252.0"
#    app_production = "255.255.252.0"
#    db_production = "255.255.252.0"
#    monitor = "255.255.252.0"
    test-server = "MM_Cleanroom"
  }
}
variable vm_netmask {
  description = "Netmask for machine"
  type = "map"
  default = {
    mid_staging = "255.255.252.0"
    app_staging = "255.255.252.0"
    db_staging = "255.255.252.0"
    mid_production = "255.255.252.0"
    app_production = "255.255.252.0"
    db_production = "255.255.252.0"
    monitor = "255.255.252.0"
    test-server = "24"
  }
}
variable vm_template {
  description = "Template of machine"
  type = "map"
  default = {
    ubuntu_14 = "ubuntu_14.04"
    ubuntu_16 = "ubuntu_16.04"
    ubuntu_18 = "ubuntu_18.04"
    windows_12 = "windows_server_2012"
    test-server = "template_02"
  }
}
variable vm_dns {
  description = "DNS"
  default = "8.8.8.8"
}
variable vm_gateway {
  description = "Default gateway"
  type = "map"
  default = {
    mid_staging = "172.18.196.254"
    app_staging = "172.18.108.254"
    db_staging = "172.18.111.254"
    mid_production = "172.18.96.254"
    app_production = "172.18.8.254"
    db_production = "172.18.11.254"
    monitor = "172.18.18.254"
    test-server = "172.23.33.254"
  }
}
variable vm_linked_clone {
  description = "Linked lone to create the VM from template(true/false)"
  default = "false"
}
variable vm_domain {
  description = "Domain of this machine."
  default = "local.domain"
}
variable vm_env {
  default = "test-server"
  # type = "map"
  # default = {
  #   # dev = "dev"
  #   # qat = "qat"
  #   # mid_staging = "mid_staging"
  #   # app_staging = "app_staging"
  #   # db_staging  = "db_staging"
  #   # mid_production = "mid_production"
  #   # app_production = "app_production"
  #   # db_production = "db_production"
  #   # monitor   = "monitor"
  # }
}

###################


