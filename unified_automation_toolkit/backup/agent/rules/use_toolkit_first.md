---
description: Primary Directive - Use Existing Toolkit
priority: 1
---

# Rule: Use Unified Automation Toolkit First

## Context
You have access to a library of 1300+ production-ready automation scripts in `unified_automation_toolkit`.

## Instruction
1.  **Before writing code**: You MUST consult `AI_README.md` or `context.json` to see if a tool already exists.
2.  **Search Strategy**:
    - Use `grep -i <keyword> AI_README.md` to find relevant scripts.
    - Check the "Intent" column for description and "Trigger Keywords" for quick matching.
3.  **Reuse > Recreate**: If a script exists that does 80%+ of what is needed, use it (or wrap it) rather than writing a new one.
4.  **Reference**: When proposing a solution, always cite the script path.
5.  **Wrapper Scripts**: If you must extend functionality, create a thin wrapper that calls an existing toolkit script.

## Example
**User**: "I need to check SSL expiry for a domain."
**Bad Response**: "Here is a Python script I wrote to check SSL..."
**Good Response**: "I found `security/check-ssl-expiry.sh` in the toolkit. I can run it like: `./security/check-ssl-expiry.sh example.com`"

## Exceptions
You may write new code only if:
1. No existing script matches the requirement after thorough search.
2. User explicitly requests a custom solution.
3. Integration requires language-specific code (e.g., Python API client).
