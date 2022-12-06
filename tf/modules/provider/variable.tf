variable "vault_token" {
  type = string
  sensitive = true
}

variable "service" {
  type = string
}

variable "vault_address" {
  type = string
  #default = "http://localhost:8201"
}

variable "environ" {
  description = "application envronment"
  type = string
}