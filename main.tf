terraform {
  # Configure the remote backend for Terraform Cloud
  backend "remote" {
    # Replace these values with your actual details
    organization = "MostafaEwida"
    workspaces {
      name = "hackmaze-iac"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.87.0"
    }
  }
}

provider "azurerm" {
  features {}
}


locals {

  #rc vars
  rc-name     = module.rc-group.name
  rc-location = module.rc-group.location
  rc-tags     = module.rc-group.tags


  #compute vars
  jump_static_private_ip    = module.compute.jump_static_private_ip
  control_static_private_ip = module.compute.control_static_private_ip
  worker1_static_private_ip = module.compute.worker1_static_private_ip
  worker2_static_private_ip = module.compute.worker2_static_private_ip
  admin_username            = module.compute.admin_username
  jump_nic_id               = module.compute.jump_nic_id
  control_nic_id            = module.compute.control_nic_id
  worker1_nic_id            = module.compute.worker1_nic_id
  worker2_nic_id            = module.compute.worker2_nic_id
  jump_private_key_content  = module.compute.jump_private_key_content

  #network vars 
  subnet_id                       = module.network.subnet_id
  jump_public_ip                  = module.network.jump_public_ip
  jump_public_ip_id               = module.network.jump_public_ip_id
  hackmaze_vnet_address_range     = module.network.hackmaze_vnet_address_range
  hackmaze_subnet_01_address_rang = module.network.hackmaze_subnet_01_address_rang

  #security vars

  jump_sg_id    = module.security.jump_sg_id
  control_sg_id = module.security.control_sg_id
  worker_sg_id  = module.security.worker_sg_id



}


module "rc-group" {
  source = "./modules/rc-group"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}


module "network" {
  source = "./modules/network"  # Path to the compute module directory
  depends_on = [module.rc-group]
  # For example:
  # variable_name = value

  rc-name     = local.rc-name
  rc-location = local.rc-location
  rc-tags     = local.rc-tags


  control_static_private_ip = local.control_static_private_ip
  worker1_static_private_ip = local.worker1_static_private_ip
  worker2_static_private_ip = local.worker2_static_private_ip
}

module "compute" {
  source = "./modules/compute"  # Path to the compute module directory
  depends_on = [ module.rc-group]

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
  rc-name           = local.rc-name
  rc-location       = local.rc-location
  rc-tags           = local.rc-tags
  subnet_id         = local.subnet_id
  jump_public_ip    = local.jump_public_ip
  jump_public_ip_id = local.jump_public_ip_id

  jump_sg_id        = local.jump_sg_id
  control_sg_id     = local.control_sg_id
  worker_sg_id      = local.worker_sg_id
  hackmaze-user-discord-url = var.hackmaze-user-discord-url

}



module "security" {
  source = "./modules/security"  # Path to the compute module directory
  depends_on = [module.rc-group]

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
  rc-name                       = local.rc-name
  rc-location                   = local.rc-location
  rc-tags                       = local.rc-tags
  hackmaze_vnet_address_range   = local.hackmaze_vnet_address_range
  subnet_id                     = local.subnet_id
  control_nic_id                = local.control_nic_id
  jump_nic_id                   = local.jump_nic_id
  jump_static_private_ip        = local.jump_static_private_ip
  worker1_nic_id                = local.worker1_nic_id
  worker2_nic_id                = local.worker2_nic_id
}


module "ansible" {
  source = "./modules/ansible"  # Path to the compute module directory
  depends_on = [module.compute,module.network, module.security ]
  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
  rc-name     = local.rc-name
  rc-location = local.rc-location
  rc-tags     = local.rc-tags


  jump_public_ip            = local.jump_public_ip
  control_static_private_ip = local.control_static_private_ip
  worker1_static_private_ip = local.worker1_static_private_ip
  worker2_static_private_ip = local.worker2_static_private_ip
  admin_username            = local.admin_username
  jump_private_key_content  = local.jump_private_key_content


  mostafawtoken             = var.mostafawtoken
  mostafawid                = var.mostafawid
  mrymwtoken                = var.mrymwtoken
  mrymwid                   = var.mrymwid
  yusufwtoken               = var.yusufwtoken
  yusufwid                  = var.yusufwid
  moaliwtoken               = var.moaliwtoken
  moaliwid                  = var.moaliwid
  jubawtoken                = var.jubawtoken
  jubawid                   = var.jubawid
  nourwtoken                = var.nourwtoken
  nourwid                   = var.nourwid
}


