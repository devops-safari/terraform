resource "random_password" "db_password" {
  length = 8
}

resource "docker_network" "blog" {
  name = "blog"
}

resource "docker_image" "wordpress" {
  name = "wordpress"
}

resource "docker_image" "mariadb" {
  name = "mariadb"
}

resource "docker_container" "mariadb" {
  image        = docker_image.mariadb.image_id
  name         = "mariadb"
  network_mode = docker_network.blog.name

  ports {
    internal = 3306
    external = 3306
  }

  env = [
    "MARIADB_USER=wordpress",
    "MARIADB_DATABASE=wordpress",
    "MARIADB_ROOT_PASSWORD=${random_password.db_password.result}"
  ]
}

resource "docker_container" "wordpress" {
  image        = docker_image.wordpress.image_id
  name         = "blog"
  network_mode = docker_network.blog.name
  depends_on   = [docker_container.mariadb]

  ports {
    internal = 80
    external = 80
  }

  env = [
    "WORDPRESS_DB_HOST=mariadb",
    "WORDPRESS_DB_NAME=wordpress",
    "WORDPRESS_DB_USER=root",
    "WORDPRESS_DB_PASSWORD=${random_password.db_password.result}"
  ]
}
