resource "vault_generic_secret" "gateway_mod" {
  provider = vault.vault_dev
  path     = "secret/development/gateway"

  data_json = jsonencode({
    db_user =   var.db_user_gw
    db_password = var.db_password_gw
  })
}

resource "vault_policy" "gateway_mod" {
  provider = vault.vault_dev
  name = "${var.service}-${var.environ}"
  #name     = "var.policy_name_gw"

  policy = <<EOT

path "secret/data/development/gateway" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "gateway_mod" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/gateway-development"
  ignore_absent_fields = true

  data_json =  jsonencode({
    policies = ["data.vault_policy.gateway_mod.name"]
    password = var.password_gw
  })

}

resource "docker_container" "gateway_mod" {
  image = var.docker_container_gw_image
  name  = var.docker_container_gw_name

  env = [
    "VAULT_ADDR=var.VAULT_ADDR_gw",
    "VAULT_USERNAME=var.VAULT_USERNAME_gw",
    "VAULT_PASSWORD=var.VAULT_PASSWORD_gw",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
