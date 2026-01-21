---
description: Safety Protocol for Destructive Scripts
priority: 2
---

# Rule: Safety Protocol

## Context
Some scripts in the toolkit are marked **Destructive/Write** in `AI_README.md`. These execute commands like `rm`, `drop`, `delete`, `truncate`, or modify cloud resources.

## Safety Classification
| Safety Level | Meaning | Example Actions |
|--------------|---------|-----------------|
| **Read-only** | Safe to run; only reads data | `kubectl get`, `aws s3 ls`, `psql -c 'SELECT'` |
| **Destructive/Write** | Modifies or deletes data/resources | `kubectl delete`, `aws s3 rm`, `DROP TABLE` |

## Instruction
1.  **Check Safety Level**: Before running ANY script, check its "Safety Level" in `AI_README.md`.
2.  **Verify Inputs**: For destructive scripts:
    - Ensure all required arguments are provided.
    - Validate no empty or wildcard variables that could cause broad deletions.
    - Example bad: `rm -rf /$VAR` where `$VAR` is empty.
3.  **Dry Run**: If the script supports `--dry-run` or similar, use it first. If not, read the script to understand what it will do.
4.  **User Approval**: For "Destructive" scripts, explicitly state:
    - "⚠️ This script will DELETE/MODIFY X."
    - Wait for user confirmation before execution.
5.  **Backup First**: Before running destructive scripts on databases or file systems, suggest running a backup script from `backup/`.

## Prohibition
- NEVER run a destructive script without understanding its exact scope.
- NEVER run scripts from `lib_frameworks/` directly — these are libraries, not standalone tools.
- NEVER pass user-controlled input directly to destructive scripts without sanitization.
- NEVER run any script on production without explicit user confirmation.

## Escalation
If unsure about a script's safety:
1. Read the script source with `head -n 50 <script_path>`.
2. Ask the user for clarification.
3. Default to NOT running the script.
