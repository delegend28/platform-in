
resource "docker_container" "frontend_production" {
  image = "docker.io/nginx:1.22.0-alpine"
  name  = "frontend_${local.environ}"

  ports {
    internal = 80
    external = 4081
  }

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}

