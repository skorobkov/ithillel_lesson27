terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.21.0"
    }
  }
}

locals {
  iam_user = "arn:aws:iam::278059957414:user/mac"
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Lesson = "27"
    }
  }
}

resource "aws_ecr_repository" "this" {
  name = "example-app"
}

resource "aws_ecr_repository_policy" "this" {
  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Action" : [
          "ecr:*"
        ]
        "Principal" : {
          "AWS" : [
            local.iam_user
          ]
        }
        "Effect" : "Allow",
        "Sid" : "Allow all"
      }
    ]
  })
  repository = aws_ecr_repository.this.name

}
output "ecr_url" {
  value = aws_ecr_repository.this.repository_url
}
