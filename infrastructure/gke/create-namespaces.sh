#!/bin/bash

NAMESPACES=("development" "testing" "production" "jenkins")

echo "Creating namespaces..."

for ns in "${NAMESPACES[@]}"; do
    kubectl create namespace "$ns" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Namespace '$ns' already exists or failed to create."
    else
      echo "namespace '$ns' created"
    fi
done

echo "Namespaces created/checked."
