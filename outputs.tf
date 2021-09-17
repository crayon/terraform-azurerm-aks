output "host" {
  description = "The Kubernetes cluster server host."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].host
}
output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_certificate
}
output "client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_key
}
output "cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].cluster_ca_certificate
}
output "aks_credentials" {
  description = "The AZ CLI command to get credentials from your new cluster."
  value       = format("az aks get-credentials --resource-group %s --name %s", data.azurerm_resource_group.aks.name, azurerm_kubernetes_cluster.cluster.name)
}
output "kube_admin_config_raw" {
  description = "The raw kube admin config, used with kubectl and other tools."
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config_raw
}
output "kubelet_identity" {
  description = "The raw kubelet identity. Used for Azure role assignments."
  value       = azurerm_kubernetes_cluster.cluster.kubelet_identity
}