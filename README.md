# helmsman-ship

Структура каталогов

##docker-registry

deploy docker-registry
```
kubectl apply -f k8s/namespaces/registry-namespace.yaml
kubectl apply -f k8s/docker-registry/
```

check status 
```
kubectl get pods -n registry
kubectl get svc -n registry
kubectl get ingress -n registry
```

##hashicorp vault

Создание секретов:
Выполните команды для добавления секретов в Vault (например, credentials для Docker Registry):
bash
```
kubectl exec -n vault -it $VAULT_POD -- vault kv put secret/docker-registry username=admin password=securepass
```

Доступ к секретам в приложении:
Используйте Vault Agent или CSI Driver, чтобы подключить секреты как файлы или переменные окружения.
Пример с использованием Kubernetes Secret, создаваемого Vault:yaml


```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: my-app
    image: my-app:latest
    env:
    - name: DOCKER_USERNAME
      valueFrom:
        secretKeyRef:
          name: vault-docker-secrets
          key: username
    - name: DOCKER_PASSWORD
      valueFrom:
        secretKeyRef:
          name: vault-docker-secrets
          key: password
```