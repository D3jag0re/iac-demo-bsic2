output "vm_id_out" {
  value = azurerm_windows_virtual_machine.winbasicvm.id
}



output "priv_ip" {
  value = azurerm_network_interface.winbasicnic.private_ip_addresses
}


output "pub_ip" {
  value = azurerm_public_ip.winbasicpublicip.id
}
