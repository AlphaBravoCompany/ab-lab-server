#!/usr/bin/env python3

import configparser
import os.path
import os
from pathlib import Path
from pygit2 import Repository
import subprocess
import re

# ## Update this list should additional roles be added in Ansible.
# configList = ['ha_masters']

## Set required variables.
ipAddress = "localhost"
getBranch = Repository('.').head.shorthand.lower()

# ## Read the Ansible inventory file.
# config = configparser.ConfigParser(allow_no_value=True)
# config.read(f'ansible/inventory/{getBranch}/{getBranch}-inventory')

# ## Get a list of IP addresses from the Ansible inventory file, generated by Terraform.
# for item in configList:
#     for key in config[item]:
#         ipAddresses.append(key)

## Modify KUBECONFIG file
with open(f'ansible/files/{getBranch}/kubeconfig/config', 'r') as f:
    kubeconfig_file = f.read()

kubeconfig_file = re.sub(r'([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})', ipAddress, kubeconfig_file)

with open(f'ansible/files/{getBranch}/kubeconfig/config', 'w') as f:
    f.write(kubeconfig_file)