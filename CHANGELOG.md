# Changelog

## v1.1.0
New minimum version requirement for the module is now:
* Terraform 0.15.3
* azurerm 2.59.0

### Issues closed
- Remove hardcoded suffix from deployment name (#1)
- `var.service_principal` should be an object (#2)
- Default node pool should not be a list (#3)
- Simplify objects with the new optional (#5)

### Miscellaneous
- New outputs: `aks_credentials` and `kube_admin_config_raw`

## v1.0.0
Moved from private repository, to @crayon