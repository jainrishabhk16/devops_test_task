# Base image
FROM node:latest AS base

# Set working directory
WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application source code
COPY . .


# Multi-stage for different environments #
# Development stage
FROM base AS development

# Install dev dependencies
RUN npm install --only=development

# Set environment variables for development
ENV NODE_ENV=development

# Expose the development port (if required, adjust as needed)
EXPOSE 8125

CMD ["node", "index.js"]

# UAT stage
FROM base AS uat

# Set environment variables for UAT
ENV NODE_ENV=uat

# Expose the UAT port (adjust if needed)
EXPOSE 8125

CMD ["node", "index.js"]

# Production stage
FROM base AS production

# Set environment variables for production
ENV NODE_ENV=production

# Expose the production port (adjust if needed)
EXPOSE 8125

CMD ["node", "index.js"]
