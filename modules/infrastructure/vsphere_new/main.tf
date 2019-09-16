#main.tf in vsphere_nwq
######################
###vSphere Provider###
######################
module "global_variables" {
  source = "../..//global_variables"
#../../global_variables
}
#Setting up provider for vsphere
provider "vsphere" {
  version                   = "1.11.0"
  vsphere_server            = "${module.global_variables.vsphere_vcenter}"
  user                      = "${module.global_variables.vsphere_user}"
  password                  = "${module.global_variables.vsphere_password}"
  allow_unverified_ssl      = "${module.global_variables.vsphere_unverified_ssl}"
}

#Defining data
data "vsphere_datacenter" "datacenter" {
  name                      = "${var.vsphere_datacenter}"
}

#data "vsphere_cluster" "cluster" {
#  name                      = "${var.vsphere_cluster}"
#  name                      = "${lookup(var.vm_resource_cluster,var.vm_env)}"
#  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
#}
data "vsphere_host" "host" {
  name = "${var.vm_resource}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "datastore"{
#  name                      = "${var.vm_datastore}"
  name                      = "${lookup(var.vm_datastore,var.vm_env)}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network" {
#  name                      = "${var.vm_network}"
  name			    = "${lookup(var.vm_network,var.vm_env)}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
#  name                      = "${var.vm_template}"
  name 			    = "${lookup(var.vm_template,var.vm_env)}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}



#------------------------------------------#
###########
# resource "vsphere_virtual_machine" "TEST-VM" {
#   count = "${var.vmcount}"
#   name   = "${var.vmname}_0${count.index + 1}"
#   hostname = "${var.vmname}${count.index + 1}"
#   vcpu   = 2
#   memory = 4096
#   domain = "${var.vmdomain}"
#   dns_suffixes = [ "${var.vmdomain}" ]
#   datacenter = "YOUR_DC"
#   cluster = "${lookup(var.vmcluster,var.vmrp)}"
#   resource_pool = "${lookup(var.vmcluster, var.vmrp)}/Resources/${var.vmrp}"
#   dns_servers = ["${lookup(var.vmdns1,var.vmdomain)}", "${lookup(var.vmdns2,var.vmdomain)}"]

#   network_interface {
#     label = "${lookup(var.vmnetlabel, var.vmdomain)}"
#     ipv4_address = "${lookup(var.vmaddrbase,var.vmdomain)}${10 + count.index}"
#     ipv4_gateway = "${lookup(var.vmgateway,var.vmdomain)}"
#     ipv4_prefix_length = "24"
#   }

#   disk {
#     template = "Linux_templates/${var.vmtemp}"
#     type = "thin"
#     datastore = "${lookup(var.vmdscluster, var.vmdatastore)}/${var.vmdatastore}"
#   }
# }

#Defining vm_machine
resource "vsphere_virtual_machine" "vm_machine" {
  count = length("${var.vm_ip}")
  name = "${var.vm_machine_name}-0${count.index + 1}"
  num_cpus = "${var.vm_cpu}"
  memory = "${var.vm_memory}"
#  cluster = "${lookup(var.vm_resource_cluster,var.vm_resource)}"
#  resource_pool_id = "${data.vsphere_datacenter.datacenter.id}/${lookup(var.vm_resource_cluster,var.vm_resource,var.vm_resource)}/${lookup(var.vm_resource_cluster,var.vm_resource,var.vm_resource)}}"
  resource_pool_id = "${data.vsphere_host.host.resource_pool_id}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  network_interface {
    #network_id              = "${lookup(var.vm_network,var.env)}"
    network_id              = "${data.vsphere_network.network.id}"
    adapter_type            = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label                   = "${var.vm_machine_name}-0-${count.index + 1}.vmdk"
    size                    = "${data.vsphere_virtual_machine.template.disks.0.size}"
    #size                    = "${var.vm_disks_size != "default" ? var.vm_disks_size : data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub           = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned        = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    #datastore               = "${lookup(var.)}"
  }
   disk {
#     label                   = "${var.vm_machine_name}-0-${count.index + 1}_2.vmdk"
     name 		     = "${var.vm_machine_name}-0-${count.index + 1}_2.vmdk"
     size 		     = 20
     thin_provisioned = true
     unit_number	     = 2
#     thin_provisioned        = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
#     size                    = "${var.vm_disks_size}"
#     type                    = "thin"
     datastore_id               = "${data.vsphere_datastore.datastore.id}"
   }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone  = "${var.vm_linked_clone}"
    customize {
      timeout = "20"
      linux_options {
        host_name = "${var.vm_machine_name}-0-${count.index + 1}"
        domain    = "${var.vm_domain}"
      }
      network_interface {
        ipv4_address = "${var.vm_ip[count.index]}"
        ipv4_netmask = "${lookup(var.vm_netmask,var.vm_env)}"
      }
      ipv4_gateway   = "${lookup(var.vm_gateway,var.vm_env)}"
      #ipv4_gateway    = "${var.vm_gateway}"
      dns_server_list = ["${var.vm_dns}"]
    }
  }
}
