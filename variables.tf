# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
    description = "Hetzner Cloud API token"
    type = string
}

variable "ssh_private_key" {
    description = "Defines the path to the location of the private key. The private key is used together with the public key to connect to the machine."
    default     = "~/.ssh/id_rsa"
    type = string
}

variable "ssh_public_key" {
    description = "Public Key to authorized the access to the machines"
    default     = "~/.ssh/id_rsa.pub"
    type = string
}

variable "ssh_username" {
    description = "Username that should be used to connect to the nodes"
    default = "root"
    type = string
}

variable "ssh_key_name" {
    description = "Defines the name for the ssh key"
    default = "my_key"
    type = string
}

resource "hcloud_ssh_key" "primary_ssh_key" {
    name       = var.ssh_key_name
    public_key = file(var.ssh_public_key)
}

variable "hetzner_machine_type" {
    description = "Sets the machine type to use."
    default = "cx11"
    type = string
}

variable "hetzner_machine_os" {
    description = "Defines the machine operating system to be installed."
    default = "debian-10"
    type = string
}

variable hetzner_additional_public_key_ids {
    description = "Adds public keys to the server that are already registered at hetzner"
    default = []
    type = list(string)
}

variable hetzner_machine_additional_packages {
    description = "Defines additional packages that must be installed on the machine. Each package name must be separated by a space ` `."
    default = ""
    type = string
}

