
# Homelab Maintenance Scripts

This directory contains various scripts and utilities to help maintain and manage your homelab environment. These scripts automate common tasks, streamline processes, and ensure consistency across your homelab infrastructure.

## Usage

Each script in this directory is designed to perform a specific task or set of tasks related to homelab maintenance. Before running any script, make sure to review its purpose, requirements, and any necessary configurations or dependencies.

To run a script, navigate to this directory in your terminal and execute the script with the appropriate command (e.g., `bash script_name.sh`).

## Available Scripts

Here's a brief overview of the scripts available in this directory:

1. **configmapcollector.sh**: This script is designed to collect and save Grafana dashboard JSON files from ConfigMaps in a Kubernetes cluster. It performs the following steps:

   - Sets the namespace to `prometheus-stack` by default, but you can modify this if your ConfigMaps are in a different namespace.
   - Retrieves a list of ConfigMap names in the specified namespace.
   - For each ConfigMap, it retrieves the ConfigMap data in JSON format.
   - Extracts the keys from the `data` section of the ConfigMap that end with `.json`, which are likely to represent Grafana dashboard JSON files.
   - If there are no keys ending with `.json`, it skips to the next ConfigMap.
   - For each key ending with `.json`, it extracts the corresponding JSON value from the `data` section of the ConfigMap.
   - Sorts the extracted JSON value to ensure a consistent order of the JSON properties.
   - Saves the sorted JSON value to a file with the same name as the key, effectively creating a separate file for each Grafana dashboard JSON file found in the ConfigMap.

   This script can be useful in scenarios where you have Grafana dashboards stored as JSON files in ConfigMaps, and you need to extract and save them locally for backup, modification, or other purposes.

## Contributing

If you have developed a useful script or utility for homelab maintenance, feel free to contribute to this repository. Follow the standard GitHub workflow for creating a pull request, and make sure to document your script's purpose, usage, and any dependencies or requirements.

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute these scripts as per the terms of the license.

## Disclaimer

Use these scripts at your own risk. While every effort has been made to ensure their safety and reliability, the authors and contributors are not responsible for any unintended consequences or data loss resulting from the use of these scripts.
