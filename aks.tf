resource "azurerm_kubernetes_cluster" "cluster" {
  # General configurations:
  # Location is set to the variable if specified,
  # otherwise it is set to the location of the resource group.
  name                = format("%s-aks", var.name)
  location            = data.azurerm_resource_group.aks.location
  resource_group_name = var.resource_group
  sku_tier            = var.sku_tier
  dns_prefix          = var.name
  tags                = var.tags

  # If no Kubernetes version is set, it uses the latest non-preview version.
  # Can be set to use the latest preview version, and one can define a prefix to make
  # the versions kept at a certain major version.
  kubernetes_version = var.kubernetes_version == "not_set" ? data.azurerm_kubernetes_service_versions.current.latest_version : var.kubernetes_version

  addon_profile {
    kube_dashboard {
      enabled = var.addons.kube_dashboard
    }

    azure_policy {
      enabled = var.addons.azure_policy
    }

    oms_agent {
      enabled                    = var.addons.oms_agent
      log_analytics_workspace_id = var.addons.oms_agent ? var.addons.workspace_id : null
    }
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    outbound_type      = var.outbound_type
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    pod_cidr           = var.network_plugin == "kubenet" ? var.pod_cidr : null
  }

  role_based_access_control {
    enabled = var.role_based_access_control
    azure_active_directory {
      managed                = var.azure_ad_managed
      admin_group_object_ids = var.azure_ad_managed ? var.admin_groups : null

      # If managed is set to false, then the following properties needs to be set
      client_app_id     = var.azure_ad_managed == false ? var.rbac_client_app_id : null
      server_app_id     = var.azure_ad_managed == false ? var.rbac_server_app_id : null
      server_app_secret = var.azure_ad_managed == false ? var.rbac_server_app_secret : null
    }
  }

  default_node_pool {
    name                  = var.default_node_pool[0].name
    vnet_subnet_id        = var.subnet_id
    enable_node_public_ip = var.enable_node_public_ip
    vm_size               = var.default_node_pool[0].vm_size
    node_count            = var.default_node_pool[0].node_count

    enable_auto_scaling = var.default_node_pool[0].enable_auto_scaling
    min_count           = var.default_node_pool[0].min_count
    max_count           = var.default_node_pool[0].max_count
    availability_zones  = var.availability_zones

    # Various additional settings
    only_critical_addons_enabled = lookup(var.default_node_pool[0].additional_settings, "only_critical_addons_enabled", null)
    max_pods                     = lookup(var.default_node_pool[0].additional_settings, "max_pods", null)
    os_disk_size_gb              = lookup(var.default_node_pool[0].additional_settings, "os_disk_size_gb", null)
    os_disk_type                 = lookup(var.default_node_pool[0].additional_settings, "os_disk_type", null)
    type                         = lookup(var.default_node_pool[0].additional_settings, "type", "VirtualMachineScaleSets")
  }

  # One of either identity or service_principal blocks must be specified.
  # We can control which by using dynamic blocks.
  ## If a Service Principal is not present
  dynamic "identity" {
    for_each = var.service_principal == null ? ["SystemAssigned"] : []
    content {
      type = "SystemAssigned"
    }
  }
  ## If a Service Principal is present
  dynamic "service_principal" {
    for_each = var.service_principal != null ? ["ServicePrincipal"] : []
    content {
      client_id     = lookup(var.service_principal, "client_id", null)
      client_secret = lookup(var.service_principal, "client_secret", null)
    }
  }

  # If either Linux or Windows profile is present:
  dynamic "linux_profile" {
    for_each = var.linux_profile != null ? ["LinuxProfile"] : []
    content {
      admin_username = var.linux_profile.admin_username
      ssh_key {
        key_data = var.linux_profile.ssh_key
      }
    }
  }
  dynamic "windows_profile" {
    for_each = var.windows_profile != null ? ["WinProfile"] : []
    content {
      admin_username = var.windows_profile.admin_username
      admin_password = var.windows_profile.admin_password
    }
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "additional_cluster" {
  for_each = { for np in var.additional_node_pools : np.name => np }

  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  name                  = each.value.name
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id        = var.subnet_id
  availability_zones    = var.availability_zones

  enable_auto_scaling = each.value.enable_auto_scaling
  min_count           = each.value.min_count
  max_count           = each.value.max_count

  node_labels = each.value.node_labels
  node_taints = each.value.node_taints != null ? each.value.node_taints : [""]
  tags        = each.value.tags

  # Various additional settings
  enable_node_public_ip = lookup(each.value.additional_settings, "enable_node_public_ip", false)
  max_pods              = lookup(each.value.additional_settings, "max_pods", null)
  mode                  = lookup(each.value.additional_settings, "mode", null)
  os_type               = lookup(each.value.additional_settings, "os_type", "Linux")
  os_disk_size_gb       = lookup(each.value.additional_settings, "os_disk_size_gb", null)
  os_disk_type          = lookup(each.value.additional_settings, "os_disk_type", null)
}
