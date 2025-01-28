# kube-test-assignment

## Overview

This project contains a simple Go-based API designed to check the primality of arbitrary numbers. It is deployed on an Azure Kubernetes Service cluster using Terraform to manage infrastructure, Helm for application deployment, and Azure DevOps for CI/CD pipelines.


## Directory Structure

- **`terraform/`**: Contains all the Terraform files required to provision infrastructure.
- **`charts/`**: Contains the Helm charts used for deploying the API to the Kubernetes cluster.
- **`src/`**: API source code in Go.
- **`scripts/`**: Deployment scripts, including `check-deployment.sh`, which ensures the deployment was successful and the service is healthy.

## Local Setup

## API

## Nots

> Сделать сервис, любой (можно несколько)

`src/prime-api`

> с пробросом к нему портов (http, https пару кастомных TCP- портов, желательно через ингресс)

Since we're using ingress, only http and https ports are forwarded. To be discussed.

> Развернуть этот сервис (сервисы) в кубернетес кластере (любом, желательно Azure)

[kube-test-assignment-cluster.eastus.cloudapp.azure.com](https://kube-test-assignment-cluster.eastus.cloudapp.azure.com/version)

> сделать хельмом

`charts/prime-api`

> через Ажур Девопс (релизы)

https://dev.azure.com/andreitestorg/kube-test-assignment (not public)

> Написать скрипт проверяющий, что это действительно накатилось и который запускается после деплоя в той же стадии и проверяет что все ок

scripts/check-deployment.sh

> (порты доступны , хельм релиз в статусе деплойд итд, чтобы pending статус например чекать и откатывать релиз обратно, если что-то не так, на предыдущую версию)

We could've relied on readinessProbe for this, but since writing custom script was requested, helm release status is checked in check-deployment.sh. Instead of checking if ports are open, /healthz endpoint is called for the purpose as a simpler option compared to checking port from inside the cluster.

> Создать успешные накаты и неуспешные (искусствено каким-либо образом симулировать это)

simulateFailure pipeline parameter / SIMULATE_FAILURE env var is used for the purpose.

> Проверить самостоятельно работоспособность всего этого.

✅ 
