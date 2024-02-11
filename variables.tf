variable "prefix" {
  default = "terraform"
}

variable "project" {
  default = "devops-app"
}

variable "contact" {
  default = "nguyenlekhanh811@gmail.com"
}

variable "db_username" {
  description = "Username for the RDS Postgres instance"
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
}

variable "bastion_key_name" {
  default = "key_pair_name_from_aws"
}

variable "ecr_image_api" {
  description = "ECR Image for API"
  default     = "<APP ECR Image URL>:latest"
}

variable "ecr_image_proxy" {
  description = "ECR Image for proxy"
  default     = "<App ECR Image for Proxy>:latest"
}

variable "django_secret_key" {
  description = "Secret key for Django app"
}

variable "dns_zone_name" {
  description = "Domain name"
  default     = "test.com"
}

variable "subdomain" {
  description = "Subdomain per environment"
  type        = map(string)
  default = {
    production = "api"
    staging    = "api.staging"
    dev        = "api.dev"
  }
}

