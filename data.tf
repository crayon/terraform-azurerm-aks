data "azurerm_kubernetes_service_versions" "current" {
  location        = data.azurerm_resource_group.aks.location
  version_prefix  = var.kubernetes_version_prefix
  include_preview = var.kubernetes_include_preview
}
