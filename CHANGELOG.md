# Changelog

## v1.4.0

- (#21) *Add the kubelet\_identity property to module outputs* by @Happycoil
- (#23) *Bump azuread from 2.2.1 to 2.3.0* by @dependabot
- (#22) *Bump azurerm from 2.76.0 to 2.77.0* by @dependabot
- (#24) *default_node_pool is missing node_labels* by @roberthstrand
- (#25) *Enable HTTP application routing* by @roberthstrand

## v1.3.0

>Note: Release-drafter have been added from this version on, and might look a bit different than what is described in this changelog. At least, for now, still exploring the best way of handling changelogs.

### Issues closed

* Add `dns_prefix` variable (#10)
* Add node_resource_group (#11)
* Pin versions of providers (#18)
* Fails plan when variable dns_prefix is not set (#16)
* Add support for AKS RBAC (#15)

### Miscellaneous

* Added Release-drafter to the repository
* New workflow, issues and PR will get automatically added to the [Terraform Modules project](https://github.com/orgs/crayon/projects/2)

## v1.2.0

New minimum version requirement for the module is now:

* Terraform 1.0.3
* azurerm 2.69.0
* azuread 1.6.0
* kubernetes 2.3.2

### Issues closed

* Implement IP restriction to Kubernetes API (#7)
* Add AGIC addon (#8)

### Miscellaneous

* Bump example code version to 1.2.0
* Added AGIC to the complex example

## v1.1.0

New minimum version requirement for the module is now:

* Terraform 0.15.3
* azurerm 2.59.0

### Issues closed

* Remove hardcoded suffix from deployment name (#1)
* `var.service_principal` should be an object (#2)
* Default node pool should not be a list (#3)
* Simplify objects with the new optional (#5)

### Miscellaneous

* New outputs: `aks_credentials` and `kube_admin_config_raw`

## v1.0.0

Moved from private repository, to @crayon
