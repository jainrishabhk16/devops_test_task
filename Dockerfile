# Base image
FROM node:latest AS base

# Set working directory
WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install --production

# copy env file
COPY .env ./

# Set environment variables for development
# ENV NODE_ENV=development

# Copy application source code
COPY . .

EXPOSE 8125

CMD ["node", "index.js"]
