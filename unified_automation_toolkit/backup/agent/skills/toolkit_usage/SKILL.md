---
name: Toolkit Usage
description: How to effectively search and use the Unified Automation Toolkit.
---

# Toolkit Usage Skill

## Overview
This skill defines how to find and utilize scripts from the `unified_automation_toolkit`. The toolkit contains 1300+ scripts organized by function.

## Search Methods

### Method 1: Grep AI_README.md (Recommended)
```bash
grep -i "<keyword>" AI_README.md
```
This searches the human-readable index. Look at:
- **Script Path**: Location of the script
- **Intent**: What the script does
- **Safety Level**: Read-only or Destructive/Write

### Method 2: Query context.json (Programmatic)
```bash
cat context.json | jq '.[] | select(.Path | contains("<keyword>"))'
```

### Method 3: Find by Directory
```bash
ls <directory>/
# Example: ls kubernetes/
```

## Execution Flow
1. **Search**: Find a candidate script using methods above.
2. **Inspect**: Read the script header to understand arguments:
   ```bash
   head -n 30 <script_path>
   ```
3. **Check Safety**: Verify the Safety Level in AI_README.md.
4. **Set Environment**: Ensure required variables are set (e.g., `AWS_PROFILE`, `KUBECONFIG`).
5. **Execute**: Run the script with appropriate arguments.

## Common Environment Variables
| Variable | Used By | Purpose |
|----------|---------|---------|
| `AWS_PROFILE` | `cloud/aws/*` | AWS credential profile |
| `KUBECONFIG` | `kubernetes/*` | Kubernetes cluster config |
| `GOOGLE_APPLICATION_CREDENTIALS` | `cloud/gcp/*` | GCP service account |
| `GITHUB_TOKEN` | `github/*` | GitHub API authentication |

## Example: Finding a Backup Script
```bash
# Step 1: Search
grep -i "backup" AI_README.md

# Step 2: Inspect result
head -n 20 backup/backup.sh

# Step 3: Execute
./backup/backup.sh /data /backup
```
