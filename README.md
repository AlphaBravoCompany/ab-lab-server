# AB Lab Server Environment

Automatically deploys any number of lab servers with tools in place to run Docker and Kubernetes Labs.

![AlphaBravo](./images/ablogo.png)

These lab server deployments are to be used with the AlphaBravo ABLabs Training Materials and Sessions.

**CAUTION** This release is a Beta public release as it was originally intended to be deployed internal only. There will be costs involved with deploying this, there will be problems when installing this that the end user may need to troubleshoot, and there will be breaking changes introduced in the future. Use at your own risk.

## Items Automatically Installed / Deployed

* Docker
* Code Server
* Rancher MCM UI
* K3d / K3s / RKE2
* Virtual Machines
* Wildcard cert specific to each host via LetsEncrypt

## Basic Deployment (AWS On-Demand Instances, Cloudflare DNS, LetsEncrypt)

* Clone this repo
* `cd ab-lab-server`
* Copy `secrets.yml.dist` to `secrets.yml` and fill in with required fields. Annotations in the `secrets.yml.dist` file explain what each field is for.
* Copy `variables.yml.dist` to `variables.yml` and fill in with required fields (number of servers desired, size of servers etc). Annotations in the `variables.yml.dist` file explain what each field is for.
* Type `make environment` and this will drop you into a Docker container with all the required tools (Ansible, Terraform, etc).
* Type `make setup-aws`. Additional options for `aws-spot` and `digitalocean` will be defined in the future once they are fully tested.


## Additional Deploy Options

There are currently a few options available for how / where to deploy the lab components.

1. Cloud Provider Options: AWS, AWS-Spot, DigitalOcean
2. DNS Provider Options: Cloudflare, Route53, None (Host File Only)
3. SSL Certificate: LetsEncrypt, UserProvided (WIP), SelfSigned (WIP)

### Deploy on AWS-Spot

Coming Soon

### Deploy on DigitalOcean

Coming Soon

### Deploy DNS on Route53

Changing the `dns.service` option in `variables.yml` file will switch from the default `cloudflare` DNS deployment to `route53` DNS.

### Deploy with no DNS and only Host File records

Coming Soon

### Deploy with User Provided Certs

Coming Soon

### Deploy with auto generated, self-signed certs

Coming Soon

## Post Deploy

* Verify deployment by checking links in `./ansible/files/deployment_name/lab-server-info.txt`
* Use the `./ansible/files/deployment_name/lab-server-info.txt` file to distribute access info to students. Make sure to provide them with the generated private ssh key for this deployment located under `./ansible/files/deployment_name/deploymentname-private-key.pem`.

## Accessing the Environments

* Access Code-Server: go to `https://code-yourbranchname-lab1.yourdomain.tld` to login code server. Use the PW you defined in the `secrets.yml` file
* Access to Rancher: go to `https://rancher-yourbranchname-lab1.yourdomain.tld` to login rancher server. Use the PW you defined in the `secrets.yml` file
* Access to Portainer: go to `https://portianer-yourbranchname-lab1.yourdomain.tld` to login Portianer server. Use the PW you defined in the `secrets.yml` file

## Delete the lab-server environments

* From within the `make environment` container, run `make teardown`. Warning, this will destroy ALL LAB SERVERS for this particular branch. Use at your own risk.

## Ansible Command Examples

* Only run the playbook against the group "haproxy_server"
`ansible-playbook -i inventory/yourbranchname/yourbranchname-inventory main.yml --limit "haproxy_server`

* Only run the playbook against the tag "labs"
`ansible-playbook -i inventory/yourbranchname/yourbranchname-inventory main.yml --tags "labs"`

## About Alphabravo

**AlphaBravo** provides products, training and services for Cloud and DevSecOps adoption and acceleration.

Contact **AB** today to learn how we can help you.

* **Web:** https://alphabravo.io
* **Email:** info@alphabravo.io
* **Phone:** 301-337-8141