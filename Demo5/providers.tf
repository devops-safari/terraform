terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }

  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/50753270/terraform/state/default"
    lock_address   = "https://gitlab.com/api/v4/projects/50753270/terraform/state/default/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/50753270/terraform/state/default/lock"
  }
}

provider "azurerm" {
  features {}
}
