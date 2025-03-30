#!/bin/bash

JENKINS_NAMESPACE="jenkins"

echo "Installing Jenkins..."

helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins jenkins/jenkins -n "$JENKINS_NAMESPACE" --create-namespace

if [ $? -ne 0 ]; then
  echo "Error installing Jenkins."
  exit 1
fi

echo "Jenkins installed. Please configure it as needed."
