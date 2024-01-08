
data "template_file" "ansible_inventory" {
  template = <<EOF
[all]
master ansible_host=${var.control_static_private_ip} ansible_ssh_private_key_file="~/.ssh/control_private_key.pem"
worker1 ansible_host=${var.worker1_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker1_private_key.pem"
worker2 ansible_host=${var.worker2_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker2_private_key.pem"


[master]
master
[workers]
worker1 
worker2 


[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_user=${var.admin_username}
EOF
}


# Output the Ansible inventory content to a file
resource "local_file" "ansible_inventory_file" {
  depends_on = [data.template_file.ansible_inventory]
  filename   = "/tmp/ansible/inventory.txt"
  content    = data.template_file.ansible_inventory.rendered
}


# resource "null_resource" "transfer_ansible" {

#  provisioner "remote-exec" {
#    inline = ["mkdir -p /tmp/ansible/"]
#   }

#   provisioner "remote-exec" {
#    inline = [
#      "sudo apt-get update",
#      "sudo apt-get install -y software-properties-common",
#      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
#      "sudo apt-get install -y ansible"
#    ]
#   }

#   provisioner "file" {
#    source      = "~/IaC/rewrite/ansible/kube-dependencies.yml"
#    destination = "/tmp/ansible/kube-dependencies.yml"
#   }

#   provisioner "file" {
#    source      = "~/IaC/rewrite/ansible/master.yml"
#    destination = "/tmp/ansible/master.yml"
#   }
#   provisioner "file" {
#    source      = "~/IaC/rewrite/ansible/workers.yml"
#    destination = "/tmp/ansible/workers.yml"
#   }

#   provisioner "file" {
#    source      = "/tmp/ansible/inventory.txt"
#    destination = "/tmp/ansible/inventory.txt"
#   }

#   connection {
#   type       = "ssh"
#   user       = "hackmaze-user"
#   private_key = var.jump_private_key_content // replace with the correct path to your private key
#   host       = var.jump_public_ip // replace with the public IP of your jump server
#  }

# }
