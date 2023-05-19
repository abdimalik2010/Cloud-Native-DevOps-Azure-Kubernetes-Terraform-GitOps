
# Create resource group for Terraform remote backend storage
az group create --name terraformremotebackend --location westeurope

# Create storage for Terraform remote backend
az storage account create -n hasstorage123 -g terraformremotebackend -l westeurope --sku Standard_LRS

# Create container for remote backend
az storage container create --name tfterraform --account-name hasstorage123 

