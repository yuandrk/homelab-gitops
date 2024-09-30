provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config_s"
  }
  git = {
    url  = "https://github.com/${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}.git"
    http = {
      username    = "git"
      password    = var.GITHUB_TOKEN
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = "./clusters"
}

resource "null_resource" "github_repository" {
  count = var.create_repository ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
      terraform init -from-module=git::https://github.com/den-vasyliev/tf-github-repository.git
      terraform apply -var='github_owner=${var.GITHUB_OWNER}' -var='github_token=${var.GITHUB_TOKEN}' -var='repository_name=${var.FLUX_GITHUB_REPO}' -var='public_key_openssh=${module.tls_private_key.public_key_openssh}' -var='public_key_openssh_title=flux'
    EOT
  }
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    flux = {
      source = "fluxcd/flux"
      version = "1.4.0"
    }
  }
}