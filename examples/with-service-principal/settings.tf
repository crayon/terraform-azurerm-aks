provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "cluster" {
  name     = "cluster-rg"
  location = "West Europe"
}
resource "azurerm_virtual_network" "cluster" {
  name                = "cluster-vnet"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = azurerm_resource_group.cluster.name
  virtual_network_name = azurerm_virtual_network.cluster.name
  address_prefixes     = ["10.0.0.0/24"]
}
data "azuread_groups" "admins" {
  names = ["aks-admin"]
}
variable "client_id" {
  type        = string
  description = "Client ID, service principal."
}
variable "client_secret" {
  type        = string
  description = "Client secret, service principal."
}
