
terraform {
  backend "azurerm" {
    #resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "hasstorage123"
    container_name       = "tfterraform"
    key                  = "terraform.tfstate"
    
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "k8" {
  name     = "k8-resources"
  location = "West Europe"
}

module "public_ip" {
  source              = "./modules/IPs_module"
  resource_group_name = azurerm_resource_group.k8.name
  location            = azurerm_resource_group.k8.location
}


module "network_security_group_k8a" {
  source = "./modules/masternode-nsg"

  name                = "k8-master-nsg"
  location            = azurerm_resource_group.k8.location
  resource_group_name = azurerm_resource_group.k8.name
}

module "network_security_group_k8b" {
  source = "./modules/workernode-nsg"

  name                = "k8-worker-nsg"
  location            = azurerm_resource_group.k8.location
  resource_group_name = azurerm_resource_group.k8.name
}


resource "azurerm_subnet_network_security_group_association" "k8a" {
  subnet_id                 = module.networks.primary_subnet.id
  network_security_group_id = module.network_security_group_k8a.masternode-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "k8b" {
  subnet_id                 = module.networks.secondary_subnet.id
  network_security_group_id = module.network_security_group_k8b.workernode-nsg.id
}

module "networks" {
  source              = "./modules/networks"
  resource_group_name = azurerm_resource_group.k8.name
  location            = azurerm_resource_group.k8.location

}

module "masternode_interface" {
  source              = "./modules/network_interfaces"
  name                = "k8-master-nic"
  location            = azurerm_resource_group.k8.location
  resource_group_name = azurerm_resource_group.k8.name
  subnet_id           = module.networks.primary_subnet.id
  ip_configuration = {
    name                          = "master"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = module.public_ip.masternode-ip

  }
}

module "worker_node_interface" {
  source              = "./modules/network_interfaces"
  name                = "k8-worker-nic"
  location            = azurerm_resource_group.k8.location
  resource_group_name = azurerm_resource_group.k8.name
  subnet_id           = module.networks.secondary_subnet.id
  ip_configuration = {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = module.public_ip.workernode-ip
  }
}

# Create the control plane VM
module "control_plane" {
  source                = "./modules/virtual_machines"
  name                  = "controlplane"
  resource_group_name   = azurerm_resource_group.k8.name
  location              = azurerm_resource_group.k8.location
  size                  = "Standard_F2"
  admin_username        = "kroo"
  network_interface_ids = [module.masternode_interface.masternode_interface_id,]
  custom_data           = base64encode(data.template_file.master-node-cloud-init.rendered)
  public_key = file("./key-pair.pub")
}
data "template_file" "master-node-cloud-init" {
  template = file("./scripts/master-node-user-data.sh")
}
data "template_file" "worker-node-cloud-init" {
  template = file("./scripts/worker-node-user-data.sh")
}



# Create worker nodes VMs
module "worker_nodes" {
  source                = "./modules/virtual_machines"
  count                 = 1
  name                  = "worker-node-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.k8.name
  location              = azurerm_resource_group.k8.location
  size                  = "Standard_F2"
  admin_username        = "kroo"
  network_interface_ids = [module.worker_node_interface.masternode_interface_id,]
  custom_data           = base64encode(data.template_file.worker-node-cloud-init.rendered)
  public_key = file("./key-pair.pub")

  depends_on = [module.control_plane]
}
