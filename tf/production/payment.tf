resource "vault_generic_secret" "payment_production" {
  provider = vault.vault_prod
  path     = "secret/production/payment"

  data_json = jsonencode({
    db_user = var.db_user[2]
    db_password = var.db_password[2]
  })

}

resource "vault_policy" "payment_production" {
  provider = vault.vault_prod
  name     = "payment-${local.environ}"

  policy = <<EOT

path "secret/data/production/payment" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "payment_production" {
  provider             = vault.vault_prod
  depends_on           = [vault_auth_backend.userpass_prod]
  path                 = "auth/userpass/users/payment-production"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["data.vault_policy.payment_production.name"]
    password = var.password[2]
  })

}

resource "docker_container" "payment_production" {
  image = "form3tech-oss/platformtest-payment"
  name  = "payment_production"

  env = [
    "VAULT_ADDR=http://vault-production:8200",
    "VAULT_USERNAME=var.VAULT_USERNAME[2]",
    "VAULT_PASSWORD=var.VAULT_PASSWORD[2]",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
