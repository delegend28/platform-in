#module "provider" {
#    source = "../modules/provider"
#    vault_token = "f23612cf-824d-4206-9e94-e31a6dc8ee8d"
#    vault_address = "http://localhost:8201"
#    environ = "development"
#}

module "frontend" {
    source = "../modules/frontend"
    docker_container_fe_image = "docker.io/nginx:latest"
    docker_container_fe_name = "frontend_development"
}

module "account" {
    source = "../modules/account"
    db_user_acc = "account"
    db_password_acc = "965d3c27-9e20-4d41-91c9-61e6631870e7"
    service = "account"
    environ = "development"
    acct_policy_passwd = "123-account-development"
    docker_container_acc_image = "form3tech-oss/platformtest-account"
    docker_container_acc_name = "account_development"
    VAULT_ADDR_ACC = "http://vault-development:8200"
    VAULT_USERNAME_ACC = "account-development"
    VAULT_PASSWORD_ACC = "123-account-development"
}


module "gateway" {
    source = "../modules/gateway"
    db_user_gw = "gateway"
    db_password_gw = "10350819-4802-47ac-9476-6fa781e35cfd"
    service = "gateway"
    environ = "development"
    password_gw = "123-gateway-development"
    docker_container_gw_image = "form3tech-oss/platformtest-gateway"
    docker_container_gw_name = "gateway_development"
    VAULT_ADDR_gw = "http://vault-development:8200"
    VAULT_USERNAME_gw = "gateway-development"
    VAULT_PASSWORD_gw = "123-gateway-development"
}

module "payment" {
    source = "../modules/payment"
    db_user_pm = "payment"
    db_password_pm = "a63e8938-6d49-49ea-905d-e03a683059e7"
    service = "payment"
    environ = "development"
    password_pm = "123-payment-development"
    docker_container_pm_image = "form3tech-oss/platformtest-payment"
    docker_container_pm_name = "payment_development"
    VAULT_ADDR_pm = "http://vault-development:8200"
    VAULT_USERNAME_pm = "payment-development"
    VAULT_PASSWORD_pm = "123-payment-development"
}


