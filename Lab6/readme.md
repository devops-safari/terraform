# Generate documentations for your Terraform project

In this lab you'll learn how to automate generation of Terraform documentation using terraform-docs tool

## Install terraform-docs tool

Follow instructions from this [link](https://terraform-docs.io/user-guide/installation/#pre-compiled-binary)

## Create a Terraform project

Create a `main.tf` file with the following content and initialize the project

```
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
```

## Generate documentation

Run the following command

```
terraform-docs markdown --output-file docs.md ./
```

1. The documentation will be generated in markdown syntax
2. Using the `--output-file` option, the tool will generate a `docs.md` file
3. The documentation will be generated for the current working directory because of the `./` argument

More possible format types are available

- json
- yaml
- xml
- asciidoc
- tfvars

And more can be found in this [page](https://terraform-docs.io/user-guide/configuration/formatter/)

## Preview the generated documentation

Using a website like https://markdownlivepreview.com/ copy the content of `docs.md` and preview the generated documentation
