
output "vm_ids" {
  value = "${azurerm_virtual_machine.myVM.*.id}"
}