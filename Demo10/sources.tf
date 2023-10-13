data "hcp_vault_secrets_app" "main" {
  app_name = "Terraform"
}

data "hcp_vault_secrets_secret" "key" {
  app_name    = data.hcp_vault_secrets_app.main.app_name
  secret_name = "GODADDY_API_KEY"
}

data "hcp_vault_secrets_secret" "secret" {
  app_name = data.hcp_vault_secrets_app.main.app_name
  secret_name = "GODADDY_API_SECRET"
}
