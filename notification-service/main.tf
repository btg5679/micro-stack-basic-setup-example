provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    sns = var.aws_endpoint
    sqs = var.aws_endpoint
  }
}

resource "aws_sns_topic" "notifications" {
  name = "user-notifications"
}

resource "aws_sqs_queue" "notification_queue" {
  name = "notification-queue"
}

resource "aws_sns_topic_subscription" "notification_subscription" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notification_queue.arn
}