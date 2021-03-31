output "host" {
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].host
  description = "The Kubernetes cluster server host."
}
output "client_certificate" {
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_certificate
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
}
output "client_key" {
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_key
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
}
output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config[0].cluster_ca_certificate
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
}
