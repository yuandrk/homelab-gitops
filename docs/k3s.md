# K3s

Decided to use k3s for installing Kubernetes

## Installing K3s

Just used the docs. Following link `https://docs.k3s.io`

Struggled a bit with the error `k3s: The connection to the server localost:8080 was refused - did you specify the right host or port?`.

Problem was a faulty kubeconfig configuration
Fixed using with below command

``` bash
mkdir ~/.kube
sudo k3s kubectl config view --raw | tee ~/.kube/config
chmod 600 ~/.kube/config
```

And then add variable `export KUBECONFIG=~/.kube/config` to env

# K3s - Lightweight Kubernetes

## Introduction

This document outlines the process of installing K3s, a lightweight and easy-to-install Kubernetes distribution, ideal for edge, IoT, and CI/CD environments.

## Prerequisites

- Ensure that you have administrative access to the host machine.
- Familiarity with basic Linux commands and environments is recommended.

## Installation of K3s

K3s simplifies the setup of a Kubernetes cluster. Follow the instructions from the official K3s documentation:

- **Documentation Link:** [K3s Official Documentation](https://docs.k3s.io)

### Common Installation Issue

During the installation, you might encounter an error related to the Kubernetes connection:

`k3s: The connection to the server localhost:8080 was refused - did you specify the right host or port?`

This error typically indicates a misconfiguration in the kubeconfig file.

### Resolving the Kubeconfig Error

Follow these steps to correct the kubeconfig file:

1. **Create a `.kube` directory in your home:**

   ```bash
   mkdir ~/.kube

2. **Extract and save the correct kubeconfig settings:**

   ```bash
   sudo k3s kubectl config view --raw | tee ~/.kube/config

3. **Set the correct file permissions:**

   ``` bash
   chmod 600 ~/.kube/config

4. **Configure the KUBECONFIG environment variable: Add the following line to your shell configuration file (e.g., .bashrc, .zshrc):**

   ``` bash
   export KUBECONFIG=~/.kube/config

### Adding an Additional Node to K3s Cluster

#### Step 1: Obtain the Token from the Master Node

To add a new worker node to your cluster, first retrieve the token from your master node with the following command:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

#### Install K3s Agent on the Worker Node

Using the token obtained from the master node, run the following command on your worker node to install the K3s agent:

``` bash
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -
```

Replace <https://myserver:6443> with the URL of your master node and mynodetoken with the actual token you obtained in the previous step.

### Setting Up Remote Access

To remotely access the master node, you must configure it to recognize your public IP or DNS:

``` bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san <your-public-ip-or-dns>" sh -
```

Replace `<your-public-ip-or-dns>` with your actual public IP address or a DNS name that resolves to it. This adjustment in the installation command ensures that the TLS certificate generated for the Kubernetes API server includes this IP or DNS as a valid endpoint, enabling secure connections over the internet.
