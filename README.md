# create another hetzner cloud server with terraform

This repository provides a tool to request and setup another virtual machine on the hetzner cloud.

By specifiying the token you implicitly specify the project this machine will belong to.

Projects: https://console.hetzner.cloud/projects

## usage

0. have terraform ready, e.g. as in https://www.terraform.io/docs/cli/install/apt.html
1. create a terraform.tfvars in the directory where this README.md is. Example:

```ini
hcloud_token="<my-hcloud-token>"
# https://console.hetzner.cloud/projects - choose projects - security - api-token

hetzner_machine_type="cx11"
hetzner_machine_os="debian-10"
hetzner_machine_additional_packages="vim screen tmux apt-transport-https ca-certificates curl lsb-release"
# Consider: sudo git gnupg pass iotop ncdu iftop dnsutils tcpdump
# Seem to be installed in any case: rsync tree wget

machine_name="my-test"
# if co-workers use the same project, prevent overlapping names of machines.
# only use valid dns hostname characters: a-z0-9 and -

# if already part of the project:
hetzner_additional_public_key_ids = ["pf-local-machines"]

# upload one from the machine that you call terraform on:
ssh_private_key="/home/programmfabrik/local_machines"
ssh_public_key="/home/programmfabrik/local_machines.pub"
ssh_key_name="local_machines"
```

   Available variables: see below and in variables.tf

2. run terraform in the directory where this README.md is:

```
terraform init     # Prepare your working directory for other commands
terraform validate # Check whether the configuration is valid
terraform plan     # Show changes required by the current configuration
terraform apply    # Create or update infrastructure

# when you are done using the VM do not forget to stop generating costs:

terraform destroy  # Destroy previously-created infrastructure
```

## Available variables for terraform.tfvars

| Variable | Type | Default value | Description |
|----------|------|---------------|-------------|
| `hcloud_token` | string | "" | Defines the authentication token with which new machines are registered with the [hetzner cloud](https://www.hetzner.com/cloud) project - security - api-token |
| `ssh_private_key` | string | "~/.ssh/id_rsa" | Path to a private key on the host where you call terraform. Will be saved in the cloud and on the machines provisioned. |
| `ssh_public_key` | string | "~/.ssh/id_rsa.pub" | Like `ssh_private_key`, but the public part of the key. |
| `ssh_key_name` | string | `admin_ssh_key` | Choose an arbitrary unique name for the ssh key added to the hetzner cloud (the key found with ssh_private_key and ssh_public_key). |
| `hetzner_machine_type` | string | "cx11" | https://www.hetzner.com/cloud - prices. minimal: cx11, running easydb5: cx41 |
| `hetzner_machine_os` | string | "debian-10" | Defines the machine operating system to be installed. |
| `hetzner_additional_public_key_ids` | []string | [] | Adds public keys to the server that are already registered with hetzner in the project of the hcloud_token |
| `hetzner_machine_additional_packages` | string | "" | Defines additional packages that must be installed on the machine. Each package name must be separated by a space ` `. |

## Syntax

terraform: https://www.terraform.io/docs/language/syntax/configuration.html

hetzner: https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server
