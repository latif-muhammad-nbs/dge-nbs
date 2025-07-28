output "subnet_ids" {
  value = { for s in azurerm_subnet.main : s.name => s.id }
  description = "Map of subnet names to their IDs."
}