# Repository instructions

This repository is a workload repo.

## Rules

- Workloads contain no infrastructure logic.
- Workloads pin released stack versions and provide environment values.
- Workloads own backend configuration, state keys, tfvars, and deployment pipelines.
- Do not define resources directly in workload roots.
- Do not put secrets in tfvars files.
- Do not use floating stack refs such as `main`.
- Use one Terraform state per workload per environment per stack.
- Run `terraform fmt -check -recursive` before pushing.
