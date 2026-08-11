output "resource_group_name" {
  value = module.jumphost.resource_group_name
}

output "network_id" {
  value = module.jumphost.network_id
}

output "bastion_name" {
  value = module.jumphost.bastion_name
}

output "vm_ids" {
  value = module.jumphost.vm_ids
}
