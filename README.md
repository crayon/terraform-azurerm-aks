# Terraform module for Azure Kubernetes Service
A flexible module for deploying AKS clusters. The main purpose for this module, besides being the basis for doing talks about Terraform, is to enable users to deploy clusters that adhere to industry standards but that is flexible enough so that anyone can use it for whatever type of deployment.

[![test](https://github.com/crayon/terraform-azurerm-aks/workflows/test/badge.svg?branch=main)](https://github.com/crayon/terraform-azurerm-aks/actions?query=workflow%3Atest)

## Requirements

Current Terraform minimum version required is `1.0.3`.

If not pinned by you, the provider downloaded will be the newest version available above the minimum version. It's considered good practice to pin your versions to make sure that you get consistent results.

| Provider | Minimum version | Note
| -------- | --------------- | ---- |
| azurerm | 2.69.0 | Still requires the features field. Read the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage) if in doubt. |
| azuread | 1.6.0 | |
| kubernetes | 2.3.2 | See the [Kubernetes provider](#kubernetes-provider) section. |

### admin_groups needed
By default the module deploys the cluster as managed, with RBAC. This means that you will have to define what group(s) that will have administrator access to the cluster. This is done through the input variable `admin_groups`, which expects a list of object IDs. You could copy the IDs from the portal and set it explicit, but I like using the data source `azuread_groups` as it returns object IDs of one or more group based on names.

Example using `azuread_groups` can be found [here](https://github.com/crayon/terraform-azurerm-aks/examples/defaults), pseudo code below.

```hcl
data "azuread_groups" "admins" {
  names = ["group01", "group02"]
}

module "kubernetes" {
  source  = "crayon/aks/azurerm"
  version = "1.0.0"

  admin_groups = data.azuread_groups.admins.object_ids
}
```

### Kubernetes provider

A static version can be set, as long as it's above the minimum version specified above. If you want to create namespaces, or roles, you need to define how the provider can connect to the cluster by adding the following provider block.

```hcl
provider "kubernetes" {
  host = module.kubernetes.host

  client_certificate     = base64decode(module.kubernetes.client_certificate)
  client_key             = base64decode(module.kubernetes.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
}
```