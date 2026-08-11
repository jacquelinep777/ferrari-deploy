# ferrari-deploy

Example workload repository for the `ferrari` customer/application.

This repo demonstrates the workload layer from the Terraform module strategy:

- no resource logic
- exact stack version pins
- one state per environment per stack
- backend config owned by the workload
- environment values owned by the workload

## Layout

```text
backend/
  dev/
    jumphost.hcl
    github-runners-aca.hcl
01-jumphost/
  main.tf
  variables.tf
  outputs.tf
  environments/
    dev.tfvars
    test.tfvars
    acc.tfvars
    prod.tfvars
02-github-runners-aca/
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

For secrets, use environment variables or the pipeline secret store, not tfvars:

```bash
export TF_VAR_github_pat="..."
```

## Stack pins

| Workload root | Stack | Version |
| --- | --- | --- |
| `01-jumphost` | `xx-azurerm-stack-jumphost` | `v0.0.2` |
| `02-github-runners-aca` | `xx-azurerm-stack-github-runners-aca` | `v0.0.1` |
