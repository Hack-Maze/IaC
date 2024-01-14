data "template_file" "jump_hosts" {
  template = <<EOF

127.0.0.1 localhost
#contol vm
${var.control_static_private_ip} control
#workers vm
${var.worker1_static_private_ip} worker1
${var.worker2_static_private_ip} worker2

EOF
}

# Output the jump_hosts content to a file
resource "local_file" "jump_hosts_file" {
  depends_on = [data.template_file.jump_hosts]
  filename   = "/tmp/jump_hosts"
  content    = data.template_file.jump_hosts.rendered
}


resource "null_resource" "transfer_hosts_file" {


 provisioner "remote-exec" {
    inline = ["sudo rm /etc/hosts "]
  }


provisioner "file" {
 source      = "/tmp/jump_hosts"
 destination = "/tmp/jump_hosts"
}

provisioner "remote-exec" {
 inline = ["sudo mv /tmp/jump_hosts /etc/hosts"]
 }
 

provisioner "remote-exec" {
 inline = ["echo \"alias worker1='ssh -i $HOME/.ssh/worker1_private_key.pem $USER@worker1'\" >> $HOME/.bashrc";
           "echo \"alias worker1='ssh -i $HOME/.ssh/worker1_private_key.pem $USER@worker1'\" >> $HOME/.bashrc";
           "echo \"alias worker1='ssh -i $HOME/.ssh/worker1_private_key.pem $USER@worker1'\" >> $HOME/.bashrc";
           "source $HOME/.bashrc";
           ]
 }
 

connection {
  type       = "ssh"
  user       = "hackmaze-user"
  private_key = local_file.jump_private_key.content // replace with the correct path to your private key
  host       = var.jump_public_ip // replace with the public IP of your jump server
}


}
