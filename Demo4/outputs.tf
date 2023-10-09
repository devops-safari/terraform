output "blog_ip" {
  value = docker_container.wordpress.network_data.0.ip_address
}

output "db_password" {
  value     = random_password.password.result
  sensitive = true
}
