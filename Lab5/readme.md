# Export a Linux VM using Terraformer

In this lab you'll learn how to export a Linux VM from Azure into Terraform configuration files using Terraformer tool.

## Install Terraformer

Follow instructions from this [link](https://github.com/GoogleCloudPlatform/terraformer/tree/master#installation) to install terraformer in your computer

## Create a main.tf file

Add the following provider to your `main.tf` file

```
required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "3.75.0"
  }
}
```

Don't forget to initiate terraform where you created the `main.tf` file

## Setup environment variables required by Terraformer

Create the following environment variables before using Terraformer

- `ARM_SUBSCRIPTION_ID`
- `ARM_CLIENT_ID`
- `ARM_TENANT_ID`
- `ARM_CLIENT_SECRET`

If you have Linux or macOS run the following command for each of these variables

```
export ARM_SUBSCRIPTION_ID=[your-subscription-id]
```

If you have Windows, run the following command

```
set ARM_SUBSCRIPTION_ID=[your-subscription-id]
```

## Export infrastructure

Run the import command to import the VM, VNET and Managed Disk from the LinuxRG resource group in Azure

```
terraformer import azure -R LinuxRG -r virtual_machine,virtual_network,disk
```

Notice that a directory with the name `generated/azurerm` was created and it contains more 3 directories

- `disk`
- `virtual_machine`
- `virtual_network`

Terraformer will only import resources based on the requested types, a full list of supported types can be found [here](https://github.com/GoogleCloudPlatform/terraformer/blob/master/docs/azure.md#list-of-supported-azure-resources)