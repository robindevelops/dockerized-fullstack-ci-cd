# Stage 1: Build & Dependencies
FROM node:20-alpine AS builder

WORKDIR /app

# Only copy files needed for install to leverage Docker cache
COPY package*.json ./
# Install ALL dependencies (including dev ones for building if needed)
RUN npm install

COPY . .

# Stage 2: Production Run
FROM node:20-alpine

WORKDIR /app

USER node

# Copy only the necessary files from the builder stage
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app .

EXPOSE 5000

# Use tini or a similar init tool if your app handles signals (optional but good)
CMD ["node", "server.js"]