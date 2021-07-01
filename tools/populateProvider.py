#!/usr/bin/env python3

import yaml
import fileinput
import sys
from pygit2 import Repository

## Get current GIT branch and set as deployment_name
deployment_name = Repository('.').head.shorthand.lower()

## Set provider.tf file location
provider_file = f"terraform/{deployment_name}/provider.tf"

## Load the YAML files for reading.
variables_query = open("variables.yml")
secrets_query = open("secrets.yml")

## Capture the data from the YAML files into a list.
variables_data = yaml.load(variables_query, Loader=yaml.FullLoader)
secrets_data = yaml.load(secrets_query, Loader=yaml.FullLoader)

## Terraform
terraform_required_version = variables_data['terraform']['required_version']

## Digital Ocean
digitalocean_provider_source = variables_data['digitalocean']['provider_source']
digitalocean_provider_version = variables_data['digitalocean']['provider_version']

## Cloudflare
cloudflare_provider_source = variables_data['cloudflare']['provider_source']

## Backend
terraform_backend_type = variables_data['terraform']['backend_type']
terraform_backend_dir = variables_data['terraform']['backend_directory']
terraform_backend_key = f"{terraform_backend_dir}/{deployment_name}/terraform.tfstate"
aws_access_key = secrets_data['aws']['access_key']
aws_secret_key = secrets_data['aws']['secret_key']
aws_bucket_name = variables_data['aws']['bucket_name']
aws_region = variables_data['aws']['region']

## Modify PROVIDER.TF file
with open(provider_file, 'r') as f:
    provider_data = f.read()

## Replace Terraform Data
provider_data = provider_data.replace('replace-me-terraform-required-version', terraform_required_version)

## Replace Digital Ocean Data
provider_data = provider_data.replace('replace-me-digitalocean-provider-source', digitalocean_provider_source)
provider_data = provider_data.replace('replace-me-digitalocean-provider-version', digitalocean_provider_version)

## Replace Cloudflare Data
provider_data = provider_data.replace('replace-me-cloudflare-provider-source', cloudflare_provider_source)

## Replace Backend Data
provider_data = provider_data.replace('replace-me-terraform-backend-type', terraform_backend_type)
provider_data = provider_data.replace('replace-me-terraform-backend-key', terraform_backend_key)
provider_data = provider_data.replace('replace-me-aws-access-key', aws_access_key)
provider_data = provider_data.replace('replace-me-aws-secret-key', aws_secret_key)
provider_data = provider_data.replace('replace-me-aws-bucket-name', aws_bucket_name)
provider_data = provider_data.replace('replace-me-aws-region', aws_region)

## Write data to the provider file.
with open(provider_file, 'w') as f:
    f.write(provider_data)

## Close file after writing has been completed.
f.close()
variables_query.close()
secrets_query.close()

print(f"Wrote variables to {provider_file}.")