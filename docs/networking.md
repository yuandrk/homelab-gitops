# Newtworking

## Grafana

Exposing the Grafana service as a Loadbalancer. Edit the service and change to type LoadBalancer and use the following configuration:

``` yaml

  ports:
  - name: http-web
    nodePort: 30181
    port: 3000
    protocol: TCP
    targetPort: 3000

```

Now Grafana UI is accessible using the IP of the control controlplane and port 3000  
