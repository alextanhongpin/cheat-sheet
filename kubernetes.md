## Using minikube as a docker-machine to avoid sharing a local-registry

```bash
$ eval $(minikube docker-env)
```

## Probes for HTTP Services

The `readinessProbe` and `livenessProbe` attributes should be placed at the same level as the `name` and `image` attributes of your containers in a deployment:

```yaml
readinessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 5
  timeoutSeconds: 1
  periodSeconds: 15

livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 15
  timeoutSeconds: 1
  periodSeconds: 15
```
