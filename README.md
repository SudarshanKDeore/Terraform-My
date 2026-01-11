# K8S

```
k8s/
├── namespace.yaml
├── deployment.yaml
├── service.yaml
├── ingress.yaml
└── configmap.yaml
```

## Jenkinsfile
```
pipeline {
  agent any

  environment {
    KUBECONFIG = "/var/lib/jenkins/.kube/config"
  }

  stages {

    stage("Checkout Code") {
      steps {
        git branch: 'main', url: 'https://github.com/your-repo/users-app.git'
      }
    }

    stage("Build Docker Image") {
      steps {
        sh """
        docker build -t mydockerhub/users-app:${BUILD_NUMBER} .
        docker tag mydockerhub/users-app:${BUILD_NUMBER} mydockerhub/users-app:latest
        docker push mydockerhub/users-app:${BUILD_NUMBER}
        docker push mydockerhub/users-app:latest
        """
      }
    }

    stage("Deploy to Kubernetes") {
      steps {
        sh """
        kubectl apply -f k8s/namespace.yaml
        kubectl apply -f k8s/configmap.yaml
        kubectl apply -f k8s/deployment.yaml
        kubectl apply -f k8s/service.yaml
        kubectl apply -f k8s/ingress.yaml
        """
      }
    }
  }
}
```

## Flow:
```
Jenkins
  ↓
Build Docker Image
  ↓
Push to Docker Hub
  ↓
kubectl apply all YAML files
  ↓
Pods created → Service exposes → Ingress routes traffic
```

## 
```
Kubernetes decides which cluster to deploy to by using the kubeconfig file.
kubectl always talks to the cluster defined in kubeconfig.

In Jenkins, this is controlled by:

KUBECONFIG=/path/to/kubeconfig


or by setting the correct context inside kubeconfig.

Your YAML does not decide the cluster.
kubectl decides the cluster based on kubeconfig.

Typical kubeconfig structure:

~/.kube/config


Contains:

Clusters (dev, test, prod)

Users (IAM role / token / cert)

Contexts (cluster + user + namespace mapping)

Example:

contexts:
- name: dev
  context:
    cluster: dev-cluster
    user: dev-user
    namespace: dev

- name: prod
  context:
    cluster: prod-cluster
    user: prod-user
    namespace: production


In Jenkins you do:

For DEV:

kubectl config use-context dev
kubectl apply -f k8s/


For PROD:

kubectl config use-context prod
kubectl apply -f k8s/


Now the same YAML is deployed to different clusters.

In Jenkins pipeline:

pipeline {
  agent any
  parameters {
    choice(name: 'ENV', choices: ['dev', 'staging', 'prod'], description: 'Select Environment')
  }

  stages {
    stage("Select Cluster") {
      steps {
        sh """
        kubectl config use-context ${ENV}
        kubectl get nodes
        """
      }
    }

    stage("Deploy") {
      steps {
        sh "kubectl apply -f k8s/"
      }
    }
  }
}


In AWS EKS, kubeconfig is created using:

aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster


This command:

Fetches cluster endpoint

Stores credentials

Updates kubeconfig

Each environment usually has:

dev-eks
staging-eks
prod-eks


Also namespaces separate environments inside same cluster:

metadata:
  namespace: production


So deployment is controlled by:

kubeconfig → which cluster

context → which cluster + user

namespace → which environment inside cluster

Architecture:

Jenkins
  ↓ (kubeconfig)
kubectl
  ↓
EKS Cluster (dev / staging / prod)
  ↓
Namespace (dev / staging / prod)


Interview one-liner:

Kubernetes knows where to deploy because kubectl uses kubeconfig. Jenkins switches kubeconfig context or cluster credentials, and then kubectl applies the YAML to that selected cluster and namespace.
```


