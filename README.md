## IaC Demo for VCC 

This Demo will show the basics of using an Infrastructure as Code tool (Terraform) as well as a Configuration Management Tool (Ansible) in Azure.

* Terraform 1 WinBasic will build everything from scratch, a Resource Group / Vnet etc. as well as a basic Windows VM all in one file. The demo for this will conclude with RDP access.

* Terraform 2 LinWebModule will use the existing resources built from "Terraform 1 WinBasic" but also use a Module for the VM creation. 

* Ansible will then configure the VM created in "LinWebModule" to install and configure nginx to serve a webpage. 

* See Readme in each folder for full set of instructions