#This will be used to spin up a new VM in an existing RG, calling on Ansible for config Management.
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

# Create Resource Group
resource "azurerm_resource_group" "demorg" {
  name     = var.rgname
  location = var.location
}

### Networking ###

# Create Virtual Network
resource "azurerm_virtual_network" "demovnet" {
  name                = var.vnetname
  resource_group_name = azurerm_resource_group.demorg.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
}

# Create Network Security Group

resource "azurerm_network_security_group" "demonsg" {
  name                = var.sgname
  resource_group_name = azurerm_resource_group.demorg.name
  location            = var.location
}


# Create Subnet 
resource "azurerm_subnet" "demosubnet" {
  name                 = var.subname
  virtual_network_name = var.vnetname
  resource_group_name  = azurerm_resource_group.demorg.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Associate NSG with the subnet
/*
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.demosubnet.id
  network_security_group_id = azurerm_network_security_group.demonsg.id
}
*/

##########################################

# Create public IPs
resource "azurerm_public_ip" "winbasicpublicip" {
  name                = "tmp_test_env_publicip"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Dynamic"

  tags = {
    environment = "tmp_test_env"
  }
}

# Create Network Security Group and rule
/*
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.rgname
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "tmp_test_env"
  }
}
*/

#Create Network Interface
resource "azurerm_network_interface" "winbasicnic" {
  name                = var.niname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demosubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}

#Create WinBasicVM 

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}