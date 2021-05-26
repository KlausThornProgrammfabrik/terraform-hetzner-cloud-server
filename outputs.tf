output "print_machine_names_master" {
  value = hcloud_server.test_machine.*.name
}

output "print_machine_ipv4_master" {
  value = hcloud_server.test_machine.*.ipv4_address
}
