resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image        = docker_image.nginx.image_id
  name         = "web-server"

  ports {
    internal = 80
    external = 80
  }
}
