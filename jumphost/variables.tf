variable "workload" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "region_code" {
  type = string
}

variable "instance" {
  type = string
}

variable "biv" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "management_subnet_prefix" {
  type = string
}

variable "bastion_address_space" {
  type = list(string)
}

variable "bastion_subnet_prefix" {
  type = string
}

variable "linux_vm" {
  type = object({
    size                 = optional(string, "Standard_B2s")
    admin_username       = optional(string, "azureadmin")
    admin_ssh_public_key = optional(string)
    source_image_id      = optional(string)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "StandardSSD_LRS")
    }), {})
  })
}

variable "windows_vm" {
  type    = any
  default = {}
}

variable "admin_passwords" {
  type      = map(string)
  default   = {}
  sensitive = true
}

variable "admin_login_principal_ids" {
  type    = map(string)
  default = {}
}

variable "user_login_principal_ids" {
  type    = map(string)
  default = {}
}

variable "enable_pim_eligible_role_assignments" {
  type    = bool
  default = false
}
