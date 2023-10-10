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
  name     = "TerraformDemoRg"
  location = "France Central"
}

resource "azurerm_service_plan" "demo" {
  name                = "demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "demo" {
  name                = "demo36198"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  service_plan_id     = azurerm_service_plan.demo.id

  site_config {
    always_on = false
  }
}

output "website_url" {
  value = azurerm_windows_web_app.demo.default_hostname
}
