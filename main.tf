terraform {
  backend "azurerm" {
    #resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "hasstorage123"
    container_name       = "tfterraform"
    key                  = "terraform.tfstate"
    access_key = "RPX9N5yeWDYeEZBqfC7W4zQMXrhO1c9p4Owf6/0dlxQw+n52E4PvnhgHUUSvY8JSKLOBaJTBWGC++AStbNSNTw=="          
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}



