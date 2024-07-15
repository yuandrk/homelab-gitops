# Home Lab

This repository contains all configurations and documentation for my home lab.

## Web accessible 

- [Grafana](grafana.yuandrk.net)
- [Weave GitOps](https://weave.yuandrk.net/)
- [NextCloud](https://nextcloud.com/)


## Tooling

- [k3s](https://docs.k3s.io/) - Lightweight Kubernetes distribution.
- [Flux](https://fluxcd.io/) - GitOps tool for Kubernetes.

## Goals

- **Monitoring Stack**: Deploy Prometheus and Grafana for monitoring services.
- **Project Hosting**:
  - [Teledoist](https://github.com/yuandrk/teledoist) - A personal project.
  - [Weawe](https://gitops.weave.works/) - Weave GitOps is a powerful extension to Flux, a leading GitOps engine and CNCF project.
  - [Jellyfin](https://jellyfin.org/) - media server 
  - [OpenWeb](https://openwebui.com/) - A project aimed at open web interfaces.
  - [Actualbudget](https://actualbudget.org/) - Actual Budget is a super fast and privacy-focused app for managing your finances.
    - Ensure services are accessible via URLs using:
      - Ingress
      - TLS encryption
      - DNS configuration with AWS Route 53
- **Deployment Strategy**:
  - Utilize Flux for GitOps.
  - Implement a solution for managing secrets securely.

## Todo

- [x] Install Flux.
- [x] Configure Terraform.
- [x] AWS Route53.
- [ ] Custom dashboard for Grafana 
- [ ] Backup for Actualbudget 
- [ ] NFS Volume for jellyfin 
- [ ] Store secrets in AWS Secrets.
- [ ] Implement SOPS for secret management.
- [ ] [cilium](https://artifacthub.io/packages/helm/cilium/cilium)

## Using k3s

K3s provides a streamlined Kubernetes experience, which is ideal for personal labs where simplicity and quick setup are prioritized over the comprehensive configuration offered by tools like kubeadm. This approach allows me to focus on learning about deploying and maintaining infrastructure in a lightweight and enjoyable manner.

## Sources

- [Flux Monitoring Stack](https://github.com/fluxcd/flux2-monitoring-example/blob/main/README.md)
- [OpenWeb GitHub Repository](https://github.com/open-webui/open-webui)
- [Grafana](https://grafana.com/)
- [Prometheus](https://prometheus.io/)

### Inspiration

Inspired by [Mischa van den Burg](https://www.youtube.com/@mischavandenburg), whose resources have guided the setup and goals of this lab.

## Log


### 2024-08-03

- set up cert manager ß

### 2024-07-21

- Set up k3s on the master node and worker node.
- Established the repository and added initial installation documentation.

### 2024-07-24

- Deployed the monitoring stack.
- Updated the Flux module to version 1.3.0.