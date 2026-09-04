#!/usr/bin/env bash
set -euo pipefail

REPOS_DIR="."

NEW_REPO_NAMES=(
  "AZLABS-cnc-azurerm-bootstrap-terraform-state"
  "AZLABS-cnc-azurerm-network"
  "AZLABS-cnc-azurerm-composition-jumphost"
  "AZLABS-cnc-azurerm-composition-bastion-access"
  "AZLABS-cnc-azurerm-vms"
  "AZLABS-cnc-azurerm-composition-github-runners-aca"
  "AZLABS-cnc-azurerm-container-apps"
  "AZLABS-cnc-azurerm-loganalytics"
  "AZLABS-cnc-terraform-repo-scaffold"
)

for repo_name in "${NEW_REPO_NAMES[@]}"; do
  repo_path="$REPOS_DIR/$repo_name"

  if [[ ! -d "$repo_path" ]]; then
    echo "Skip: $repo_path bestaat niet"
    continue
  fi

  branch="$(git -C "$repo_path" symbolic-ref --short HEAD)"

  echo "Pushing $repo_name (branch: $branch)"
  git -C "$repo_path" push -u origin "$branch"
done