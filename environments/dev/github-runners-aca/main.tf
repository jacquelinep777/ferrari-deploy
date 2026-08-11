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

module "github_runners_aca" {
  source = "git::ssh://git@github.com-jacquelinep777/jacquelinep777/xx-azurerm-stack-github-runners-aca.git?ref=v0.0.1"

  workload    = var.workload
  environment = var.environment
  location    = var.location
  region_code = var.region_code
  instance    = var.instance
  cia         = var.cia

  infrastructure_subnet_id = var.infrastructure_subnet_id
  acr_id                   = var.acr_id
  acr_login_server         = var.acr_login_server
  runner_image_name        = var.runner_image_name
  runner_image_tag         = var.runner_image_tag

  github_owner        = var.github_owner
  github_repository   = var.github_repository
  github_pat          = var.github_pat
  runner_extra_labels = var.runner_extra_labels
}
