# Variables
ENDPOINT = http://localhost:4566
REGION = us-east-1

.PHONY: init plan apply destroy status clean test-iam

# 1. Terraform Shortcuts
init:
	tflocal init

plan:
	tflocal plan

apply:
	tflocal apply --auto-approve

destroy:
	tflocal destroy --auto-approve

# 2. Check What Is Currently Running
status:
	@echo "=== S3 Buckets ==="
	@aws --endpoint-url=$(ENDPOINT) s3 ls || true
	@echo "\n=== IAM Roles ==="
	@aws --endpoint-url=$(ENDPOINT) iam list-roles --query "Roles[*].RoleName" --output text || true
	@echo "\n=== DynamoDB Tables ==="
	@aws --endpoint-url=$(ENDPOINT) dynamodb list-tables --region $(REGION) --output text || true

# 3. Complete Reset (Destroy Resources & Clear Terraform Cache)
clean: destroy
	rm -rf .terraform .terraform.lock.hcl terraform.tfstate*

# 4. Run your Python Boto3 check script
check:
	python3 check_status.py