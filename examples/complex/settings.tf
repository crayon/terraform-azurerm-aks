terraform {
  required_providers {
    azurerm = {
      version = "=2.49.0"
    }
    azuread = {
      version = "=1.3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host = module.kubernetes.host

  client_certificate     = base64decode(module.kubernetes.client_certificate)
  client_key             = base64decode(module.kubernetes.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
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
  display_names = ["aks-admin"]
}
