# #chmod +x run-terraform.sh
# #./run-terraform.sh


# #!/bin/bash

# # Step 1: Define working directory and image name
# WORKDIR=$(pwd)/terraform
# IMAGE_NAME=terraform-container

# echo "➡️ Building Docker image for Terraform..."
# docker build -t $IMAGE_NAME $WORKDIR

# echo "✅ Docker image built successfully!"

# # Step 2: Run terraform init
# echo "➡️ Running terraform init..."
# docker run --rm -v $WORKDIR:/workspace -w /workspace $IMAGE_NAME init

# # Step 3: Run terraform plan
# echo "➡️ Running terraform plan..."
# docker run --rm -v $WORKDIR:/workspace -w /workspace $IMAGE_NAME plan

# # Step 4: Run terraform apply
# echo "➡️ Running terraform apply..."
# docker run --rm -v $WORKDIR:/workspace -w /workspace $IMAGE_NAME apply -auto-approve

# echo "✅ Terraform apply completed!"
