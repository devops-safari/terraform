terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
    }
  }
}

provider "fly" {
  fly_api_token = "fo1_uY8e22fQOgdu681iwRCqmL4tSfuRrAisY5p0_5dHdkQ"
}

variable "instances" {
  default = ["monday", "tuesday"]
}

resource "fly_app" "app" {
  name = "say-hi"
  org  = "personal"
}

resource "fly_ip" "ip" {
  app        = fly_app.app.name
  type       = "v4"
  depends_on = [fly_app.app]
}

resource "fly_machine" "instance" {
  for_each   = toset(var.instances)
  app        = fly_app.app.name
  name       = "${fly_app.app.name}-${each.value}"
  image      = "mabotn/say-hi"
  region     = "cdg"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.app]

  env = {
    PORT = 80
    NAME = upper(each.value)
  }

  services = [{
    protocol      = "tcp"
    internal_port = 80

    ports = [{
      port     = 80
      handlers = ["http"]
    }]
  }]
}

output "app_url" {
  value = fly_app.app.appurl
}
