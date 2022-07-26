data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  version_prefix  = var.kubernetes_version_prefix
  include_preview = var.kubernetes_include_preview
}
