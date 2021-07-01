#!/usr/bin/env python3


import requests
import time
import sys
import validators
import yaml


## Verify the secrets.yml file exists and can be opened.
try:
    secrets_query = open("secrets.yml")
except:
    exit("\n---\nError: Unable to open secrets.yml file. Please make sure the file exists before continuing.")


try:
    secrets_data = yaml.load(secrets_query, Loader=yaml.FullLoader)
except:
    exit("\n---\nError: Unable to load data from the secrets.yml file. Please make sure the file contains YAML data and try again.")


try:
    letsencrypt_environment = secrets_data['letsencrypt']['environment']
except:
    exit("\n---\nError: The environment variable for letsencrypt is not currently set in the secrets.yml file.  Please review the file and try again.")


if len(sys.argv) > 1:
    getURL = sys.argv[1]
else:
    print("Please pass a URL.")
    exit(1)

getURL = sys.argv[1]

if validators.url(getURL) is True:
    print(f"Valid URL: {getURL}")
else:
    print(f"The URL passed, {getURL}, is not valid.")
    exit(1)

if letsencrypt_environment == "production":

    i = 1
    while i > 0:

        try:
            response = requests.get(getURL)

        except requests.exceptions.SSLError:
            print("TLS Validation Failed. Trying again in 5 seconds.")
            time.sleep(5)

        else:
    
            if response.status_code == 200:
                print(f"Valid TLS Certificate: {getURL} ")
                i = 0

else:
    print(f"\n---\nError: The environment variable for letsencrypt is currently set to: {letsencrypt_environment}.")
    print(f"When deploying, this value must be set to production in order to complete the ArgoCD TLS tests.")
    print(f"Alternatively, the ArgoCD Ingress deployed on the Kubernetes environment can be manually edited, updating the annotation cert-manager.io/cluster-issuer to: letsencrypt-production.")
    exit(1)
    

