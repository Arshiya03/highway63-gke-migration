#!/bin/bash

# Configuration Variables
PROJECT_ID="${GCP_PROJECT_ID:-your-gcp-project-id}" # Use env var or default
CLUSTER_NAME="highway63-cluster"
ZONE="us-central1-a" # Adjust as needed
MIN_NODES=1
MAX_NODES=3
MACHINE_TYPE="e2-medium" # Adjust as needed

echo "Setting up GKE cluster..."

gcloud container clusters create "$CLUSTER_NAME" \
    --zone="$ZONE" \
    --machine-type="$MACHINE_TYPE" \
    --num-nodes="$MIN_NODES" \
    --enable-autoscaling \
    --min-nodes="$MIN_NODES" \
    --max-nodes="$MAX_NODES" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Error creating GKE cluster."
  exit 1
fi

echo "GKE cluster '$CLUSTER_NAME' created."
