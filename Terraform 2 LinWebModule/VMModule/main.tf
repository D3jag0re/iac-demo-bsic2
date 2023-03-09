# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "tmp_lin_publicip"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Dynamic"

  tags = {
    environment = "tmp_test_env"
  }
}

# Create Network Security Group and rule
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

    security_rule {
    name                       = "HTTP_Inbound"
    priority                   = 1021
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

      security_rule {
    name                       = "HTTPS_Inbound"
    priority                   = 1011
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "tmp_test_env"
  }
}

#Create Network Interface
resource "azurerm_network_interface" "netinterface" {
  name                = "${var.vmname}-nic"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg" {
  network_interface_id      = azurerm_network_interface.netinterface.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}


# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#Moved this to outputs so it could be read by root output
#output "tls_private_key" {
#  value     = tls_private_key.example_ssh.private_key_pem
#  sensitive = true
#}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "tmp_test_env_vm"
  location              = var.location
  resource_group_name   = var.rgname
  network_interface_ids = [
    azurerm_network_interface.netinterface.id
  ]
  size                  = var.size

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "tmp-test-env-vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  tags = {
    environment = "tmp_test_env"
  }
}
