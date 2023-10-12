# Generate documentations for your Terraform project

In this lab you'll learn how to build a module that deploys a Linux web VM.

## Setup the module

Create a `dev-vm` directory and within it:

- Create a `cloudinit.conf` file with content from this [link](https://github.com/devops-safari/terraform/blob/main/Lab7/dev-vm/cloudinit.conf). This file will be used to auto install Nginx in the VM that will be created

- Create a `main.tf` file with content from this [link](https://github.com/devops-safari/terraform/blob/main/Lab7/dev-vm/main.tf). This file contains the required resources and configurations to setup a new virtual machine, including its:

  - network security group
  - public ip address
  - network interface
  - virtual network
  - subnet
  - disk
  - NSG rules to allow incoming SSH, HTTP and HTTPS requests

## Setup your Terraform project

Create a `main.tf` file in the root directory that contains `dev-vm` directory that you created previously

```
module "dev-vm" {
  vm_name = ""
  source = "./dev-vm"
}
```

Update the `vm_name` to your name and and run `terraform init` and then `terraform apply`

The output should contain an IP address, take it to your web browser and expect to see the a web page from Nginx
