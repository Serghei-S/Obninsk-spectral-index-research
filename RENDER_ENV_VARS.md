# Environment Variables для Render.com

## Backend Service Variables

### Обязательные переменные:
```
PYTHONPATH=/opt/render/project/src/backend
ENVIRONMENT=production
```

### Sentinel Hub API (для реальных данных):
```
SENTINEL_CLIENT_ID=e6753813-f4e6-41dd-887f-1c0a78c8ce88
SENTINEL_CLIENT_SECRET=QZSOjOPB0h2kaP4kCK5MeSDW1DpKfaKg
SENTINEL_INSTANCE_ID=
```

### Опциональные переменные:
```
LOG_LEVEL=INFO
DEBUG=false
```

## Frontend Service Variables

### Обязательные переменные:
```
VITE_API_URL=https://agrosky-backend.onrender.com
```

### Опциональные переменные:
```
VITE_APP_NAME=AgroSky Insight
VITE_APP_VERSION=1.0.0
```

## Как добавить переменные в Render:

1. Перейдите в Dashboard вашего сервиса
2. Откройте раздел "Environment"
3. Добавьте каждую переменную:
   - **Key**: имя переменной
   - **Value**: значение переменной
   - **Sync**: false (для секретных данных)

## Важные замечания:

- 🔒 **SENTINEL_CLIENT_SECRET** - секретный ключ, установите Sync: false
- 🌐 **VITE_API_URL** - должен указывать на ваш реальный backend URL
- 🔄 После изменения переменных перезапустите сервис
- 📝 Все переменные с префиксом VITE_ доступны в frontend коде
