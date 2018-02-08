# Manifests

Manifests templates generated based on official Kubernetes [Documentation](https://kubernetes.io/docs/) 
and [API Reference v1.9](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/)


## Cheat Sheet
Based on official [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

### Autocompletion
```bash
source <(kubectl completion bash)
```

### Resource lifecycle operations

#### Create
```bash
kubectl create -f my-manifest.yaml            # create from file
kubectl create -f my1.yaml -f my2.yaml        # create from multiple files
kubectl create -f dir                         # create from files in dir
```

#### Read
```bash
kubectl get pods                              # List all pods in the namespace
kubectl get pods --all-namespaces             # List all pods in all namespaces
kubectl get pods -o wide                      # List all pods in the namespace, with more details
kubectl get pods --include-uninitialized      # List all pods in the namespace, including uninitialized ones
kubectl get pod my-pod                        # List a particular deployment

kubectl describe nodes my-node

kubectl get services --sort-by=.metadata.name # List Services Sorted by Name

# List pods Sorted by Restart Count
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

# Get the version label of all pods with label app=cassandra
kubectl get pods --selector=app=cassandra -o jsonpath='{.items[*].metadata.labels.version}'

# Get all running pods in the namespace
kubectl get pods --field-selector=status.phase=Running

# Get ExternalIPs of all nodes
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'

# List Names of Pods that belong to Particular Deployment
# "jq" command useful for transformations that are too complex for jsonpath, it can be found at https://stedolan.github.io/jq/
sel=$(kubectl get deployment nginx-deployment -o=json | jq -j '.spec.selector.matchLabels | to_entries | map([.key,.value] | join("=")) | join(",")')
kubectl get pods -l=$sel -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}'
```
#### Update
```bash
# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.json


```