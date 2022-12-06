resource "vault_generic_secret" "gateway_development" {
  provider = vault.vault_dev
  path     = "secret/development/gateway"

  data_json = jsonencode({
    db_user =   var.db_user[1]
    db_password = var.db_password[1]
  })
}

resource "vault_policy" "gateway_development" {
  provider = vault.vault_dev
  name     = "gateway-${local.environ}"

  policy = <<EOT

path "secret/data/development/gateway" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "gateway_development" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/gateway-development"
  ignore_absent_fields = true

  data_json =  jsonencode({
    policies = ["data.vault_policy.gateway_development.name"]
    password = var.password[1]
  })

}

resource "docker_container" "gateway_development" {
  image = "form3tech-oss/platformtest-gateway"
  name  = "gateway_${local.environ}"

  env = [
    "VAULT_ADDR=http://vault-development:8200",
    "VAULT_USERNAME=var.VAULT_USERNAME[1]",
    "VAULT_PASSWORD=var.VAULT_PASSWORD[1]",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
