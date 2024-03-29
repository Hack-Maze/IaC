
data "template_file" "ansible_inventory" {
  template = <<EOF
[all]
control ansible_host=${var.control_static_private_ip} ansible_ssh_private_key_file="~/.ssh/control_private_key.pem"
worker1 ansible_host=${var.worker1_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker1_private_key.pem"
worker2 ansible_host=${var.worker2_static_private_ip} ansible_ssh_private_key_file="~/.ssh/worker2_private_key.pem"


[master]
control
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
  filename   = "/tmp/inventory.txt"
  content    = data.template_file.ansible_inventory.rendered
}


resource "null_resource" "setup_ansible" {

 provisioner "remote-exec" {
   inline = ["git clone https://github.com/Hack-Maze/ansible.git /home/hackmaze-user/ansible"]
  }

  provisioner "file" {
   source      = "/tmp/inventory.txt"
   destination = "/home/hackmaze-user/ansible/inventory.txt"
  }

  provisioner "remote-exec" {
   inline = [
    "sudo apt-get update -qq > /dev/null",
    "sudo apt-get install -y software-properties-common -qq > /dev/null",
    "sudo apt-add-repository --yes --update ppa:ansible/ansible  > /dev/null",
    "sudo apt-get install -y ansible -qq > /dev/null"
   ]
  }

  connection {
  type       = "ssh"
  user       = "hackmaze-user"
  private_key = var.jump_private_key_content // replace with the correct path to your private key
  host       = var.jump_public_ip // replace with the public IP of your jump server
 }

}



resource "null_resource" "create_group_vars_master" {
  depends_on = [null_resource.setup_ansible]

  triggers = {
      mostafawid: var.mostafawid
      mostafawtoken: var.mostafawtoken
      mrymwid: var.mrymwid
      mrymwtoken: var.mrymwtoken
      yusufwid: var.yusufwid
      yusufwtoken: var.yusufwtoken
      moaliwid: var.moaliwid
      moaliwtoken: var.moaliwtoken
      jubawid: var.jubawid
      jubawtoken: var.jubawtoken
      nourwid: var.nourwid
      nourwtoken: var.nourwtoken
    }

    provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/hackmaze-user/ansible/group_vars",
      " echo '${templatefile("${path.module}/master.yml.tpl", {
      mostafawid=var.mostafawid
      mostafawtoken=var.mostafawtoken
      mrymwid=var.mrymwid,
      mrymwtoken=var.mrymwtoken,
      yusufwid=var.yusufwid,
      yusufwtoken=var.yusufwtoken,
      moaliwid=var.moaliwid,
      moaliwtoken=var.moaliwtoken,
      jubawid=var.jubawid,
      jubawtoken=var.jubawtoken,
      nourwid=var.nourwid,
      nourwtoken=var.nourwtoken
      
      })}' > /home/hackmaze-user/ansible/group_vars/master.yml"
    ]
  }

  connection {
    type        = "ssh"
    user        = "hackmaze-user"
    private_key = var.jump_private_key_content // Ensure this is correctly set
    host        = var.jump_public_ip // Ensure this is correctly set
  }
}




resource "null_resource" "setup_cluster" {
  depends_on = [null_resource.create_group_vars_master]

  provisioner "remote-exec" {
    inline = [
        "ansible-playbook -i ~/ansible/inventory.txt  ~/ansible/playbooks/main.yml"
      ]
  }

  connection {
    type        = "ssh"
    user        = "hackmaze-user"
    private_key = var.jump_private_key_content // Ensure this is correctly set
    host        = var.jump_public_ip // Ensure this is correctly set
  }
}
