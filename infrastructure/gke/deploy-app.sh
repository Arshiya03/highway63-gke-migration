#!/bin/bash

APP_NAMESPACE_DEV="development"
APP_NAMESPACE_TEST="testing"
APP_NAMESPACE_PROD="production"

echo "Deploying application..."

kubectl apply -f deployment-dev.yaml -n "$APP_NAMESPACE_DEV"
if [ $? -ne 0 ]; then
  echo "Error deploying deployment-dev.yaml"
  exit 1;
fi

kubectl apply -f deployment-test.yaml -n "$APP_NAMESPACE_TEST"
if [ $? -ne 0 ]; then
  echo "Error deploying deployment-test.yaml"
  exit 1;
fi

kubectl apply -f deployment-prod.yaml -n "$APP_NAMESPACE_PROD"
if [ $? -ne 0 ]; then
  echo "Error deploying deployment-prod.yaml"
  exit 1;
fi

kubectl apply -f service-prod.yaml -n "$APP_NAMESPACE_PROD"
if [ $? -ne 0 ]; then
  echo "Error deploying service-prod.yaml"
  exit 1;
fi

echo "Application deployed."
