terraform {
  required_version = ">=1.0.3"
  required_providers {
    azurerm = {
      version = "2.90.0"
    }
    azuread = {
      version = "2.14.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
  }
}
