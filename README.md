# kube-test-assignment

## Overview

This project contains a simple API written in Go designed to check the primality of arbitrary numbers.
It is deployed on an Azure Kubernetes Service cluster with Helm from an Azure DevOps pipeline.
Terraform is used to provision the necessary infrastructure.
Container images are stored in ACR.
Failure simulation is implemented to test the system’s rollback capability.

## Directory Structure

- **`terraform/`**: Contains Terraform files required to provision AKS, nginx ingress controller (with Helm), ACR and to grant necessary permissions
- **`charts/`**: Contains the Helm chart used for deploying the API to the Kubernetes cluster. Note: it was scaffolded by `helm create` and adjusted where necessary.
- **`src/`**: API source code in Go.
- **`scripts/`**: Deployment scripts, including `check-deployment.sh`, which ensures the deployment was successful and the service is healthy.

## Local Setup

1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

2. Create `terraform/terraform.tfvars` file and fill it with the following values:

    ```hcl
    subscription_id = "<your Azure subscription id>"
    tenant_id       = "<your Azure tenant id>"
    ```

3. Run `az login && cd terraform && terraform apply`

4. Set up an Azure DevOps account with connections to this repository, Azure subscription and ACR

5. Run the pipeline. Use `Simulate Failure` parameter to simulate app freezing before starting listening on the port, if needed. When failure simulation is disabled, the app still has a 15-second sleep before listening on the port so that the `Check helm is deployed and port is open` step can perform a few checks.

## API

### 1. **GET /is-prime/{int}**

- **Description**: Checks if the given integer is a prime number.

### 2. **GET /next-prime/{int}**

- **Description**: Returns the next prime number greater than the given integer.

### 3. **GET /version**

- **Description**: Returns the application version (useful for failure simulation tests).

### 4. **GET /healthz**

- **Description**: Checks the health status of the API service.


## Notes

> Сделать сервис, любой (можно несколько)

`src/prime-api`

> с пробросом к нему портов (http, https пару кастомных TCP- портов, желательно через ингресс)

Since we're using ingress, only http and https ports are forwarded in this solution. To be discussed.

> Развернуть этот сервис (сервисы) в кубернетес кластере (любом, желательно Azure)

[kube-test-assignment-cluster.eastus.cloudapp.azure.com](https://kube-test-assignment-cluster.eastus.cloudapp.azure.com/version) (might be offline, because the cluster is deallocated to save on infrastructure costs)

> сделать хельмом

`charts/prime-api`

> через Ажур Девопс (релизы)

https://dev.azure.com/andreitestorg/kube-test-assignment (not public)

> Написать скрипт проверяющий, что это действительно накатилось и который запускается после деплоя в той же стадии и проверяет что все ок

`scripts/check-deployment.sh`

> (порты доступны , хельм релиз в статусе деплойд итд, чтобы pending статус например чекать и откатывать релиз обратно, если что-то не так, на предыдущую версию)

We could've relied on readinessProbe for this, but since writing a custom script was requested, helm release status is checked in check-deployment.sh. Instead of checking if ports are open, /healthz endpoint is called for this purpose as a simpler option compared to checking port from inside the cluster.

> Создать успешные накаты и неуспешные (искусствено каким-либо образом симулировать это)

`simulateFailure` pipeline parameter / `SIMULATE_FAILURE` env var are used for the purpose.

> Проверить самостоятельно работоспособность всего этого.

✅ 
