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

data "vsphere_compute_cluster" "cluster" {
  name                      = "${var.vsphere_cluster}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore" "datastore"{
  count = length("${var.vm_datastore}")
  name                      = "${var.vm_datastore[count.index]}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network" {
  count = length("${var.vm_network}")
  name                      = "${var.vm_network[count.index]}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
  name                      = "${var.vm_template}"
  datacenter_id             = "${data.vsphere_datacenter.datacenter.id}"
}

variable "var_disks" {
  default = [
    {
      unit_number = 0
      size = "40"
    },
  ]
}

resource "vsphere_virtual_machine" "machine" {
  #count = length("${var.vm_ip}")
  count = length("${var.vm_name}")
  name                      = "${var.vm_name[count.index]}"
  resource_pool_id          = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id              = "${data.vsphere_datastore.datastore[count.index].id}"

  num_cpus                  = "${var.vm_cpu[count.index]}"
  memory                    = "${var.vm_ram[count.index]}"
  guest_id                  = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
#    network_id              = "${data.vsphere_network.network.id}"
    network_id              = "${data.vsphere_network.network[count.index].id}"
    adapter_type            = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  #Implement dynamic disks for VM.
  dynamic "disk" {
    for_each = [for s in "${var.var_disks}": {
        label = s.unit_number == "0" ? "${var.vm_name}.vmdk" : "${var.vm_name[count.index]}_0${s.unit_number}.vmdk"
        unit_number = s.unit_number
        size = s.size
      }]
    content {
        label                   = disk.value.label
        unit_number             = disk.value.unit_number
        size                    = disk.value.size
        eagerly_scrub           = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
        thin_provisioned        = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    }
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone  = "${var.vm_linked_clone}"

    customize {
      timeout = "20"
      linux_options {
        host_name = "${var.vm_name[count.index]}"
        domain    = "${var.vm_domain}"
      }

      network_interface {
        ipv4_address = "${var.vm_ip[count.index]}"
        ipv4_netmask = "${var.vm_netmask[count.index]}"
      }

      ipv4_gateway    = "${var.vm_gateway[count.index]}"
      dns_server_list = ["${var.vm_dns}"]
    }
  }
}
