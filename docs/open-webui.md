# Open-Web Deployment

This section covers setting up a local Large Language Model (LLM) on a powerful device within your infrastructure, focusing on nodes equipped with SSDs for optimal performance.

## Preparing Your Node

Before deploying the LLM, ensure that your most capable node is correctly labeled to indicate it has an SSD. This label will be used to target the deployment specifically to this node.

```bash
kubectl label nodes <node-name> disktype=ssd
```

Replace <node-name> with the actual name of the node you want to label. This step is crucial for the node selector in the deployment configuration to function correctly.

## Configuring Deployment

Once the node is labeled, modify the deployment configuration to specifically target this node. This is done by adding a nodeSelector field to your deployment’s values file, which ensures that the LLM only deploys on nodes labeled with disktype: ssd. 

``` yaml 
nodeSelector:
  disktype: ssd
```

kubectl create secret generic openai-api-key --from-literal=api-key="my-base64-encoded-api-key" -n "YOUR_NAMESPACE"
```