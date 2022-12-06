resource "docker_container" "frontend_development" {
  image = "docker.io/nginx:latest"
  name  = "frontend_${local.environ}"

  ports {
    internal = 80
    external = 4080
  }

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
