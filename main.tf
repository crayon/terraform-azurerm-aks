terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = ">=2.69.0"
    }
    azuread = {
      version = ">=1.6.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = ">=2.3.2"
    }
  }
}
