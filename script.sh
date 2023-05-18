az group create --name terraformremotebackend --location westeurope

az storage account create -n hasstorage123 -g terraformremotebackend -l westeurope --sku Standard_LRS

az storage container create -n hasstorage123

az storage container create --name tfterraform --account-name hasstorage123 --account-key <storage_account_key>