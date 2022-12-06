resource "vault_generic_secret" "gateway_production" {
  provider = vault.vault_prod
  path     = "secret/production/gateway"

  data_json = jsonencode({
    db_user  = var.db_user[1],
    db_password = var.db_password[1]
  })

}

resource "vault_policy" "gateway_production" {
  provider = vault.vault_prod
  name     = "gateway-${local.environ}"

  policy = <<EOT

path "secret/data/production/gateway" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "gateway_production" {
  provider             = vault.vault_prod
  depends_on           = [vault_auth_backend.userpass_prod]
  path                 = "auth/userpass/users/gateway-production"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.gateway_production.name"]
    password = var.password[1]
  })
}

resource "docker_container" "gateway_production" {
  image = "form3tech-oss/platformtest-gateway"
  name  = "gateway_production"

  env = [
    "VAULT_ADDR=http://vault-production:8200",
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

