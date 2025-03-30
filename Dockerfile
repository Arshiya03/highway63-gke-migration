# Assuming your Highway-63 app is a Node.js microservice
FROM node:18-alpine

WORKDIR /app

# Copy only package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD [ "npm", "start" ]

# Notes:
# - Adjust the base image (FROM) if your application uses a different language/framework.
# - Ensure your application listens on port 8080.
# - If your application requires specific environment variables, add them using ENV.
