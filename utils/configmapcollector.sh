#!/bin/bash
# collects grafana dashboard json files from config maps

# Set the namespace if required, or use default
NAMESPACE="monitoring"

# Get list of ConfigMap names
CONFIGMAPS=$(kubectl get configmap -n "$NAMESPACE" -o jsonpath='{.items[*].metadata.name}')

# Iterate through each ConfigMap
for cm in $CONFIGMAPS; do
	# Get the ConfigMap data
	DATA=$(kubectl get configmap "$cm" -n "$NAMESPACE" -o json)

	# Extract keys from the data section that end with .json
	KEYS=$(echo "$DATA" | jq -r '.data | keys[] | select(endswith(".json"))')

	# Check if there are any .json keys
	if [ -z "$KEYS" ]; then
		echo "No .json data in ConfigMap $cm"
		continue
	fi

	# Iterate over each .json key
	for key in $KEYS; do
		# Extract the JSON value of the key
		JSON_VALUE=$(echo "$DATA" | jq -r --arg KEY "$key" '.data[$KEY]')

		# Sort the JSON value
		SORTED_JSON=$(echo "$JSON_VALUE" | jq -S .)

		# Check if jq sorted the data successfully
		if [ $? -ne 0 ]; then
			echo "Error sorting JSON data for key $key in ConfigMap $cm"
			continue
		fi

		# Save to file named after the key
		echo "$SORTED_JSON" >"$key"
		echo "Saved key $key of ConfigMap $cm to $key"
	done
done