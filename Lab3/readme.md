# Deploy a Ghost blog to fly.io

In this lab you'll learn how to deploy a ghost blog to fly.io, you should create a Fly.io account and generate an API token

## Create your Fly account and API token

Go to [fly.io](https://fly.io) website and click the `Sign Up` button, it's up to you to sign up using your GitHub or Google account, or traditionally, using your email address

After you sign in to your account, on the top navigation bar, click on `Account` menu and then click on `Access Tokens`

On the right side, a tiny form with the title `Create token` should have an input in which you can write a name for your new token, name it as you like, for example `tf-training` and click `Create`

A token will be generated, copy it in a safe place, you will need it later

## Setup your Terraform project

Start the Terminal and create a new directory

```
mkdir tf-fly-blog
cd tf-fly-blog
```

Create a `main.tf` file and add the following lines

```
terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
    }
  }
}

provider "fly" {
  fly_api_token = ""
}
```

Make sure to add the token that you have previously generated to the `fly_api_token` attribute within the `fly` provider block

You can learn more about this provider [here](https://registry.terraform.io/providers/fly-apps/fly/0.0.23)

Now it`s time to initialize your Terraform project by running the following command

```
terraform init
```

Expect to see the following message

```
Terraform has been successfully initialized!
```

## Add resources to your main.tf

You are going to create a fly.io app that contains an instance running the ghost docker image, you can learn more about it [here](https://hub.docker.com/_/ghost)

You will also use the `locals` block to generate the URL of your blog, which will be based on the value you are providing later to Terraform as a variable

To achieve this, add the following lines to your `main.tf` file

```
variable "blog_name" {}

locals {
  blog_url = "https://${fly_app.main.name}.fly.dev"
}

output "blog_url" {
  value = local.blog_url
}
```

In order to deploy your Ghost instance, you will have to create the fly.io app and an IP address first, as follows

```
resource "fly_app" "main" {
  name = var.blog_name
  org  = "personal"
}

resource "fly_ip" "ip" {
  app        = fly_app.main.name
  type       = "v4"
  depends_on = [fly_app.main]
}
```

The fly.io app itself is not enough, it will be just a wrap of the instance running your Ghost blog, its resource block should look like that

```
resource "fly_machine" "main" {
  app        = fly_app.main.name
  name       = "ghost-instance"
  image      = "ghost"
  region     = "cdg"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.main]

  env = {
    PORT     = 2368
    NODE_ENV = "development"
    url      = local.blog_url
  }

  services = [{
    protocol      = "tcp"
    internal_port = 2368

    ports = [{
      port     = 80
      handlers = ["http"]
      },
      {
        port     = 443
        handlers = ["http", "tls"]
    }]
  }]
}
```

## Deploy the Ghost blog

There are different ways to deploy this blog

1. By specifying the value of `blog_name` variable manually after running the `terraform apply` command

2. By specifying the value of this variable by using the `-var` option, the command to run in your CLI should look like that

```
terraform apply -var blog_name=my-blog-name
```

3. By creating a `terraform.tfvars` file that contains the variable and its value, the file content should look like that

```
blog_name = "my-blog-name"
```

It`s up to you to decide what method you want to use, all will give the same result by the end

## Test your Ghost blog

You should expect the following output after you deploy your Ghost blog

```
blog_url = "https://my-blog-name.fly.dev"
```

Copy the URL from your terminal and paste it to your browser

> **Note:** it will probably take few minutes for the URL to be working