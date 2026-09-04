#!/usr/bin/env bash
set -euo pipefail

REPOS_DIR="./repos"
NEW_BASE_URL="https://github.mijnbedrijf.com/ORG"  # pas aan

# oude map-naam -> nieuwe repo-naam
declare -A REPO_MAP=(
  ["xx-azurerm-bootstrap-terraform-state"]="AZLABS-cnc-azurerm-bootstrap-terraform-state"
  ["xx-azurerm-network"]="AZLABS-cnc-azurerm-network"
  ["xx-azurerm-stack-jumphost"]="AZLABS-cnc-azurerm-composition-jumphost"
  ["xx-azurerm-stack-bastion-access"]="AZLABS-cnc-azurerm-composition-bastion-access"
  ["xx-azurerm-vms"]="AZLABS-cnc-azurerm-vms"
  ["xx-azurerm-stack-github-runners-aca"]="AZLABS-cnc-azurerm-composition-github-runners-aca"
  ["xx-azurerm-container-apps"]="AZLABS-cnc-azurerm-container-apps"
  ["xx-azurerm-log-analytics"]="AZLABS-cnc-azurerm-loganalytics"
  ["xx-terraform-repo-scaffold"]="AZLABS-cnc-terraform-repo-scaffold"
)

for old_name in "${!REPO_MAP[@]}"; do
  new_name="${REPO_MAP[$old_name]}"
  repo_path="$REPOS_DIR/$old_name"

  if [[ ! -d "$repo_path" ]]; then
    echo "Skip: $repo_path bestaat niet"
    continue
  fi

  echo "Repointing $old_name -> $new_name"
  git -C "$repo_path" remote set-url origin "$NEW_BASE_URL/$new_name.git"
done