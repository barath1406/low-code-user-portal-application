# Helm Chart for User Portal

This folder contains the Helm chart for deploying the **User Portal** Flask application on Kubernetes. The chart includes all necessary Kubernetes resources such as Deployment, Service, Ingress, and ServiceAccount.

## Chart Information

- **Name:** user-portal  
- **Description:** A Helm chart for deploying the Flask User Management Application  
- **Version:** 0.0.1  
- **App Version:** 1.0  

## Installation

### Prerequisites

Before deploying the chart, ensure you have the following installed and configured:

- [kubectl](https://kubernetes.io/docs/tasks/tools/)  
- [Helm 3](https://helm.sh/docs/intro/install/)  
- Access to a Kubernetes cluster (version 1.16+)  
- AWS CLI configured with appropriate permissions (if using AWS EKS and IAM roles)  

### Deployment Steps

> The Helm chart installation is managed via Terraform. The commands below are provided for manual deployment and for future reference to validate Kubernetes resources or troubleshoot pods if needed.

#### Helm Dry Run

Before applying changes, you can perform a dry run to preview the Kubernetes resources that Helm will create or modify without actually deploying them. This is useful for validation and troubleshooting.

Use the following command to perform a dry run:

```bash
helm upgrade --install --dry-run --debug barath-user-portal .
```

This command will simulate the deployment, showing the rendered Kubernetes manifests and any potential errors, without making any changes to your cluster.

#### Environment Values Usage

The deployment uses environment-specific values files located in the `chart/env_values/` directory. These files contain configuration overrides for different environments (e.g., development, staging, production).

To deploy using a specific environment values file, use the `-f` flag with Helm:

```bash
helm upgrade --install -f chart/env_values/development_values.yaml barath-user-portal .
```

This allows you to customize the deployment parameters such as service account, ingress settings, and annotations according to the target environment.

1. *(Optional)* Create a namespace if you want to deploy in a specific namespace:

```bash
kubectl create namespace <namespace>
```

2. Install or upgrade the Helm chart in the **default namespace**:

```bash
helm upgrade --install barath-user-portal .
```

3. To install or upgrade the chart in a **specific namespace**, add the `-n <namespace>` flag:

```bash
helm upgrade --install -n <namespace> barath-user-portal .
```

## Configuration

The following table lists the configurable parameters of the chart and their default values (defined in `values.yaml` and environment values files):

| Parameter                         | Description                                                  | Default                                   |
|----------------------------------|--------------------------------------------------------------|-------------------------------------------|
| `replicaCount`                   | Number of pod replicas                                       | 2                                         |
| `image.repository`               | Docker image repository                                      | barath1406/user-portal                    |
| `image.tag`                      | Docker image tag                                             | 0.0.1                                     |
| `image.pullPolicy`              | Image pull policy                                            | IfNotPresent                              |
| `nameOverride`                  | Override the chart name                                      | ""                                        |
| `fullnameOverride`              | Override the full name                                       | ""                                        |
| `serviceAccount.create`         | Whether to create a service account                          | true                                      |
| `serviceAccount.name`           | Name of the service account                                  | barath-user-portal-sa                     |
| `serviceAccount.iamRole`        | IAM role ARN associated with the service account             | arn:aws:iam::144360205765:role/barath-user-portal-role |
| `podAnnotations`                | Annotations to add to pods                                   | {}                                        |
| `service.type`                  | Kubernetes service type                                      | ClusterIP                                 |
| `service.port`                  | Service port                                                 | 443                                       |
| `service.targetPort`            | Target port on the pod                                       | 5000                                      |
| `ingress.enabled`               | Enable ingress resource                                      | true                                      |
| `ingress.className`             | Ingress class name                                           | alb                                       |
| `ingress.annotations`           | Annotations for ingress                                      | See `values.yaml`                         |
| `ingress.hosts`                 | List of ingress hosts and paths                              | Host empty, path `/`                      |
| `resources.limits.cpu`          | CPU limit                                                    | 500m                                      |
| `resources.limits.memory`       | Memory limit                                                 | 512Mi                                     |
| `resources.requests.cpu`        | CPU request                                                  | 200m                                      |
| `resources.requests.memory`     | Memory request                                               | 256Mi                                     |
| `livenessProbe`                 | Liveness probe configuration                                 | HTTP GET `/` on port 5000, delay 30s      |
| `readinessProbe`                | Readiness probe configuration                                | HTTP GET `/` on port 5000, delay 5s       |
| `aws.region`                    | AWS region for environment variable                          | us-east-1                              |

## Useful kubectl Commands for Troubleshooting

- List all resources in the current namespace:

```bash
kubectl get all
```

- List all pods:

```bash
kubectl get pods
```

- Describe a specific pod (replace `<pod-name>` with the actual pod name):

```bash
kubectl describe pod <pod-name>
```

- View logs of a specific pod (replace `<pod-name>` with the actual pod name):

```bash
kubectl logs <pod-name>
```

- List all services:

```bash
kubectl get services
```

- List all deployments:

```bash
kubectl get deployments
```

- List all ingress resources:

```bash
kubectl get ingress
```

- List all service accounts:

```bash
kubectl get serviceaccounts
```

- Describe a specific service account (replace `<serviceaccount-name>` with the actual name):

```bash
kubectl describe serviceaccount <serviceaccount-name>
```

> To target a specific namespace, append `-n <namespace>` to the above commands.

## Kubernetes Resources Created

- **Deployment:** Runs the Flask User Portal application with the specified number of replicas, container image, resource limits, and probes.  
- **Service:** Exposes the application internally with the specified service type and ports.  
- **Ingress:** Configures an ALB ingress with HTTPS and routing rules.  
- **ServiceAccount:** Creates a service account with an associated IAM role for AWS EKS.  

## Usage Notes

- Customize the `values.yaml` file to adjust the deployment to your environment.  
- Ensure the IAM role ARN specified in `serviceAccount.iamRole` has the necessary permissions.  
- The ingress is configured for AWS ALB with HTTPS; update the certificate ARN and other annotations as needed.  
- The application listens on port 5000 internally and is exposed on port 443 externally.