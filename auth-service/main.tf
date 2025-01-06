provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = var.aws_endpoint
    sqs      = var.aws_endpoint
  }
}

resource "aws_dynamodb_table" "auth_tokens" {
  name           = "auth_tokens"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "token"
  
  attribute {
    name = "token"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name               = "user-index"
    hash_key           = "user_id"
    projection_type    = "ALL"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }
}

resource "aws_sqs_queue" "auth_events" {
  name = "auth-events"
}