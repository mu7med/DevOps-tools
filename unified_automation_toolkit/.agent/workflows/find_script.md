---
description: Workflow for discovering the correct script for a user task
---

# Script Discovery Workflow

Use this workflow when a user requests an automation task.

## Step 1: Analyze the Request
Identify key elements:
- **Action verb**: create, delete, list, check, backup, deploy, etc.
- **Resource noun**: pod, bucket, user, database, certificate, etc.
- **Platform**: AWS, GCP, Kubernetes, Jenkins, GitHub, etc.

## Step 2: Search the Index
```bash
# Primary search
grep -i "<keyword>" AI_README.md | head -20

# Multi-term search
grep -i "<term1>" AI_README.md | grep -i "<term2>"

# Example: Find S3 bucket scripts
grep -i "s3" AI_README.md | grep -i "bucket"
```

## Step 3: Evaluate Candidates
For each match, check:
1. **Path relevance**: Does the directory match the platform? (e.g., `cloud/aws/` for S3)
2. **Intent match**: Does the "Intent" column describe the desired action?
3. **Safety Level**: Is it Read-only or Destructive?

## Step 4: Inspect the Script
```bash
# View script header for usage info
head -n 40 <script_path>

# Check for required arguments
grep -E "^\$[0-9]|Usage:|USAGE:" <script_path>
```

## Step 5: Propose to User
Format your response:
```
I found `<path/to/script.sh>` which <description>.

**Safety Level**: Read-only|Destructive
**Required Arguments**: <list>
**Usage Example**: <command>

Shall I run this?
```

## Example Walkthrough
**User**: "I need to find unused IAM service accounts in GCP"

1. **Analyze**: action=find, resource=service accounts, platform=GCP
2. **Search**: `grep -i "serviceaccount" AI_README.md | grep -i "gcp"`
3. **Result**: `gcp_iam_serviceaccounts_without_permissions.sh`
4. **Inspect**: `head -n 30 cloud/gcp/gcp_iam_serviceaccounts_without_permissions.sh`
5. **Propose**: "I found `cloud/gcp/gcp_iam_serviceaccounts_without_permissions.sh` which lists GCP service accounts that have no IAM permissions assigned."
