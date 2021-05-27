
resource "hcloud_server" "test_machine" {
  # syntax: https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server
  # e.g. name has to be a valid hostname (no "_")

  count       = 1
  name        = format("%s-%s", var.machine_name, var.hetzner_machine_os)
  server_type = var.hetzner_machine_type
  image       = var.hetzner_machine_os
  ssh_keys    = concat([hcloud_ssh_key.local_ssh_key.id], var.hetzner_additional_public_key_ids)

  connection {
    host        = self.ipv4_address
    user        = var.ssh_username
    type        = "ssh"
    private_key = file(var.ssh_private_key)
  }
  provisioner "remote-exec" {
    inline = [
        "apt-get update -y", 
        "DEBIAN_FRONTEND=noninteractive apt-get upgrade -y", 
        "DEBIAN_FRONTEND=noninteractive apt-get install ${var.hetzner_machine_additional_packages} -y",
        ]
  }
}

