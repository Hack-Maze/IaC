

data "template_file" "ansible_inventory" {
  template = <<EOF
[jump]
jump   ansible_host=${module.compute.jump_static_private_ip}

[master]
master ansible_host=${module.compute.control_static_private_ip}

[workers]
worker1 ansible_host=${module.compute.worker1_static_private_ip}
worker1 ansible_host=${module.compute.worker2_static_private_ip}

# Include other workers as necessary...

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_ssh_private_key_file=/path/to/ssh-key
ansible_user=${module.compute.admin_username}
EOF
}

# Output the Ansible inventory content to a file
resource "local_file" "ansible_inventory_file" {
  depends_on = [data.template_file.ansible_inventory]
  filename   = "ansible_inventory.txt"
  content    = data.template_file.ansible_inventory.rendered
}