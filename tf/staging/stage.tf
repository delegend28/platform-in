module "staging" {
    source = "../development"
    environ = "development"
    vault_token = "f23612cf-824d-4206-9e94-e31a6dc8ee8d"
    vault_address = "http://localhost:8201"
    db_user =  ["account", "gateway", "payment"]
    db_password = ["965d3c27-9e20-4d41-91c9-61e6631870e7", "10350819-4802-47ac-9476-6fa781e35cfd", "a63e8938-6d49-49ea-905d-e03a683059e7"]
    password = ["123-account-development", "123-gateway-development", "123-payment-development"]
    VAULT_USERNAME = ["account-development", "gateway-development", "payment-development"]
    VAULT_PASSWORD = ["123-account-development", "123-gateway-development", "123-payment-development"]
}