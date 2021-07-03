# AB Lab Environment

Automatically deploys any number of lab servers with tools in place to run Docker and Kubernetes Labs.

# Items Automatically Installed

* Docker
* Code Server
* Rancher UI
* K3d
* Wildcard cert specific to each host

# Deploying

* Copy `secrets.yml.dist` to `secrets.yml` and fill in with required fields
* Change number of servers desired and size of server in the `variables.yml` file
* Type `make setup`

# Post Deploy

* Verify deployment by checking links in `./ansible/files/deployment_name/lab-server-info.txt`
* Use the `./ansible/files/deployment_name/lab-server-info.txt` file to distrubute access info to students. Make sure to provide them with the generated private ssh key for this deployment located under `./ansible/files/deployment_name/deploymentname-private-key.pem`.

MORE INSTRUCTIONS COMING LATER.