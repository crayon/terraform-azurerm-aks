terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "3.13.0"
    }
    azuread = {
      version = "2.19.1"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
  }
}
