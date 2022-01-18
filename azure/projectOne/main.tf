provider "azurerm" {
  features {}
}

# Create a resource group
module "resourceGroup" {
  source  = "./modules/resourceGroup/"
  name    = "resourceGroup"
}

module "vNetwork" {
  source  = "./modules/vNetwork/"
  name    = "vNetwork"
  resource_group_name = "resourceGroup"
  depends_on = [module.resourceGroup]
}

# module "linuxVM" {
#   source  = "./modules/linuxVM/"
#   vm_name    = "linuxVM"
#   resource_group_name = "resourceGroup"
#   virtual_network_name = "vNetwork"
#   depends_on = [module.vNetwork]
# }

# module "cosmosDB" {
#   source  = "./modules/cosmosDB/"
#   resource_group_name = "resourceGroup"
#   depends_on = [module.linuxVM]
# }