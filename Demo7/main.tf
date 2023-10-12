terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "region" {
  type = map(any)

  default = {
    "fr" = {
      "region" = "France Central",
    },
    "us" = {
      "region" = "East US",
    },
  }
}

variable "cidr" {
  default = "172.16.0.0/20"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
