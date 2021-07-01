# AB Lab Environment

Automatically deploys any number of lab servers with tools in place to run Docker and Kubernetes Labs.

# Items Automatically Installed

* Docker
* Code Server
* Rancher UI
* K3d
* Wildcard cert specific to the host

# Deploying

* Generate ssl-dhparams.pem by running `openssl dhparam -out ssl-dhparams.pem 2048` and place that file in `./ansible/files`
* Copy `secrets.yml.dist` to `secrets.yml` and fill in with required fields
* Change number of servers desired in the `variables.yml` file
* Type `make setup`

# Post Deploy

* Use the `./ansible/files/deployment_name/lab-server-info.txt` file to distrubute access info to students. Make sure to provide them with the generated private ssh key for this deployment.

MORE INSTRUCTIONS COMING LATER.