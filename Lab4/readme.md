# Deploy an Nginx docker container

In this lab you'll learn how to deploy an nginx container to your local machine, you should have Docker installed.

## Create Terraform project files

You will need 3 files for this project before you can create your Nginx container

- `providers.tf` : contains the list providers used to create the nginx  container
- `outputs.tf` : contains the list of outputs we want to see after creating the nginx container
- `main.tf` : contains the list of resources needed to run the nginx container

## Setup your providers.tf file

Add the following provider to your `providers.tf` file

```
required_providers {
  docker = {
    source  = "kreuzwerker/docker"
    version = "~> 3.0.1"
  }
}
```

Don't forget to add this within a `terraform` block and also don't foget to create an empty `provider` block for `docker`

## Setup your outputs file

Add the following output to your `outputs.tf` file

```
output "nginx_url" {
  value = "http://localhost"
}
```

## Setup your main.tf file

Docker will need an image in order to create a container, the following resource will let docker fetch the nginx image

```
resource "docker_image" "nginx" {
  name = "nginx"
}
```

The actual nginx container can be created using the following resource

```
resource "docker_container" "nginx" {
  image        = docker_image.nginx.image_id
  name         = "web-server"

  ports {
    internal = 80
    external = 80
  }
}
```

## Run and test your nginx container

Run `terraform apply` and then open `http://localhost` in your browser

You can also verify that docker has a `web-server` container by running the following command

```
docker ps
```