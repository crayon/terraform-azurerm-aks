terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "3.0.2"
    }
    azuread = {
      version = "2.18.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
  }
}
