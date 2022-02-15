terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "2.95.0"
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
