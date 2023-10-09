output "public_ip" {
  value       = azurerm_container_group.main.ip_address
  description = "Public IP Address of SonarQube"
}
