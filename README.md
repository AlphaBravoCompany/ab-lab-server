# AB Lab Environment

Automatically deploys any number of lab servers with tools in place to run Docker and Kubernetes Labs.

# Items Automatically Installed

* Docker
* Code Server
* Rancher UI
* K3d
* Wildcard cert specific to each host

# Deploying

* `cd lab-server`
* Copy `secrets.yml.dist` to `secrets.yml` and fill in with required fields
* Change number of servers desired and size of server in the `variables.yml` file
* Type `make environment` and this will drop you into a Docker container with all the required tools (ansible, terraform, etc)
* Type `make setup-aws`

# Post Deploy

* Verify deployment by checking links in `./ansible/files/deployment_name/lab-server-info.txt`
* Use the `./ansible/files/deployment_name/lab-server-info.txt` file to distrubute access info to students. Make sure to provide them with the generated private ssh key for this deployment located under `./ansible/files/deployment_name/deploymentname-private-key.pem`.

# Accessing the Environments

* Access Code-Server: go to `https://yourbranchname-lab1.ablabs.io:11443` to login code server. Use the PW you defined in the `secrets.yml` file
* Access to Rancher: go to `https://yourbranchname-lab1.ablabs.io:12443` to login rancher server. Use the PW you defined in the `secrets.yml` file
* Access to Portainer: go to `https://yourbranchname-lab1.ablabs.io:9000` to login portianer server. Use the PW you defined in the `secrets.yml` file

# Delete the lab environments

* From within the `make environment` container, run `make teardown`