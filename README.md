# ferrari-deploy

Example workload repository for the `ferrari` customer/application.

This repo demonstrates the workload layer from the Terraform module strategy:

- no resource logic
- exact stack version pins
- one state per environment per stack
- backend config owned by the workload
- environment values owned by the workload

For the customer demo this deploys the Bastion proof: one workload VNet, one
dedicated Bastion VNet, peering between them, and a hardened Linux management
VM reachable through Azure Bastion.

## Layout

```text
backend/
  dev/
    jumphost.hcl
01-jumphost/
  main.tf
  variables.tf
  outputs.tf
  environments/
    dev.tfvars
    test.tfvars
    acc.tfvars
    prod.tfvars
```

## Deploy order

Bootstrap the remote state backend first from
`xx-azurerm-bootstrap-terraform-state`, then initialize each workload stack
with its backend config.

Example:

```bash
cd 01-jumphost
terraform init -backend-config=../backend/dev/jumphost.hcl
terraform plan -var-file=environments/dev.tfvars -out=tfplan
# terraform apply tfplan only after human approval
```

## Stack pins

| Workload root | Stack | Version |
| --- | --- | --- |
| `01-jumphost` | `xx-azurerm-stack-jumphost` | `v0.0.2` |
