terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
}

provider "azurerm" {
  features {}
}



module "rc-group" {
  source = "./modules/rc-group"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}


module "compute" {
  source = "./modules/compute"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}

module "network" {
  source = "./modules/network"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}

module "security" {
  source = "./modules/security"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}


module "ansible" {
  source = "./modules/ansible"  # Path to the compute module directory

  # Pass any required variables to the compute module
  # For example:
  # variable_name = value
}


