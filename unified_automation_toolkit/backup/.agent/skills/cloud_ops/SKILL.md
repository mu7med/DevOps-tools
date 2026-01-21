---
name: Cloud Operations
description: Managing AWS/GCP resources using the toolkit's cloud/ library.
---

# Cloud Operations Skill

## Overview
The `cloud/` directory contains ~250 scripts for AWS and GCP automation.

## Prerequisites
- **AWS**: `AWS_PROFILE` set or `~/.aws/credentials` configured
- **GCP**: `gcloud auth login` completed or `GOOGLE_APPLICATION_CREDENTIALS` set

---

## AWS Operations (`cloud/aws/`)

### EC2 Management
| Script | Purpose | Safety |
|--------|---------|--------|
| `aws_ec2_amis.sh` | List AMIs | Read-only |
| `aws_ec2_instance_ip.sh` | Get instance IP | Read-only |
| `aws_ec2_ebs_volumes.sh` | List EBS volumes | Read-only |
| `aws_ec2_ami_create_from_instance.sh` | Create AMI from instance | Destructive |
| `aws_ec2_instance_clone.sh` | Clone an instance | Destructive |

### S3 Operations
| Script | Purpose | Safety |
|--------|---------|--------|
| `aws_s3_check_account_public_blocked.sh` | Check S3 public access block | Read-only |
| `aws_s3_check_buckets_public_blocked.sh` | Audit all buckets | Read-only |

### IAM Management
| Script | Purpose | Safety |
|--------|---------|--------|
| `aws_iam_create_credential.sh` | Create IAM access key | Destructive |
| `aws_iam_users.sh` | List IAM users | Read-only |

### EKS Kubernetes
| Script | Purpose |
|--------|---------|
| `aws_eks_kube_creds.sh` | Get kubeconfig for EKS cluster |
| `aws_eks_cluster_info.sh` | Get EKS cluster details |

---

## GCP Operations (`cloud/gcp/`)

### IAM & Service Accounts
| Script | Purpose |
|--------|---------|
| `gcp_iam_identities_in_use.sh` | List IAM identities with access |
| `gcp_iam_roles_in_use.sh` | List roles currently assigned |
| `gcp_iam_roles_granted_to_identity.sh` | Get roles for specific identity |
| `gcp_iam_serviceaccount_members.sh` | List SA members |
| `gcp_iam_serviceaccounts_without_permissions.sh` | Find unused SAs |

### Cloud SQL
| Script | Purpose |
|--------|---------|
| `gcp_sql_backup.sh` | Backup Cloud SQL instance |
| `gcp_sql_export.sh` | Export database |

### GKE Kubernetes
| Script | Purpose |
|--------|---------|
| `gcp_gke_cluster_credentials.sh` | Get kubeconfig for GKE |
| `gcp_gke_nodepool_nodes.sh` | List GKE node pool nodes |

---

## Safety Guidelines
1. **Prefer Read-only**: Use listing/checking scripts before modification scripts.
2. **Double-check Profile**: Verify `AWS_PROFILE` or `gcloud config get-value project` before running.
3. **Destructive Actions**: Scripts that create/modify resources require user confirmation.
4. **Credential Rotation**: Use `aws_iam_create_credential.sh` carefully — rotate, don't accumulate keys.
