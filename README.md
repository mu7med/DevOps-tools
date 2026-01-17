# Unified Automation Toolkit

## Overview
This is a consolidated monorepo containing over 1300+ Bash automation scripts, organized by functionality. It aggregates tools from multiple sources into a standardized structure optimized for both human and AI agent use.

## Directory Structure
- **cloud/**: AWS, GCP, and other cloud provider scripts.
- **kubernetes/**: Extensive collection of K8s utilities (kubectl, helm, etc.).
- **devops_cicd/**: CI/CD integration for Jenkins, ArgoCD, TeamCity, etc.
- **database/**: PostgreSQL and MySQL/MariaDB automation.
- **monitoring/**: Logs, health checks, and metrics (Prometheus, Grafana).
- **security/**: SSL checks, password generation, and security auditing.
- **system/**: General Linux/macOS system administration.
- **install/**: Installers for 150+ DevOps tools (Terraform, Docker, CLIs).
- **lib_frameworks/**: Core libraries including `bashmatic` and shared utilities.

## AI Usage
A machine-readable index is available at [AI_README.md](AI_README.md).
AI Agents can parse this file to find scripts based on **Intent**, **Keywords**, or **Safety Level**.
A JSON version is also available at `context.json`.

## Safety
- **Read-only**: Scripts that only list or get information.
- **Destructive/Write**: Scripts that contain `rm`, `delete`, `drop`, or other potential change-inducing commands. **Use with caution.**
