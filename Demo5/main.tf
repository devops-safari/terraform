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

resource "azurerm_resource_group" "demo" {
  name     = "ExistingRG"
  location = "East US"

  tags = {
    purpose      = "training"
    organization = "sparks"
  }
}
