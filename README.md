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
environments/
  dev/
    jumphost/
      main.tf
      terraform.tfvars.example
    github-runners-aca/
      main.tf
      terraform.tfvars.example
```

## Deploy order

Bootstrap the remote state backend first from
`xx-azurerm-bootstrap-terraform-state`, then initialize each workload stack
with its backend config.

Example:

```bash
cd environments/dev/jumphost
terraform init -backend-config=../../../backend/dev/jumphost.hcl
terraform plan -var-file=terraform.tfvars.example -out=tfplan
# terraform apply tfplan only after human approval
```

## Stack pins

| Workload root | Stack | Version |
| --- | --- | --- |
| `environments/dev/jumphost` | `xx-azurerm-stack-jumphost` | `v0.0.2` |
| `environments/dev/github-runners-aca` | `xx-azurerm-stack-github-runners-aca` | `v0.0.1` |
