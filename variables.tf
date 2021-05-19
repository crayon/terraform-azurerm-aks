variable "name" {
  type        = string
  description = "Name the deployment."
}
variable "resource_group" {
  type        = string
  description = "The resource group you want your deployment in."
}
variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
}
variable "subnet_id" {
  type        = string
  description = "The object ID of the subnet that you want to deploy to"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags that will be used for the deployment."
}
variable "enable_node_public_ip" {
  type        = bool
  description = "Should nodes in this Node Pool have a Public IP Address?"
  default     = false
}
variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones that the cluster will use. Defaults to 1, 2 and 3."
  default     = ["1", "2", "3"]
}
variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version the cluster should run. Defaults to the latest version available."
  default     = "not_set"
}
variable "kubernetes_version_prefix" {
  type        = string
  description = "Set a prefix for the Kubernetes version. Example: 1.17 uses the latest version of 1.17."
  default     = "1.19"
}
variable "kubernetes_include_preview" {
  type        = bool
  description = "Include versions of Kubernetes that are released as 'preview'. Defaults to false."
  default     = false
}
variable "addons" {
  description = "The addon profile for the cluster"
  type = object({
    kube_dashboard = bool
    oms_agent      = bool
    workspace_id   = string
    azure_policy   = bool
  })
  default = {
    kube_dashboard = false
    oms_agent      = false
    workspace_id   = null
    azure_policy   = true
  }
}
variable "network_plugin" {
  type        = string
  description = "Set to kubenet by default, can be either kubenet or azure."
  default     = "kubenet"
}
variable "network_policy" {
  type        = string
  description = "Sets up network policy to be used. Either Azure or Calico. Azure is only supported using Azure CNI."
  default     = "calico"
}
variable "outbound_type" {
  type        = string
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting."
  default     = "loadBalancer"
}
variable "pod_cidr" {
  type        = string
  description = "When using the kubenet network plugin, a CIDR needs to be set for pod IP addresses."
  default     = "192.168.0.0/16"
}
variable "service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service"
  default     = "10.10.0.0/16"
}
variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by kube-dns."
  default     = "10.10.0.10"
}
variable "docker_bridge_cidr" {
  type        = string
  description = "CIDR used as the Docker bridge IP address on nodes."
  default     = "172.17.0.1/16"
}
variable "role_based_access_control" {
  type        = bool
  description = "Whether or not RBAC is enabled on the cluster."
  default     = true
}
variable "azure_ad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration?"
  default     = true
}
variable "admin_groups" {
  type        = list(string)
  description = "A list of object IDs of Azure AD groups that should have the admin role in the cluster."
  default     = null
}
variable "rbac_client_app_id" {
  type        = string
  default     = null
  description = "The Client ID of an Azure Active Directory Application."
}
variable "rbac_server_app_id" {
  type        = string
  default     = null
  description = "The Server ID of an Azure Active Directory Application."
}
variable "rbac_server_app_secret" {
  type        = string
  default     = null
  description = "The Server Secret of an Azure Active Directory Application."
}
variable "service_principal" {
  type = object({
    client_id     = string
    client_secret = string
  })
  default     = null
  description = "Map used to set the service principal client ID and secret."
}
variable "linux_profile" {
  description = "The Linux profile for the cluster"
  type = object({
    admin_username = string
    ssh_key        = string
  })
  default = null
}
variable "windows_profile" {
  description = "The Windows profile for the cluster"
  type = object({
    admin_username = string
    admin_password = string
  })
  default = null
}
variable "default_node_pool" {
  description = "The default node pool, defaults to a pool with one node of the Standard_D2s_v3 VM Size."
  type = object({
    name                = string
    vm_size             = string
    node_count          = number
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    additional_settings = map(string)
  })
  default = {
    name                = "default"
    vm_size             = "Standard_D2s_v3"
    node_count          = 1
    enable_auto_scaling = false
    min_count           = null
    max_count           = null
    additional_settings = {}
  }
}
variable "additional_node_pools" {
  type = list(object({
    name                = string
    vm_size             = string
    node_count          = number
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    node_labels         = map(string)
    node_taints         = list(string)
    tags                = map(string)
    additional_settings = map(string)
  }))
  description = "A list of additional node pools that you want to deploy with the cluster."
  default     = []
}
variable "namespaces" {
  type = list(object({
    name        = string
    annotations = map(string)
    labels      = map(string)
  }))
  description = "A list of namespaces you want deployed."
  default     = []
}
