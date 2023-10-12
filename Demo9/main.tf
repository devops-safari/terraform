terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  sa_name = "demostaticwebsitesa"
  rg_name = "ExistingRG"
}

data "azurerm_storage_account" "main" {
  name                = local.sa_name
  resource_group_name = local.rg_name
}

resource "null_resource" "upload_static_content" {
  provisioner "local-exec" {
    command = "az storage blob upload-batch --account-name ${local.sa_name} --source ./static-content --destination \\$web"
  }
}

output "endpoint" {
  value = data.azurerm_storage_account.main.primary_web_endpoint
}
