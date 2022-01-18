resource "azurerm_virtual_network" "network" {
  address_space       = ["10.0.0.0/16"]
  location            = "West US"
  name                = "${var.name}-VN"
  resource_group_name = "${var.resource_group_name}"
}