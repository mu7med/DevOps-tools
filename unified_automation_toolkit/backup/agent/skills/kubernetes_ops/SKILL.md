---
name: Kubernetes Operations
description: Managing K8s clusters using the toolkit's kubernetes/ library.
---

# Kubernetes Operations Skill

## Overview
The `kubernetes/` directory contains 91 scripts for K8s management. These wrap `kubectl`, `helm`, and `argocd` with enhanced functionality.

## Prerequisites
- `KUBECONFIG` environment variable set, OR
- Active kubectl context configured (`kubectl config current-context`)

## Script Categories

### Cluster Introspection (Read-only)
| Script | Purpose |
|--------|---------|
| `kubectl_get_all.sh` | Dump all resources in a namespace |
| `kubectl_pod_count.sh` | Count running pods |
| `kubectl_images.sh` | List container images in use |
| `kubectl_container_counts.sh` | Count containers per pod |
| `kubectl_node_labels.sh` | Show node labels |
| `kubectl_node_taints.sh` | Show node taints |

### Pod Operations
| Script | Purpose |
|--------|---------|
| `kubectl_pods_dump_logs.sh` | Bulk extract logs from pods |
| `kubectl_pods_per_node.sh` | Show pod distribution across nodes |
| `kubectl_pod_ips.sh` | List pod IP addresses |
| `kubectl_exec.sh` | Simplified exec into pods |

### Namespace Management
| Script | Purpose | Safety |
|--------|---------|--------|
| `kubectl_create_namespaces.sh` | Create namespaces from list | Read-only |
| `kubectl_delete_empty_namespaces.sh` | Remove empty namespaces | Destructive |
| `kubectl_empty_namespaces.sh` | List empty namespaces | Read-only |

### ArgoCD Integration
| Script | Purpose |
|--------|---------|
| `argocd_apps_sync.sh` | Sync ArgoCD applications |
| `argocd_apps_wait_sync.sh` | Wait for sync to complete |
| `argocd_auto_sync.sh` | Enable auto-sync on apps |
| `argocd_password.sh` | Get ArgoCD admin password |

### Helm Operations
| Script | Purpose |
|--------|---------|
| `helm_template.sh` | Render Helm templates locally |
| `kustomize_parse_helm_charts.sh` | Extract Helm chart info from kustomize |

## Best Practices
1. **Pre-flight**: Always run `kubectl_get_all.sh` before making changes to capture current state.
2. **Context Check**: Verify you're on the correct cluster before running any script.
3. **Namespace Scope**: Most scripts operate on the current namespace; use `-n <namespace>` where applicable.
4. **Destructive Scripts**: Scripts like `kubectl_delete_*` require explicit confirmation.
