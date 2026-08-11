terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

module "jumphost" {
  source = "git::ssh://git@github.com-jacquelinep777/jacquelinep777/xx-azurerm-stack-jumphost.git?ref=v0.0.2"

  workload    = var.workload
  environment = var.environment
  location    = var.location
  region_code = var.region_code
  instance    = var.instance
  cia         = var.cia

  address_space            = var.address_space
  management_subnet_prefix = var.management_subnet_prefix
  bastion_address_space    = var.bastion_address_space
  bastion_subnet_prefix    = var.bastion_subnet_prefix

  linux_vm          = var.linux_vm
  windows_vm        = var.windows_vm
  admin_passwords   = var.admin_passwords
  enable_windows_vm = false

  admin_login_principal_ids = var.admin_login_principal_ids
  user_login_principal_ids  = var.user_login_principal_ids

  enable_pim_eligible_role_assignments = var.enable_pim_eligible_role_assignments
}
