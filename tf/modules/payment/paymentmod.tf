resource "vault_generic_secret" "payment_mod" {
  provider = vault.vault_dev
  path     = "secret/development/payment"

  data_json = jsonencode({
    db_user =   var.db_user_pm
    db_password = var.db_password_pm
  })
}

resource "vault_policy" "payment_mod" {
  provider = vault.vault_dev
  name = "${var.service}-${var.environ}"
  #name     = "var.policy_name_pm"

  policy = <<EOT

path "secret/data/development/payment" {
    capabilities = ["list", "read"]
}

EOT
}

resource "vault_generic_endpoint" "payment_mod" {
  provider             = vault.vault_dev
  depends_on           = [vault_auth_backend.userpass_dev]
  path                 = "auth/userpass/users/gateway-development"
  ignore_absent_fields = true

  data_json =  jsonencode({
    policies = ["data.vault_policy.payment_mod.name"]
    password = var.password_pm
  })

}

resource "docker_container" "payment_mod" {
  image = var.docker_container_pm_image
  name  = var.docker_container_pm_name

  env = [
    "VAULT_ADDR=var.VAULT_ADDR_pm",
    "VAULT_USERNAME=var.VAULT_USERNAME_pm",
    "VAULT_PASSWORD=var.VAULT_PASSWORD_pm",
    "ENVIRONMENT=${local.environ}"
  ]

  networks_advanced {
    name = "vagrant_${local.environ}"
  }

  lifecycle {
    ignore_changes = all
  }
}
