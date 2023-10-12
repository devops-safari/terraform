terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "name" {
  type = string
  description = "The name which should be used for all resources in this example."

  validation {
    condition     = length(var.name) > 0 && length(var.name) < 10
    error_message = "The name must be less than 10 characters long."
  }
}

variable "location" {
  type = string
  description = "The Azure Region in which all resources in this example should be created."

  validation {
    condition     = contains(["francecentral", "easus"], var.location)
    error_message = "Location ${var.location} is not supported."
  }
}

resource "azurerm_resource_group" "demo" {
  name     = var.name
  location = var.location

  tags = {
    environment = "Demo"
  }
}

output "rg_id" {
  value = azurerm_resource_group.demo.id
}
