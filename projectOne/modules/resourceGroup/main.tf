resource "azurerm_resource_group" "res_group" {
  name     = "${var.name}"
  location = "West US"
}