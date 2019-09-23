#######################################################
#Author Rico
#Create based on Stand alone vSphere
######################
###vSphere Provider###
######################
module "global_variables" {
  source = "../../global_variables"
#../../global_variables
}
provider "vsphere" {
  version                   = "1.11.0"
  vsphere_server            = "${module.global_variables.vsphere_vcenter}"
  user                      = "${module.global_variables.vsphere_user}"
  password                  = "${module.global_variables.vsphere_password}"
  allow_unverified_ssl      = "${module.global_variables.vsphere_unverified_ssl}"
}
######################
#### vSphere Data ####
######################
data "vsphere_datacenter" "datacenter" {
  name                      = "${var.vsphere_datacenter}"
}

data "vsphere_host" "host" {
  name                      = "${var.vsphere_host}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "datastore"{
  name                      = "${var.vm_datastore}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network" {
  name                      = "${var.vm_network}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
  name                      = "${var.vm_template}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}
######################
###vSphere Resources###
######################
resource "vsphere_virtual_machine" "machine" {
  count = length("${var.vm_ip}")
  name                      = "${var.vm_name}-0${count.index + 1}"
  #resource_pool_id          = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  resource_pool_id          = "${data.vsphere_host.host.resource_pool_id}"
  datastore_id              = "${data.vsphere_datastore.datastore.id}"

  num_cpus                  = "${var.vm_cpu}"
  memory                    = "${var.vm_ram}"
  guest_id                  = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
    network_id              = "${data.vsphere_network.network.id}"
    adapter_type            = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label                   = "${var.vm_name}-0${count.index + 1}.vmdk"
    size                    = "${data.vsphere_virtual_machine.template.disks.0.size}"
#    size                    = "${var.vm_disks_size != "default" ? var.vm_disks_size : data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub           = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned        = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone  = "${var.vm_linked_clone}"

    customize {
      timeout = "20"
      linux_options {
        host_name = "${var.vm_name}"
        domain    = "${var.vm_domain}"
      }

      network_interface {
        ipv4_address = "${var.vm_ip[count.index]}"
        ipv4_netmask = "${var.vm_netmask}"
      }

      ipv4_gateway    = "${var.vm_gateway}"
      dns_server_list = ["${var.vm_dns}"]
    }
  }
}