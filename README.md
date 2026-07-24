# 🚀 Terraform AWS Certification & Hands-On Practice Labs

A practical, hands-on repository designed to learn **AWS Architecture** and **DevOps Infrastructure as Code (IaC)** by building real AWS resources using **Terraform** and testing them locally using **LocalStack**.

---

## 🛠 Tech Stack

* **Infrastructure as Code:** Terraform (`tflocal`)
* **Cloud Provider:** AWS API 
* **Language/SDK:** Python 3 (`boto3`)
* **Task Automation:** GNU Make
* **Environment:** Linux / Ubuntu

---

## 📁 Repository Structure

The project is organized into isolated, modular labs to practice specific AWS services independently without state file conflicts.

```text
terraform-pro/
├── 01-iam/            # IAM Users, Groups, Roles & Policies
├── 02-ec2/            # EC2 Instances & Security Groups
├── 03-dyno/           # DynamoDB Tables & Indexes
├── 04-s3/             # S3 Buckets & Bucket Policies
├── check_status.py    # Python Boto3 script to inspect active local resources
├── Makefile           # Workflows for single or batch lab execution
├── pyproject.toml     # Python dependencies managed via uv
└── README.md