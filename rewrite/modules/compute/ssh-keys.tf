
resource "tls_private_key" "jump_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}



resource "local_file" "jump_public_key" {
  filename = "~/.ssh/jump_public_key.pub"
  content  = tls_private_key.jump_server_ssh_key.public_key_openssh
}

resource "local_file" "jump_private_key" {
  filename = "~/.ssh/jump_private_key"
  content  = tls_private_key.jump_server_ssh_key.private_key_pem
}









resource "tls_private_key" "control_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}


resource "local_file" "control_public_key" {
  filename = "~/.ssh/control_public_key.pub"
  content  = tls_private_key.jump_server_ssh_key.public_key_openssh
}

resource "local_file" "control_private_key" {
  filename = "~/.ssh/control_private_key"
  content  = tls_private_key.control_server_ssh_key.private_key_pem
}








resource "tls_private_key" "worker1_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}



resource "local_file" "worker1_public_key" {
  filename = "~/.ssh/worker1_public_key.pub"
  content  = tls_private_key.worker1_server_ssh_key.public_key_openssh
}

resource "local_file" "worker1_private_key" {
  filename = "~/.ssh/worker1_private_key"
  content  = tls_private_key.worker1_server_ssh_key.private_key_pem
}



resource "tls_private_key" "worker2_server_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  # You can adjust the key size as needed
}


resource "local_file" "worker2_public_key" {
  filename = "~/.ssh/worker2_public_key.pub"
  content  = tls_private_key.worker2_server_ssh_key.public_key_openssh
}

resource "local_file" "worker2_private_key" {
  filename = "~/.ssh/worker2_private_key"
  content  = tls_private_key.worker2_server_ssh_key.private_key_pem
}