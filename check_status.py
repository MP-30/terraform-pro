import boto3

# Connect Boto3 directly to LocalStack endpoint
ENDPOINT = "http://localhost:4566"
REGION = "us-east-1"

# 1. Check S3 Buckets
s3 = boto3.client('s3', endpoint_url=ENDPOINT, region_name=REGION)
buckets = s3.list_buckets()
print("--- S3 BUCKETS ---")
for b in buckets.get('Buckets', []):
    print(f" Bucket: {b['Name']}")

# 2. Check IAM Roles
iam = boto3.client('iam', endpoint_url=ENDPOINT, region_name=REGION)
roles = iam.list_roles()
print("\n--- IAM ROLES ---")
for r in roles.get('Roles', []):
    print(f" Role: {r['RoleName']}")

# 3. Check DynamoDB Tables
dynamodb = boto3.client('dynamodb', endpoint_url=ENDPOINT, region_name=REGION)
tables = dynamodb.list_tables()
print("\n--- DYNAMODB TABLES ---")
for t in tables.get('TableNames', []):
    print(f" Table: {t}")