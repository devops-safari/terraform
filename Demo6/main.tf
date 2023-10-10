terraform {}

variable "mysql_host" {
  type        = string
  description = "The URL or IP address of MySQL server"

  validation {
    error_message = "The hostname is not valid"
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.mysql_host))
  }
}

variable "mysql_port" {
  type        = number
  description = "The port for MySQL server"

  validation {
    error_message = "The port should be a number between from 1 to 65535"
    condition     = var.mysql_port >= 1 && var.mysql_port <= 65535
  }
}

variable "mysql_username" {
  type        = string
  description = "The username for MySQL server"
}

variable "mysql_password" {
  type        = string
  sensitive   = true
  description = "The password for MySQL server"
  nullable    = false
}

output "connection_string" {
  value     = "mysql://${var.mysql_username}:${var.mysql_password}@${var.mysql_host}:${var.mysql_port}"
  sensitive = true
}
