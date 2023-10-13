provider "azurerm" {
  features {}
}

variable "name" {
  type = string
}

variable "address_space" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

resource "azurerm_virtual_network" "main" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.rg_location
  address_space       = [ var.address_space ]
}
