resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name = "resourceGroup"
  virtual_network_name = "${var.virtual_network_name}"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "myNIC"
  location            = "West US"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "myConfiguration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "myVM" {
  location              = "West US"
  name                  = "${var.vm_name}"
  vm_size               = "Standard_DS1_v2"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = [azurerm_network_interface.main.id]

  storage_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "16.04-LTS"
    version   = "latest"
  }

    storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}