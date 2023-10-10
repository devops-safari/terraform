terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
    }
  }
}

provider "fly" {
  fly_api_token = "fo1__gVTnTG_oPD4PS-AagKnjKppS6dKFR_Xynw6rjYX7ds"
}

variable "blog_name" {}

locals {
  blog_url = "https://${fly_app.main.name}.fly.dev"
}

output "blog_url" {
  value = local.blog_url
}

resource "fly_app" "main" {
  name = var.blog_name
  org  = "personal"
}

resource "fly_ip" "ip" {
  app        = fly_app.main.name
  type       = "v4"
  depends_on = [fly_app.main]
}

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
