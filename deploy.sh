#!/bin/bash

# Deployment script for SlideShare Conversion Server
# Usage: ./deploy.sh

echo "🚀 Deploying SlideShare Conversion Server..."

# Build Docker image
echo "📦 Building Docker image..."
docker build -t slidesdown-converter .

# Stop existing container if running
echo "🛑 Stopping existing container..."
docker stop slidesdown-converter 2>/dev/null || true
docker rm slidesdown-converter 2>/dev/null || true

# Run new container
echo "▶️ Starting new container..."
docker run -d \
  --name slidesdown-converter \
  --restart unless-stopped \
  -p 5000:5000 \
  slidesdown-converter

echo "✅ Deployment complete!"
echo "🌐 Server running at http://localhost:5000"
echo "❤️ Health check: http://localhost:5000/health"

# Show logs
echo "📋 Container logs:"
docker logs -f slidesdown-converter
