resource "docker_container" "frontend_mod" {
  image = var.docker_container_fe_image
  name  = var.docker_container_fe_name

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
