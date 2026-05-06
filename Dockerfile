# ============================================
# STAGE 1: Build Stage (named "builder")
# ============================================
# This stage installs ALL dependencies (including devDependencies)
# and prepares the application. It will be DISCARDED in the final image.
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package files first (for better layer caching)
COPY package*.json ./

# Install ALL dependencies (including devDependencies like nodemon)
# These are needed during the build process but NOT in production
RUN npm install

# Copy the rest of the application source code
COPY . .

# ============================================
# STAGE 2: Production Stage (final image)
# ============================================
# Start fresh from a clean, small base image.
# Nothing from Stage 1 is carried over unless we explicitly COPY it.
FROM node:18-alpine AS production

# Set the working directory
WORKDIR /app

# Copy ONLY the package files
COPY package*.json ./

# Install ONLY production dependencies (skip devDependencies like nodemon)
# The --omit=dev flag ensures devDependencies are NOT installed
RUN npm install --omit=dev

# Copy the application code from the builder stage
# --from=builder means "copy from Stage 1", NOT from your local machine
COPY --from=builder /app/server.js ./

# Expose the port your app runs on
EXPOSE 5000

# Define the command to run the app in production
CMD [ "node", "server.js" ]
