set -euo pipefail

BASE_URL="https://github.com/jacquelinep777"
TARGET_DIR="./repos"

REPOS=(
  "xx-azurerm-bootstrap-terraform-state"
  "xx-azurerm-network"
  "xx-azurerm-stack-jumphost"
  "xx-azurerm-stack-bastion-access"
  "xx-azurerm-vms"
  "xx-azurerm-stack-github-runners-aca"
  "xx-azurerm-container-apps"
  "xx-azurerm-log-analytics"
  "xx-terraform-repo-scaffold"
)

mkdir -p "$TARGET_DIR"

for repo in "${REPOS[@]}"; do
  echo "Cloning $repo..."
  git clone "$BASE_URL/$repo.git" "$TARGET_DIR/$repo"
done
