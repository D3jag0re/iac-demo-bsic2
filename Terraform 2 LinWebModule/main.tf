#This is  used to spin up a test RG / Ubuntu VM within Azure using an existing Vnet 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
}

#Configure the MS Azure Provider
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      skip_shutdown_and_force_delete = true
    }
  }
}


#Attach Existing Resource Group
data "azurerm_resource_group" "resourcegroup" {
  name     = var.rgname
}

#Attach existing Subnet
data "azurerm_subnet" "vmsubnet" {
  name                 = var.subname
  virtual_network_name = var.vnetname
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
}

#Create VM using VM Module
module "vm" {
  source   = "./VMModule"
  rgname   = data.azurerm_resource_group.resourcegroup.name
  location = data.azurerm_resource_group.resourcegroup.location
  vmname   = var.vmname
  size     = "Standard_F2"
  localadmin = var.admin_username
  subnetid = data.azurerm_subnet.vmsubnet.id
}