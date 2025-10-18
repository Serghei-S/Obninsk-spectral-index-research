# Backend Service Configuration for Render.com
# Service Type: Web Service
# Environment: Python 3.11
# Plan: Free

# Build Command:
pip install -r requirements.txt && python migrate_db.py

# Start Command:
uvicorn main:app --host 0.0.0.0 --port $PORT

# Environment Variables:
# PYTHONPATH: /opt/render/project/src/backend
# ENVIRONMENT: production
# SENTINEL_CLIENT_ID: [your_client_id]
# SENTINEL_CLIENT_SECRET: [your_client_secret]
# SENTINEL_INSTANCE_ID: [your_instance_id] (optional)

# Health Check Path:
# /health

# Auto Deploy: Yes (from main branch)
