output "vm_id" {
  value       = module.vm.vm_id_out
  description = "ID of new VM"
}

output "vm_ip" {
  value       = module.vm.vm_ip_out
  description = "The priv IP for new VM"
}

#Not best practice, I know.
output "gimmie_key" {
  value = module.vm.tls_private_key
  description = "Private Key in PEM format"
  sensitive = true
}
# To get the corresponding private key, run terraform output gimmie_key