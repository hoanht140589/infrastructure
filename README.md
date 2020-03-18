# Terraform
 
#Modules contains all defined modules.
#sandbox for execute(test).

#Achived
- Create 1 VM with specifics information(refer to main.tf in sandbox)

#Change log 1.1
- Create multiple VMs with Host module. Done
- Do the same with Cluster module.
- Clean code.

#Change log March 18, 2020
- Change main.tf to use Cluster(instead of Hosts)
- Focus on vsphere_cluster instead of vsphere_hosts means abandon hosts feature.
- Adding disks variable to module vsphere cluster.
- Vsphere_cluster now can enable to create VMs with multiple disks(with size).
- Minor bug on vm_ram: it should be number devine to 1024.
- Still not enable to add multiple NICs.
- Compartible with Terraform 0.12 or above.

#How to use this
- You have to edit ./modules/global_variables/variables.tf with your Vcenter information.
- After that, you can come to ./main_execution/main.tf. There is a sample block.
- Copy or edit that block with your VM information.
- You also need to installing terraform.
- This feature is tested on linux. You may need to make some test with Windows :D

