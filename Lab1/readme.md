# How to install Terraform

This guide requires basic CLI knowledge, after completing these steps you'll learn how to install Terraform.

This guide was designed to install Terraform 1.6 on devices running

- macOS 14, brew should be installed
- Windows 11 Pro
- Ubuntu 20.04 LTS

## First step : Download Terraform

Go to Terraform [download page](https://developer.hashicorp.com/terraform/downloads)

## Second step : Install Terraform

### For Windows

Download [terraform.exe](https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_windows_amd64.zip) and move it to `C:\Windows` directory

### For Linux

Run the following commands one by one

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform=1.6.0-1
```

### For macOS

If you don't have brew already installed, follow steps from this [link](https://brew.sh)

Add HashiCorp repository to brew using this command

```
brew tap hashicorp/tap
```

Finally, install Terraform using this command

```
brew install hashicorp/tap/terraform@1.6.0
```

## Last step : Validate Terraform installation

Simply run the following command

```
terraform version
```

Expect to see the v1.6.0 installed

```
Terraform v1.6.0
```

