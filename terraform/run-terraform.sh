#!/bin/bash

# Step 1: Define working directory and image name
WORKDIR= terraform
IMAGE_NAME=terraform-container

# Convert Windows-style path to absolute path using cygpath
WORKDIR_ABS=$(cygpath -w $WORKDIR)

echo "➡️ Building Docker image for Terraform..."
docker build -t $IMAGE_NAME $WORKDIR
if [ $? -ne 0 ]; then
  echo "❌ Docker build failed"
  exit 1
fi
echo "✅ Docker image built successfully!"

# Step 2: Run terraform init
echo "➡️ Running terraform init..."
docker run --rm -v $WORKDIR_ABS:/workspace -w /workspace $IMAGE_NAME init
if [ $? -ne 0 ]; then
  echo "❌ Terraform init failed"
  exit 1
fi

echo "✔️ Terraform init completed successfully!"

# Step 3: Run terraform plan
echo "➡️ Running terraform plan..."
docker run --rm -v $WORKDIR_ABS:/workspace -w /workspace $IMAGE_NAME plan
if [ $? -ne 0 ]; then
  echo "❌ Terraform plan failed"
  exit 1
fi

echo "✔️ Terraform plan completed successfully!"

# Step 4: Run terraform apply
echo "➡️ Running terraform apply..."
docker run --rm -v $WORKDIR_ABS:/workspace -w /workspace $IMAGE_NAME apply -auto-approve
if [ $? -ne 0 ]; then
  echo "❌ Terraform apply failed"
  exit 1
fi

echo "✅ Terraform apply completed successfully!"

# Additional debugging (optional)
echo "➡️ Output of Docker containers currently running:"
docker ps -a

echo "➡️ Docker logs for the terraform-container (if any):"
docker logs $(docker ps -aqf "name=terraform-container")
