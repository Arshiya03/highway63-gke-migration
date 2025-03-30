# Highway-63 GKE Infrastructure Setup

This folder contains the infrastructure-as-code (IaC) scripts and configurations for deploying Highway-63's microservices architecture on Google Kubernetes Engine (GKE).

## Project Overview

The CTO of Highway-63 has requested a low-cost cloud migration to a microservices architecture using containers. This setup provisions limited compute resources for cost-effectiveness and ensures dynamic scaling for both the application and the underlying infrastructure.

The project includes:

* A GKE cluster with node autoscaling.
* Separate namespaces for development, testing, and production environments.
* Application deployment using Kubernetes Deployments.
* Publicly accessible application via a Kubernetes LoadBalancer Service.
* Jenkins installation for CI/CD.
* Integration with Google Cloud Source Repositories and Container Registry.
* Cloud Monitoring dashboards for pod status and other metrics.

## Prerequisites

Before running the scripts, ensure you have the following:

* A Google Cloud Platform (GCP) project.
* `gcloud` CLI installed and configured.
* `kubectl` installed and configured.
* Helm installed.
* A GCP service account with the necessary permissions (Kubernetes Engine Admin, Cloud Build Editor, Monitoring Editor, etc.).
* The service account's JSON key stored as a GitHub Secret named `GCP_SA_KEY`.
* Your GCP Project ID stored as a GitHub Secret named `GCP_PROJECT_ID`.
* A Google Cloud Source Repository created for your application code.
* A Google Cloud Container Registry or Artifact Registry enabled.
* A Google Cloud Monitoring notification channel created.

## Scripts and Configurations

This folder contains the following scripts and configurations:

* **`gke/create-gke-cluster.sh`:** Creates the GKE cluster with node autoscaling enabled.
* **`gke/create-namespaces.sh`:** Creates the development, testing, production, and Jenkins namespaces.
* **`gke/deploy-app.sh`:** Deploys the application using Kubernetes Deployments and creates a LoadBalancer Service.
* **`gke/install-jenkins.sh`:** Installs Jenkins in the GKE cluster.
* **`gke/hpa-deployment.yaml`:** Defines the Horizontal Pod Autoscaler (HPA) for application scaling.
* **`gke/service-prod.yaml`:** Defines the LoadBalancer Service for production.
* **`monitoring/create-monitoring-alert.sh`:** Creates a Cloud Monitoring alert for high CPU usage.
* **`cloudbuild/cloudbuild.yaml`:** (This file should be placed in `application/` folder) Defines the Cloud Build steps for building and pushing the application image.

## Deployment Steps

1.  **Clone the Repository:**
    ```bash
    git clone <your-repository-url>
    cd highway63-gke-migration/infrastructure
    ```

2.  **Set up GCP Credentials:**
    * Ensure your GitHub Actions workflow has access to the `GCP_SA_KEY` and `GCP_PROJECT_ID` secrets.

3.  **Create GKE Cluster:**
    ```bash
    bash gke/create-gke-cluster.sh
    ```

4.  **Create Namespaces:**
    ```bash
    bash gke/create-namespaces.sh
    ```

5.  **Deploy Application:**
    * Ensure your `deployment-dev.yaml`, `deployment-test.yaml`, `deployment-prod.yaml`, and `service-prod.yaml` files are correctly configured and placed in the `gke/` directory.
    ```bash
    bash gke/deploy-app.sh
    ```

6.  **Install Jenkins:**
    ```bash
    bash gke/install-jenkins.sh
    ```
    * Follow the Jenkins installation instructions to configure it.

7.  **Set Up Cloud Build Trigger:**
    * Create a Cloud Build trigger in your GCP project that is linked to your GitHub repository.
    * Configure the trigger to build and push the Docker image when changes are pushed to the `main` branch.

8.  **Set Up Monitoring Alert:**
    * Replace `your-notification-channel-id` in `monitoring/create-monitoring-alert.sh` with your actual notification channel ID.
    ```bash
    bash monitoring/create-monitoring-alert.sh
    ```

9.  **Configure HPA:**
    * Adjust the `hpa-deployment.yaml` file as needed.

## GitHub Actions Workflow

The included GitHub Actions workflow (`.github/workflows/deploy-gke.yaml`) automates the deployment process. Ensure it is configured correctly with your GCP credentials.

## Application Deployment and CI/CD

* Application code should be pushed to the Google Cloud Source Repository.
* Cloud Build will automatically build and push the Docker image to the Container Registry.
* Jenkins will handle further CI/CD processes, such as testing and deployment to different environments.

## Monitoring

* Cloud Monitoring dashboards and alerts will help you monitor the health and performance of your application and infrastructure.

## Notes

* Adjust the scripts and configurations to fit your specific application requirements.
* Ensure that your GCP service account has the necessary permissions.
* Keep your documentation up-to-date.
