resource "azurerm_resource_group" "main" {
  name     = "SonarQubeRG"
  location = var.rg_location
}

resource "azurerm_container_group" "main" {
  name                = "sonarqube"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"

  container {
    name   = "sonar"
    image  = "sonarqube"
    cpu    = 2
    memory = 4

    ports {
      port     = 9000
      protocol = "TCP"
    }

    environment_variables = {
      SONAR_ES_BOOTSTRAP_CHECKS_DISABLE = true
    }
  }
}
