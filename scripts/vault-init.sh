#!/bin/bash

VAULT_POD=$(kubectl get pods -n vault -l app=vault -o jsonpath="{.items[0].metadata.name}")

# Инициализация Vault
kubectl exec -n vault $VAULT_POD -- vault operator init > vault-keys.txt

# Разблокировка Vault
for i in $(seq 1 3); do
  kubectl exec -n vault $VAULT_POD -- vault operator unseal $(grep "Unseal Key $i:" vault-keys.txt | awk '{print $NF}')
done