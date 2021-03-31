terraform {
  required_version = ">=0.14.4"
  required_providers {
    azurerm = {
      version = ">=2.49.0"
    }
    azuread = {
      version = ">=1.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=1.13.3"
    }
  }
}
