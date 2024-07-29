
# Longhorn Installation and Configuration

## Overview

This document provides instructions on how to install Longhorn and configure it as the default StorageClass in your Kubernetes cluster.

## Prerequisites

- A Kubernetes cluster set up and accessible.
- `kubectl` command-line tool installed and configured.

## Step 1: Verify Existing StorageClasses

To view the existing StorageClasses in your cluster, run the following command:

```bash
kubectl get storageclass
```

**Example Output:**

```
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)          rancher.io/local-path   Delete          WaitForFirstConsumer   false                  6d1h
longhorn (default)   driver.longhorn.io      Delete          Immediate              true                   6d1h
```

## Step 2: Set Longhorn as the Default StorageClass

To make Longhorn the default StorageClass, you need to update the local-path StorageClass to no longer be the default. Use the following command:

```bash
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```

After running this command, verify that Longhorn is now set as the default StorageClass:

```bash
kubectl get storageclass
```

**Expected Output:**

```
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path          rancher.io/local-path   Delete          WaitForFirstConsumer   false                  6d1h
longhorn (default)   driver.longhorn.io      Delete          Immediate              true                   6d1h
```

## Additional Resources

For more details on configuring Longhorn as the default StorageClass, you can refer to the following link:

- [Make Longhorn the Default StorageClass](https://rpi4cluster.com/k3s-storage-setting/#make-longhorn-the-default-storageclass)

## Troubleshooting

If you encounter issues, ensure that:
- Longhorn is properly installed and running in your cluster.
- The `kubectl` context is set to the correct cluster.

Feel free to reach out for further assistance if needed.
