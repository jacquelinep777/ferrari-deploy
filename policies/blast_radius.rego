package terraform.blast_radius

import rego.v1

default blast_radius := 100

weights := {
  "azurerm_resource_group": {"delete": 100, "create": 1, "modify": 10},
  "azurerm_virtual_network": {"delete": 100, "create": 1, "modify": 50},
  "azurerm_subnet": {"delete": 100, "create": 1, "modify": 50},
  "azurerm_network_security_group": {"delete": 50, "create": 1, "modify": 10},
  "azurerm_network_security_rule": {"delete": 10, "create": 1, "modify": 10},
  "azurerm_subnet_network_security_group_association": {"delete": 10, "create": 1, "modify": 10},
  "azurerm_virtual_network_peering": {"delete": 20, "create": 1, "modify": 10},
  "azurerm_public_ip": {"delete": 20, "create": 1, "modify": 10},
  "azurerm_bastion_host": {"delete": 100, "create": 1, "modify": 50},
  "azurerm_network_interface": {"delete": 20, "create": 1, "modify": 10},
  "azurerm_linux_virtual_machine": {"delete": 100, "create": 1, "modify": 50},
  "azurerm_windows_virtual_machine": {"delete": 100, "create": 1, "modify": 50},
  "azurerm_role_assignment": {"delete": 10, "create": 1, "modify": 10},
  "azurerm_pim_eligible_role_assignment": {"delete": 10, "create": 1, "modify": 10},
  "azurerm_monitor_diagnostic_setting": {"delete": 10, "create": 1, "modify": 10},
  "terraform_data": {"delete": 0, "create": 0, "modify": 0},
  "time_sleep": {"delete": 0, "create": 0, "modify": 0},
}

stateful_resource_types := {
  "azurerm_linux_virtual_machine",
  "azurerm_windows_virtual_machine",
}

resource_types := object.keys(weights)

resources[resource_type] := all if {
  resource_type := resource_types[_]
  all := [resource | resource := input.resource_changes[_]; resource.type == resource_type]
}

num_creates[resource_type] := num if {
  resource_type := resource_types[_]
  num := count([resource | resource := resources[resource_type][_]; "create" in resource.change.actions])
}

num_deletes[resource_type] := num if {
  resource_type := resource_types[_]
  num := count([resource | resource := resources[resource_type][_]; "delete" in resource.change.actions])
}

num_modifies[resource_type] := num if {
  resource_type := resource_types[_]
  num := count([resource | resource := resources[resource_type][_]; "update" in resource.change.actions])
}

score := value if {
  parts := [part |
    resource_type := resource_types[_]
    crud := weights[resource_type]
    part := crud.delete * num_deletes[resource_type] + crud.create * num_creates[resource_type] + crud.modify * num_modifies[resource_type]
  ]
  value := sum(parts)
}

excluded_resource_types := types if {
  types := {resource.type |
    resource := input.resource_changes[_]
    not weights[resource.type]
  }
}

stateful_deletes := deletes if {
  deletes := [resource.address |
    resource := input.resource_changes[_]
    stateful_resource_types[resource.type]
    "delete" in resource.change.actions
    resource.change.before != null
  ]
}

deny contains msg if {
  count(excluded_resource_types) > 0
  msg := sprintf("Blast radius policy has no weight for resource type(s): %s", [concat(", ", sort(excluded_resource_types))])
}

deny contains msg if {
  count(stateful_deletes) > 0
  msg := sprintf("Plan deletes stateful resource(s): %s", [concat(", ", stateful_deletes)])
}

deny contains msg if {
  score >= blast_radius
  msg := sprintf("Blast radius score %d exceeds threshold %d", [score, blast_radius])
}

warn contains msg if {
  deletes := [resource.address |
    resource := input.resource_changes[_]
    "delete" in resource.change.actions
  ]
  count(deletes) > 0
  msg := sprintf("Plan includes delete action(s): %s", [concat(", ", deletes)])
}
