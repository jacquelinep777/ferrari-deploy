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

variable "cia" {
  type = string
}

variable "infrastructure_subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "runner_image_name" {
  type = string
}

variable "runner_image_tag" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "github_pat" {
  type      = string
  sensitive = true
}

variable "runner_extra_labels" {
  type    = list(string)
  default = []
}
