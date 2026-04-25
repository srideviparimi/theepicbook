FROM node:18-alpine AS builder
# Set working directory
WORKDIR /app
# Copy only package files first (better caching)
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy rest of the source code
COPY . .
FROM node:18-alpine
RUN apk add --no-cache curl
WORKDIR /app
# Copy only necessary files from builder
COPY --from=builder /app /app
# Expose app port (adjust if needed)
EXPOSE 3000
# Start the app
CMD ["node", "server.js"]

