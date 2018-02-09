# Ingress
Manages external access to the services in a cluster, typically HTTP.

## Resources
* [Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/)
* [API Reference](https://kubernetes.io/docs/api-reference/v1.9/#ingress-v1beta1-extensions)

## Kubectl commands

`kubectl get ingress`

`kubectl edit ingress ingress-name`

`kubectl replace -f ingress.yaml`

Test ingress:
```bash

kubectl run curl --image=appropriate/curl
kubectl exec -it <CURL_POD> -- curl -I -L --resolve nginx.kuba.pl:80:10.240.0.21 http://nginx.nkuba.io
```
## Manifests

[ingress.yaml](ingress.yaml)
```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ghost
spec:
  rules:
    - host: ghost.192.168.99.100.nip.io
      http:
        paths: 
        - backend:
            serviceName: ghost
            servicePort: 2368
    - host: nginx.nkuba.io
      http:
        paths:
        - backend:
            serviceName: nginx
            servicePort: 80
```


