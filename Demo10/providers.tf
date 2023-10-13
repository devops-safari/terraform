terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.72.0"
    }

    godaddy = {
      source  = "n3integration/godaddy"
      version = "1.9.1"
    }
  }

  backend "remote" {
    organization = "mabotn"

    workspaces {
      name = "training"
    }
  }
}

provider "godaddy" {
  key    = data.hcp_vault_secrets_secret.key.secret_value
  secret = data.hcp_vault_secrets_secret.secret.secret_value
}

provider "hcp" {
  project_id    = var.project_id
  client_id     = var.client_id
  client_secret = var.client_secret
}
