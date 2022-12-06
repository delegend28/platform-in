variable "service" {
  type = string
}

variable "environ" {
  description = "application envronment"
  type = string
}

variable "db_user_pm" {
  description = "db -user id"
  type = string
}

variable "db_password_pm" {
  description = "db -user password"
  type = string
  sensitive = true
}

variable "password_pm" {
  description = "account policy password"
  type = string
  sensitive = true
}

variable "docker_container_pm_name" {
  type = string
}

variable "docker_container_pm_image" {
  type = string
}

variable "VAULT_ADDR_pm" {
  type = string
}

variable "VAULT_USERNAME_pm" {
  description = "vault username"
  type = string
}

variable "VAULT_PASSWORD_pm" {
  description = "vault password"
  type = string
  sensitive = true
}
