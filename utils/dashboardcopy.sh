#!/bin/bash
# Script to copy dashboards as JSON files to the Grafana pod
# The path is the mount point of the persistent volume defined in the Helm install

# Function to prompt for input if not provided as an argument
prompt_for_input() {
    local var_name=$1
    local prompt_message=$2
    local default_value=$3

    if [ -z "${!var_name}" ]; then
        read -p "$prompt_message" input
        if [ -z "$input" ]; then
            eval "$var_name=$default_value"
        else
            eval "$var_name=$input"
        fi
    fi
}

# Get podname and path from arguments or prompt the user
podname=$1
path=$2

prompt_for_input podname "Enter the pod name: " "default-podname"
prompt_for_input path "Enter the path to the JSON files: " "./standard-dashboards"

echo "Pod name: $podname"
echo "Path: $path"

# Copy JSON files to t he Grafana pod
for file in "$path"/*.json; do
    kubectl cp "$file" monitoring/"$podname":/var/lib/grafana/dashboards/default
done

echo "Dashboard files have been copied to the Grafana pod."   