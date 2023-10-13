provider "azurerm" {
  features {}
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

resource "azurerm_resource_group" "main" {
  name = var.name
  location = var.location
}

output "name" {
  value = azurerm_resource_group.main.name
}

output "location" {
  value = azurerm_resource_group.main.location
}
