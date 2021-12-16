terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "2.88.1"
    }
    azuread = {
      version = "2.13.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
  }
}
