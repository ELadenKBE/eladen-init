#!/bin/bash

# Function to clone a repository if it does not exist and check if it was successful
clone_repository() {
  local repo_url="$1"
  local repo_name="${repo_url##*/}"
  repo_name="${repo_name%.git}"

  if [ -d "$repo_name" ]; then
    echo "Repository $repo_name already exists. Skipping..."
    return 0
  fi

  git clone "$repo_url" || { echo "Failed to clone $repo_url"; exit 1; }

  echo "Successfully cloned $repo_name"
}

# Git repositories to clone
repositories=(
  "https://github.com/ELadenKBE/eladen-product-service"
  "https://github.com/ELadenKBE/eladen-order-service"
  "https://github.com/ELadenKBE/eladen-useridentity-service"
  "https://github.com/ELadenKBE/eladen-api-gateway"
)

# Clone repositories
for repo in "${repositories[@]}"; do
  clone_repository "$repo"
done

# Execute docker-compose up from the root directory
cd eladen-product-service || { echo "Failed to change directory to eladen-product-service"; exit 1; }
cd ..

cd eladen-order-service || { echo "Failed to change directory to eladen-order-service"; exit 1; }
cd ..

cd eladen-useridentity-service || { echo "Failed to change directory to eladen-useridentity-service"; exit 1; }
cd ..

cd eladen-api-gateway || { echo "Failed to change directory to eladen-api-gateway"; exit 1; }
cd ..

# Execute docker-compose up from the root directory
docker-compose -f docker-compose-services.yaml up -d
cd keycloak
docker-compose -f docker-compose-keycloak.yaml up -d

echo "All repositories cloned and docker-compose up executed successfully!"
