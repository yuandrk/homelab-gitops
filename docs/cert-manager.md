# TLS Certificate Issuance for Web Pages

This guide details the steps to issue a TLS certificate using Let’s Encrypt with DNS validation through Amazon Route53 for the domain `yuandrk.net`.

## Registering the Domain

Ensure your domain `yuandrk.net` is registered and managed via Amazon Route53 to facilitate DNS challenges required by Let’s Encrypt.

## Setup Issuer Using Cert-Manager and Amazon Route53

### Preparations

Before proceeding, make sure the `cert-manager` is installed in your Kubernetes cluster. Cert-manager will handle the automation of certificate issuance and renewal.

### Step 1: Create IAM Policy for cert-manager

Cert-manager requires permissions to modify Route53 in order to complete DNS challenges. Below is the necessary IAM policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "route53:GetChange",
      "Resource": "arn:aws:route53:::change/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ChangeResourceRecordSets",
      "Resource": "arn:aws:route53:::hostedzone/*"
    },
    {
      "Effect": "Allow",
      "Action": "route53:ListHostedZonesByName",
      "Resource": "*"
    }
  ]
}
```

### Step 2: Create Secret for AWS Credentials

Store the AWS credentials in a Kubernetes secret to be used by cert-manager. Replace the secret-access-key value with your actual AWS secret access key.

``` bash
kubectl create secret generic route53-secret --from-literal=secret-access-key="YOUR_AWS_SECRET_ACCESS_KEY" -n "YOUR_NAMESPACE"
```

### Step 3: Create a Let’s Encrypt Issuer

Set up a Let’s Encrypt issuer to validate and issue the certificates. Start with a staging environment to ensure everything is configured correctly before moving to production.

``` yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
      - dns01:
          route53:
            region: eu-west-2
            accessKeyID: YOUR_AWS_ACCESS_KEY_ID
            hostedZoneID: YOUR_HOSTED_ZONE_ID
            secretAccessKeySecretRef:
              name: route53-secret
              key: secret-access-key
```

### Step 4: Configure Helm Chart Values for Flux

Update the values in your Helm chart for the application you want to secure, e.g., Grafana. Initially, use the staging issuer to avoid hitting rate limits.

``` yaml
values: 
  grafana:
    ingress:
      enabled: true
      ingressClassName: traefik
      annotations:
        cert-manager.io/cluster-issuer: "letsencrypt-staging"
      tls:
        - hosts:
            - grafana.yuandrk.net
          secretName: grafana-ingress-staging
```

**Transition to Production**

Once verified with staging, switch the issuer to the production one by updating the annotations in your Helm chart values:

``` yaml
values:
  grafana:
    ingress:
      enabled: true
      ingressClassName: traefik
      annotations:
        cert-manager.io/cluster-issuer: "letsencrypt-prod"
      tls:
        - hosts:
            - grafana.yuandrk.net
          secretName: grafana-ingress-prod
```

#### Resources

For more detailed guidance:

- [Cert-manager Route53 DNS01 Challenge Tutorial](https://voyagermesh.com/docs/v2024.3.18/guides/cert-manager/dns01_challenge/aws-route53/)
- [Getting Started with Cert-manager on GKE using Let’s Encrypt](https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/#7-create-an-issuer-for-lets-encrypt-staging)

ß
