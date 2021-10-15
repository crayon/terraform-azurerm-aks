terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "2.77.0"
    }
    azuread = {
      version = "2.7.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
  }
}
