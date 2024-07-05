provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
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


module "github_repository"  {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
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
      version = "1.3.0"
    }
  }
}