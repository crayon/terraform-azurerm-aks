variable "name" {
  type        = string
  description = "Name the deployment."
}

variable "resource_group" {
  type        = string
  description = "The resource group you want your deployment in."
}

variable "location" {
  type        = string
  description = "The location you want your resources deployed to."
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
  default     = null
}
variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = "Free"
}
variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  default     = null
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
variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "List of IP ranges that can access the Kubernetes API. Defaults is open from every source."
  default     = null
}
variable "zones" {
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
  default     = "1.20"
}
variable "kubernetes_include_preview" {
  type        = bool
  description = "Include versions of Kubernetes that are released as 'preview'. Defaults to false."
  default     = false
}
variable "azure_policy_enabled" {
  description = "(Optional) Enable if you want the cluster to work with Azure Policy."
  type        = bool
  default     = false
}
variable "oms_agent_log_analytics_workspace_id" {
  description = "Set the log analytics workspace ID you want to send your OMS Agent data to."
  type        = string
  default     = null
}
variable "key_vault_secrets_provider" {
  description = "Enable the Key Vault CSI driver."
  type = object({
    secret_rotation_enabled  = bool
    secret_rotation_interval = string
  })
  default = ({
    secret_rotation_enabled  = false
    secret_rotation_interval = null
  })
}
variable "open_service_mesh_enabled" {
  description = "(Optional) Enables the Open Service Mesh addon."
  type        = bool
  default     = false
}
variable "ingress_application_gateway_id" {
  description = "For adding AGIC to the cluster. Adding this block enables the Ingress controller, make sure you don't only have node pools with 'only_critical_addons_enabled' as AGIC will fail to deploy. For now, we only support defining existing Application Gateways."
  type        = string
  default     = null
}
variable "http_application_routing_enabled" {
  description = "(Optional) Enable HTTP application routing."
  type        = bool
  default     = false
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
variable "role_based_access_control_enabled" {
  type        = bool
  description = "Whether or not RBAC is enabled on the cluster."
  default     = true
}
variable "azure_ad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration? Defaults to true."
  default     = true
}
variable "azure_rbac_enabled" {
  type        = bool
  description = "Is Role Based Access Control based on Azure AD enabled? Defaults to true."
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
  description = "Map used to set the service principal client ID and secret."
  type = object({
    client_id     = string
    client_secret = string
  })
  default = null
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
    node_labels         = map(string)
    additional_settings = map(string)
  })
  default = {
    name                = "default"
    vm_size             = "Standard_D2s_v3"
    node_count          = 1
    enable_auto_scaling = false
    min_count           = null
    max_count           = null
    node_labels         = {}
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

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  default     = false
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
  default     = false
}

variable "identity_id" {
  type        = list(string)
  description = "(Optional) A list of identities to use with UserAssigned identity."
  default     = null
}
