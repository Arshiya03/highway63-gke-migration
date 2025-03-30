# Highway-63 Microservice Application

This directory contains the source code for the Highway-63 microservice application, designed for a low-cost cloud migration to Google Kubernetes Engine (GKE).

## Project Context

The CTO of Highway-63 has initiated a project to migrate to a microservices architecture using containers, with a focus on cost-effectiveness and dynamic scaling. This application is a component of that architecture.

## Prerequisites

* **Development Environment:**
    * Node.js and npm (or your application's specific language/framework tools).
    * Docker installed.
* **Deployment:**
    * Google Cloud SDK (`gcloud`) configured for pushing images to Google Container Registry (GCR).

## Docker Image Build and Deployment

* **Dockerfile:** The `Dockerfile` in this directory provides instructions for building the Docker image.
* **Cloud Build:** The image is automatically built and pushed to GCR using Google Cloud Build, triggered by changes to the `main` branch of this repository. The `cloudbuild.yaml` file, located in the `infrastructure/cloudbuild/` directory, defines the build steps.
* **GKE Deployment:** The resulting Docker image is deployed to GKE using Kubernetes Deployment resources, as managed by the scripts in the `infrastructure/gke/` directory.

## Local Development and Testing

For local development and testing:

1.  **Build the Docker Image:**
    ```bash
    docker build -t highway63-microservice .
    ```

2.  **Run the Container:**
    ```bash
    docker run -p 8080:8080 highway63-microservice
    ```

3. **Verify Functionality:**
    Test the application's functionality by accessing it at `http://localhost:8080`.

## CI/CD Pipeline

The application is integrated into a CI/CD pipeline using Jenkins, deployed onto the GKE cluster.

1.  **Source Code Repository:** Developers push code changes to the Google Cloud Source Repository.
2.  **Cloud Build:** A Cloud Build trigger automatically builds the Docker image and pushes it to GCR.
3.  **Jenkins Deployment:** Jenkins pulls the image from GCR and deploys it to the appropriate environment (development, testing, or production) on the GKE cluster, as defined in the `infrastructure/gke/deploy-app.sh` script.

## Notes

* **Configuration:** Adjust the `Dockerfile` and application configurations to match your specific microservice requirements.
* **Dependencies:** Ensure all necessary dependencies are included in the `package.json` file (or equivalent).
* **Port:** Confirm that the application listens on port 8080, as exposed in the `Dockerfile`.
* **Environment Variables:** If your application requires environment variables, define them in the `Dockerfile` or Kubernetes Deployment manifests.
* **Documentation:** Keep this `README.md` file up-to-date with any changes to the application or deployment process.
