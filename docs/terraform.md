# Terraform Project Guide

## Prerequisites

Before you start, make sure to install Flux on your machine as it is essential for the automation and configuration of your Kubernetes cluster using GitOps principles.

## Setting Up Your Terraform Project

### Step 1: GitHub Token Creation

To interact with your GitHub repositories, you need to generate a proper token. Follow these steps:

1. **Go to your GitHub account settings.**
2. Navigate to **Developer settings**.
3. Click on **Personal access tokens**.
4. Click **Generate new token**.
5. Select the appropriate scopes or permissions based on what actions Terraform will perform.
6. Click **Generate token**.
7. **Save the token** securely as GitHub will not show the token again after the window is closed.

### Step 2: Initialize Terraform

Run the following command in your project directory to initialize Terraform, which will download necessary providers and set up the environment.

```bash
terraform init
```

### Step 3: Secure Sensitive Data

``` yaml 
# Example of .gitignore entries for Terraform
.terraform/
*.tfstate
*.tfvars
```

### Step 4: Deploy infrastructure 
``` bash 
$ tf apply -var-file=env.tfvars
```

