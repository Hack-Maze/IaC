
resource "tls_private_key" "jump_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}



resource "local_file" "jump_public_key" {
  filename = "/tmp/.ssh/jump_public_key.pub"
  content  = tls_private_key.jump_server_ssh_key.public_key_openssh
}

resource "local_file" "jump_private_key" {
  filename = "/tmp/.ssh/jump_private_key.pem"
  content  = tls_private_key.jump_server_ssh_key.private_key_pem
}









resource "tls_private_key" "control_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}


resource "local_file" "control_public_key" {
  filename = "/tmp/.ssh/control_public_key.pub"
  content  = tls_private_key.jump_server_ssh_key.public_key_openssh
}

resource "local_file" "control_private_key" {
  filename = "/tmp/.ssh/control_private_key.pem"
  content  = tls_private_key.control_server_ssh_key.private_key_pem
}








resource "tls_private_key" "worker1_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}



resource "local_file" "worker1_public_key" {
  filename = "/tmp/.ssh/worker1_public_key.pub"
  content  = tls_private_key.worker1_server_ssh_key.public_key_openssh
}

resource "local_file" "worker1_private_key" {
  filename = "/tmp/.ssh/worker1_private_key.pem"
  content  = tls_private_key.worker1_server_ssh_key.private_key_pem
}



resource "tls_private_key" "worker2_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}


resource "local_file" "worker2_public_key" {
  filename = "/tmp/.ssh/worker2_public_key.pub"
  content  = tls_private_key.worker2_server_ssh_key.public_key_openssh
}

resource "local_file" "worker2_private_key" {
  filename = "/tmp/.ssh/worker2_private_key.pem"
  content  = tls_private_key.worker2_server_ssh_key.private_key_pem
}






  resource "null_resource" "transfer_pem" {
  depends_on = [azurerm_network_interface.jump_server_nic-01,
                azurerm_linux_virtual_machine.jump_server,
                local_file.jump_private_key,
                local_file.control_private_key,
                local_file.worker1_private_key,
                local_file.worker2_private_key]




  provisioner "file" {
    source      = "/tmp/.ssh/control_private_key.pem"
    destination = "/home/hackmaze-user/.ssh/control_private_key.pem"
    }

  provisioner "file" {
    source      = "/tmp/.ssh/worker1_private_key.pem"
    destination = "/home/hackmaze-user/.ssh/worker1_private_key.pem"
    }

  provisioner "file" {
    source      = "/tmp/.ssh/worker2_private_key.pem"
    destination = "/home/hackmaze-user/.ssh/worker2_private_key.pem"
    }


    

  provisioner "remote-exec" {
    inline = ["chmod 600 /home/hackmaze-user/.ssh/*.pem"]
  }

  connection {
    type        = "ssh"
    user        = "hackmaze-user"
    private_key = local_file.jump_private_key.content // replace with the correct path to your private key
    host        = var.jump_public_ip // replace with the public IP of your jump server
    timeout    = "20m"

  }

  }


