---
description: Workflow for deploying applications to Kubernetes using the toolkit
---

# Deploy to Kubernetes Workflow

## Prerequisites
- [ ] `KUBECONFIG` is set or kubectl context is correct
- [ ] User has confirmed target cluster and namespace
- [ ] Application manifests or Helm chart are ready

## Related Skills
- `kubernetes_ops` — Core K8s script usage
- `git-pushing` — Commit deployment manifests
- `test-fixing` — If deployment tests fail

## Phase 1: Pre-flight Checks

### 1.1 Verify Cluster Access
```bash
kubectl cluster-info
kubectl config current-context
```

### 1.2 Capture Current State (Backup)
```bash
./kubernetes/kubectl_get_all.sh > pre-deploy-state.yaml
```

### 1.3 Check Namespace Exists
```bash
kubectl get namespace <target-namespace>
# If needed:
./kubernetes/kubectl_create_namespaces.sh <namespace1> <namespace2>
```

## Phase 2: Deployment

### Option A: Using kubectl (Manifests)
```bash
kubectl apply -f <manifest.yaml> -n <namespace>
```

### Option B: Using Helm
```bash
# Preview what will be deployed
./kubernetes/helm_template.sh <chart> <release-name>

# Deploy
helm upgrade --install <release-name> <chart> -n <namespace>
```

### Option C: Using ArgoCD
```bash
# Sync specific app
./kubernetes/argocd_apps_sync.sh <app-name>

# Wait for sync to complete
./kubernetes/argocd_apps_wait_sync.sh <app-name>
```

## Phase 3: Verification

### 3.1 Check Pod Status
```bash
./kubernetes/kubectl_pod_count.sh
kubectl get pods -n <namespace> -w
```

### 3.2 Verify Logs (if pods are crashing)
```bash
./kubernetes/kubectl_pods_dump_logs.sh <pod-name-regex>
```

### 3.3 Health Check
```bash
./monitoring/health-check.sh <service-endpoint>
```

### 3.4 If Tests Fail
Use skill: `test-fixing` to systematically resolve failing tests.

## Phase 4: Commit & Push

After successful deployment, use skill: `git-pushing` to:
1. Stage deployment manifests
2. Commit with conventional commit message
3. Push to remote

## Phase 5: Rollback (If Needed)

### If deployment fails:
1. Check logs: `./kubernetes/kubectl_pods_dump_logs.sh`
2. Describe pods: `kubectl describe pod <pod-name>`
3. Rollback Helm: `helm rollback <release-name>`
4. Rollback kubectl: `kubectl apply -f pre-deploy-state.yaml`

## Safety Reminders
- ⚠️ Always capture state before deployment
- ⚠️ Verify you're on the correct cluster context
- ⚠️ Test in non-production first
