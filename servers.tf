resource "hcloud_server" "test_machine" {
  count       = 1
  name        = format("%s-%s-%s-%d", "test_machine", var.hetzner_machine_os, random_uuid.hetzner_machine.result, count.index + 1)
  server_type = var.hetzner_machine_type
  image       = var.hetzner_machine_os
  ssh_keys    = concat([hcloud_ssh_key.primary_ssh_key.id], var.hetzner_additional_public_key_ids)

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

