#!/bin/bash

PROJECT_ID="${GCP_PROJECT_ID:-your-gcp-project-id}"
NOTIFICATION_CHANNEL="your-notification-channel-id" # Replace!

echo "Setting up monitoring alert..."

gcloud monitoring policies create --display-name="High CPU Usage" \
  --condition-resource-keys="resource.type=k8s_container" \
  --condition-filter="metric.type=\"kubernetes.io/container/cpu/usage_time\" AND resource.namespace_name=\"production\"" \
  --condition-threshold-value="0.8" \
  --condition-comparison="COMPARISON_GT" \
  --notification-channels="$NOTIFICATION_CHANNEL" \
  --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Error creating monitoring alert."
  exit 1
fi

echo "Monitoring alert created."
