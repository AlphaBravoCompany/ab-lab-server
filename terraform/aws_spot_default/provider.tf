terraform {
  required_providers {
    digitalocean = {
      source = "replace-me-digitalocean-provider-source"
      version = "replace-me-digitalocean-provider-version"
    }
    cloudflare = {
      source = "replace-me-cloudflare-provider-source"
    }
  }
  backend "replace-me-terraform-backend-type" {
    bucket = "replace-me-aws-bucket-name"
    access_key = "replace-me-aws-access-key"
    secret_key = "replace-me-aws-secret-key"
    region = "replace-me-aws-bucket-region"
    key = "replace-me-terraform-backend-key"
  }
  required_version = ">= replace-me-terraform-required-version"
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region     = "replace-me-aws-region"
  access_key = "replace-me-aws-access-key"
  secret_key = "replace-me-aws-secret-key"
}