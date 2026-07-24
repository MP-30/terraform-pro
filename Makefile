# Variables
ENDPOINT = http://localhost:4566
REGION = us-east-1

# List of all lab directories
LABS = 01-iam 02-ec2 03-dyno 04-s3

.PHONY: all-init all-apply all-destroy status clean check help

# Default target when you just run 'make'
help:
	@echo "Available commands:"
	@echo "  make apply LAB=01-iam  - Run 'tflocal apply' inside a specific lab folder"
	@echo "  make init LAB=01-iam   - Run 'tflocal init' inside a specific lab folder"
	@echo "  make destroy LAB=01-iam- Destroy resources in a specific lab folder"
	@echo "  make all-apply         - Apply Terraform across ALL subfolder labs"
	@echo "  make all-destroy       - Destroy resources across ALL subfolder labs"
	@echo "  make check             - Run python check_status.py script"
	@echo "  make status            - Quick AWS CLI sanity check"

# 1. Single-Lab Commands (Pass LAB=folder_name, e.g., make apply LAB=01-iam)
init:
	@if [ -z "$(LAB)" ]; then echo "Error: Please specify LAB (e.g., make init LAB=01-iam)"; exit 1; fi
	cd $(LAB) && tflocal init

plan:
	@if [ -z "$(LAB)" ]; then echo "Error: Please specify LAB (e.g., make plan LAB=01-iam)"; exit 1; fi
	cd $(LAB) && tflocal plan

apply:
	@if [ -z "$(LAB)" ]; then echo "Error: Please specify LAB (e.g., make apply LAB=01-iam)"; exit 1; fi
	cd $(LAB) && tflocal init && tflocal apply --auto-approve

destroy:
	@if [ -z "$(LAB)" ]; then echo "Error: Please specify LAB (e.g., make destroy LAB=01-iam)"; exit 1; fi
	cd $(LAB) && tflocal destroy --auto-approve

# 2. Batch Operations Across All Labs
all-init:
	@for lab in $(LABS); do \
		echo "\n--- Initializing $$lab ---"; \
		(cd $$lab && tflocal init) || exit 1; \
	done

all-apply:
	@for lab in $(LABS); do \
		echo "\n--- Applying $$lab ---"; \
		(cd $$lab && tflocal init && tflocal apply --auto-approve) || exit 1; \
	done

all-destroy:
	@for lab in $(LABS); do \
		echo "\n--- Destroying $$lab ---"; \
		(cd $$lab && tflocal destroy --auto-approve) || exit 1; \
	done

# 3. Check What Is Currently Running via CLI
status:
	@echo "=== S3 Buckets ==="
	@aws --endpoint-url=$(ENDPOINT) s3 ls || true
	@echo "\n=== IAM Roles ==="
	@aws --endpoint-url=$(ENDPOINT) iam list-roles --query "Roles[*].RoleName" --output text || true
	@echo "\n=== DynamoDB Tables ==="
	@aws --endpoint-url=$(ENDPOINT) dynamodb list-tables --region $(REGION) --output text || true

# 4. Run Python Status Check
check:
	python3 check_status.py

# 5. Complete Reset Across All Labs
clean:
	@for lab in $(LABS); do \
		echo "Cleaning $$lab..."; \
		rm -rf $$lab/.terraform $$lab/.terraform.lock.hcl $$lab/terraform.tfstate*; \
	done