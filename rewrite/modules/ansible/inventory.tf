

data "template_file" "ansible_inventory" {
  template = <<EOF
[jump]
jump   ansible_host=${module.compute.jump_public_ip} ansible_ssh_private_key_file="~/.ssh/jump_private_key"

[master]
master ansible_host=${module.compute.control_static_private_ip} ansible_ssh_private_key_file="~/.ssh/control_private_key"

[workers]
worker1 ansible_host=${module.compute.worker1_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker1_private_key"
worker1 ansible_host=${module.compute.worker2_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker2_private_key"

# Include other workers as necessary...

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_user=${module.compute.admin_username}
EOF
}



# Output the Ansible inventory content to a file
resource "local_file" "ansible_inventory_file" {
  depends_on = [data.template_file.ansible_inventory]
  filename   = "~/ansible_inventory.txt"
  content    = data.template_file.ansible_inventory.rendered
}