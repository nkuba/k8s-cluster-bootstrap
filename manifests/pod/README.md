# Pods

## Resources
* [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod/)
* [API Reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/#pod-v1-core)

## Kubectl commands

```bash
kubectl get pods --show-labels

kubectl label pods my-pod new-label=awesome                      # Add a Label
kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
```

* Get all pods for node `<NODE_NAME>`
```bash
kubectl get pods -o jsonpath='{range .items[?(@.spec.nodeName=="<NODE_NAME>")]}{.metadata.name}{"\n"}' --all-namespaces
```

* Get pods with _pod name_ and _node names_ sort by second column
```bash
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.nodeName}{"\n"}' --all-namespaces | sort -k 2
```

## Manifests

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
  - name: busybox
    image: busybox
    command:
    - sleep
    - "3600"
```
