# SlideShare Conversion Server

A Python-based server for converting SlideShare images to PDF, PowerPoint, and ZIP formats.

## 🚀 Quick Setup

### Option 1: Docker (Recommended)

1. Navigate to the server directory:
```bash
cd python-conversion-server
```

2. Make the deploy script executable:
```bash
chmod +x deploy.sh
```

3. Run the deployment:
```bash
./deploy.sh
```

### Option 2: Manual Setup

1. Install Python 3.11+ and pip

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run the server:
```bash
python app.py
```

## 🌐 Production Deployment

For production deployment to `https://convert.slidesdown.com`:

1. Set up a VPS or cloud server
2. Install Docker
3. Clone this repository
4. Run the deployment script
5. Configure nginx as reverse proxy:

```nginx
server {
    listen 80;
    server_name convert.slidesdown.com;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 300;
        proxy_connect_timeout 300;
    }
}
```

6. Set up SSL with Let's Encrypt:
```bash
sudo certbot --nginx -d convert.slidesdown.com
```

## 📋 API Endpoints

### POST /convert
Convert images to specified format.

**Request Body:**
```json
{
  "images": ["url1", "url2", "..."],
  "title": "Presentation Title",
  "format": "pdf|ppt|zip"
}
```

**Response:**
- Success: File download with appropriate headers
- Error: JSON with error message

### GET /health
Health check endpoint.

**Response:**
```json
{
  "status": "healthy",
  "service": "slidesdown-converter"
}
```

## 🔧 Environment Variables

- `PORT`: Server port (default: 5000)
- `WORKERS`: Number of Gunicorn workers (default: 4)
- `TIMEOUT`: Request timeout in seconds (default: 120)

## 📝 Features

- ✅ PDF conversion with original image dimensions
- ✅ PowerPoint (.pptx) conversion with full-slide images
- ✅ ZIP creation with organized image files
- ✅ Mobile-friendly downloads with proper MIME types
- ✅ Error handling and logging
- ✅ Docker support for easy deployment
- ✅ Health check endpoint for monitoring

## 🛠️ Troubleshooting

### Common Issues

1. **Images not downloading**: Check if the server can access external URLs
2. **PDF creation fails**: Ensure sufficient disk space and memory
3. **PowerPoint issues**: Verify python-pptx library installation
4. **Timeout errors**: Increase the timeout value for large presentations

### Logs

Check Docker logs:
```bash
docker logs slidesdown-converter
```

### Testing

Test the server locally:
```bash
curl -X POST http://localhost:5000/convert \
  -H "Content-Type: application/json" \
  -d '{"images":["https://example.com/image.jpg"],"title":"test","format":"pdf"}' \
  --output test.pdf
```
