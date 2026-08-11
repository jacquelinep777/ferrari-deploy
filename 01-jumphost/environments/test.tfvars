workload    = "ferrari"
environment = "test"
location    = "westeurope"
region_code = "we"
instance    = "01"
cia         = "233"

address_space            = ["10.41.0.0/16"]
management_subnet_prefix = "10.41.1.0/24"
bastion_address_space    = ["10.90.41.0/24"]
bastion_subnet_prefix    = "10.90.41.0/26"

linux_vm = {
  admin_username       = "azureadmin"
  admin_ssh_public_key = "ssh-ed25519 replace-with-demo-public-key ferrari-demo"
}

admin_login_principal_ids = {
  platform-admins = "00000000-0000-0000-0000-000000000001"
}

user_login_principal_ids = {
  platform-readers = "00000000-0000-0000-0000-000000000002"
}

enable_pim_eligible_role_assignments = false
