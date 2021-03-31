# Changelog
## v1.3.0

- Add sku_tier (#3)
- Default node pool - only_critical_addons_enabled (#4)
- Add Linux/Windows profile (#5)
## v1.2.1

- Set azuread to require version >= 1.3.0 and updated examples due to deprecated naming convention.
- Added node_taints for additional node pools. To not use node_taints, please set to _null_ or an empty list
- Updated the pod_cidr with a network mask that doesn't break using kubenet