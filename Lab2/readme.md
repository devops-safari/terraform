# Deploy a SQL database to Azure

In this lab you'll learn how to deploy a SQL database to Microsoft Azure, you should have Azure CLI installed in order to complete this exercise

## Install Azure CLI

Follow steps from this official documentation [link](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Connect to Microsoft Azure using the CLI

Run the following command

```
az login
```

Expect to see the following message after you connect to Microsoft Azure

```
You have logged into Microsoft Azure!
```

## Setup your Terraform project

Start the Terminal and create a new directory

```
mkdir tf-sql-az
cd tf-sql-az
```

Create a `main.tf` file and add the following lines

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

These lines will tell Terraform which providers with their versions we will be using, in this example we're using `hashicorp/azurerm` version 3.74.0

The provider `azurerm` block contains configurations related to how we'll be using it

You can learn more about this provider [here](https://registry.terraform.io/providers/hashicorp/azurerm/3.74.0).

Now that your main.tf contains the list of required providers, you can initialize this directory to be a Terraform project by running the following command

```
terraform init
```

Expect to see the following message

```
Terraform has been successfully initialized!
```

## Add resources to your main.tf

Now that your directory became a Terraform project, you can add resources that you'll let Terraform manage for you

Add the following lines to your `main.tf` file

```
resource "azurerm_resource_group" "main" {
  name     = "MySqlRg"
  location = "France Central"
}

resource "azurerm_mssql_server" "main" {
  name                         = "mysqlserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "main" {
  name         = "my-sql-db"
  server_id    = azurerm_mssql_server.main.id
  license_type = "BasePrice"
  sku_name     = "Basic"
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.main.fully_qualified_domain_name
}
```

The following 4 resources will manage your deployment of the managed SQL database in Azure

- `azurerm_resource_group` : the Azure resource group in which your SQL database will be created
- `azurerm_mssql_server` : the SQL Server instance that will host your SQL database
- `azurerm_mssql_database` : the actual SQL Database that you want to manage using Terraform

Make sure to add your name and some random digits in each `name` property of these resources to avoid having an error of an already used name

Each resource contains a set of properties that describes how we want that resource to be when created or updated

The `output` block will be used to display the URL of the SQL server after the deployment is complete

## Deploy the SQL database

Before you deploy your SQL database, you can actually have an idea on what Terraform is planning to do by running the following command

```
terraform plan
```

Expect Terraform to output : 3 to add, 0 to change, 0 to destroy.

Now that no error occured with the plan command, you can deploy by running

```
terraform apply
```

Terraform will try to examine Azure and see if these resources can be really deployed, if no issue is found, it will ask you to type `yes` before actually performing the deployment, just do it.

Terraform will then start creating resources for you, you should see an output like that

```
azurerm_resource_group.main: Creating...
azurerm_resource_group.main: Creation complete after 1s
...
```

The entire deployment operation will take few minutes and you should expect Terraform to display the following

```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

sql_server_fqdn = "mysqlserver.database.windows.net"
```

Congratulations, your SQL database is now created and can be used by your Team

If you run the `apply` command again, Terraform will tell you : No changes. Your infrastructure matches the configuration.

That means Terraform compared your `main.tf` file against the actual deployed resources, in fact, Terraform has generated previously a `terraform.tfstate` file that contains the state of the previous deployment, check it out

## Destroy the SQL database

You no longer need this SQL database and you want to delete it, simply run the following command

```
terraform destroy -auto-approve
```

The `-auto-approve` option will tell Terraform that you already said yes to performing the delete operation

Note the delete operation will take couple minutes to complete