---
description: Global workflow for bootstrapping a new project using standard toolkit components.
---

# Project Bootstrap Workflow

This workflow sets up a new project with proper DevOps foundations.

## Related Skills
- `planning-with-files` — Create detailed implementation plan first
- `executing-plans` — Execute plan in batches with review
- `git-pushing` — Commit and push changes
- `github-workflow-automation` — Set up CI/CD pipelines
- `linux-shell-scripting` — Create custom automation scripts
- `kaizen` — Apply continuous improvement principles

## Prerequisites
- Git installed and configured
- Cloud CLI authenticated (AWS/GCP)
- Access to target Kubernetes cluster (if applicable)

---

## Phase 0: Planning (Recommended)

For complex projects, use skill: `planning-with-files` to create:
- `task_plan.md` — Detailed implementation steps
- `findings.md` — Research and decisions
- `progress.md` — Execution tracking

---

## Phase 1: Version Control Setup

### 1.1 Initialize Repository
```bash
git init
# Or clone existing:
# ./git/git_repos_pull.sh <repo-url>
```

### 1.2 Configure Git
```bash
# Set up .gitignore using toolkit helper
./git/gitignore.io_api.sh terraform,python,node > .gitignore
```

### 1.3 Use Git Worktrees (for parallel work)
Use skill: `using-git-worktrees` for isolated feature development.

---

## Phase 2: CI/CD Pipeline Setup

### 2.1 Choose CI/CD Platform
| Platform | Setup Script | Config Location |
|----------|--------------|-----------------|
| Jenkins | `./jenkins/jenkins_cli.sh` | `Jenkinsfile` |
| GitHub Actions | N/A (YAML) | `.github/workflows/` |
| GitLab CI | N/A (YAML) | `.gitlab-ci.yml` |
| ArgoCD | `./kubernetes/argocd_*` | `argocd/` |

### 2.2 Set Up Secrets
```bash
# GitHub
./github/github_actions_repo_set_secret.sh <repo> <secret-name> <value>

# Jenkins
./jenkins/jenkins_cred_add_secret_text.sh <cred-id> <secret>
```

### 2.3 Automate with GitHub Workflow
Use skill: `github-workflow-automation` to set up:
- PR review automation
- Issue triage
- CI/CD triggers

---

## Phase 3: Infrastructure Setup

### 3.1 Terraform (if applicable)
```bash
# Check existing terraform scripts
ls terraform/
# Use import helpers for existing resources
./terraform/terraform_import.sh <resource> <id>
```

### 3.2 Kubernetes Namespaces
```bash
# Create standard environments
./kubernetes/kubectl_create_namespaces.sh dev staging prod
```

### 3.3 Cloud Resources
```bash
# AWS: Create necessary IAM roles
./cloud/aws/aws_iam_create_credential.sh <user>
```

---

## Phase 4: Monitoring Setup

### 4.1 Deploy Monitoring Stack
```bash
# Check available monitoring scripts
ls monitoring/
```

### 4.2 Configure Alerts
```bash
# Set up Slack notifications
./devops_cicd/slack-notify.sh "Project <name> bootstrap complete"
```

---

## Phase 5: Custom Scripts

If toolkit doesn't have a required script:
1. Use skill: `linux-shell-scripting` for production-ready templates
2. Follow `kaizen` principles (incremental, error-proof)
3. Add script to appropriate toolkit directory
4. Run `python3 scripts_indexer.py --json` to update index

---

## Phase 6: Documentation & Commit

### 6.1 Update README
Document in project README:
- How to run locally
- How to deploy
- Environment variables required
- Links to CI/CD dashboards

### 6.2 Commit with Conventional Commits
Use skill: `git-pushing` to:
1. Stage all changes
2. Create conventional commit message
3. Push to remote

---

## Checklist
- [ ] Git repo initialized with .gitignore
- [ ] CI/CD pipeline configured
- [ ] Kubernetes namespaces created
- [ ] Cloud credentials set up
- [ ] Monitoring deployed
- [ ] README updated
- [ ] Changes committed and pushed
