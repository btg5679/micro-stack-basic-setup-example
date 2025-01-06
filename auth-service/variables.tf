variable "aws_endpoint" {
  type        = string
  description = "AWS endpoint for LocalStack"
}

variable "skip_credentials_validation" {
  type    = bool
  default = true
}

variable "skip_metadata_api_check" {
  type    = bool
  default = true
}

variable "skip_requesting_account_id" {
  type    = bool
  default = true
}