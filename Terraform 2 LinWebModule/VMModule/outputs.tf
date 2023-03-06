output "vm_id_out" {
  value = azurerm_linux_virtual_machine.myterraformvm.id
}

output "vm_ip_out" {
value = azurerm_network_interface.netinterface.private_ip_addresses
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}