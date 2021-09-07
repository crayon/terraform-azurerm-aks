# Changelog

## v1.3.0

>Note: Release-drafter have been added from this version on, and might look a bit different than what is described in this changelog. At least, for now.

### Issues closed

* Add `dns_prefix` variable (#10)

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
