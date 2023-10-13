terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

module "resource_group" {
  source = "./modules/resource_group"
  name = var.rg_name
  location = var.rg_location
}

module "virtual_network" {
  source = "./modules/virtual_network"
  name = var.vnet_name
  address_space = var.vnet_address_space
  rg_name = module.resource_group.name
  rg_location = module.resource_group.location
}
