terraform {
  backend "s3" {
    bucket         = "global-self-service-dev-terraform-state"
    key            = "account.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.50.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "1.6.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "2.21.0"
    }
  }
}
