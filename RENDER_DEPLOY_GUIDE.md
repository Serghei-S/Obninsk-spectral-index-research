# 🚀 Деплой AgroSky Insight на Render.com

## 📋 Подготовка

### 1. Регистрация на Render.com
- Перейдите на https://render.com
- Зарегистрируйтесь через GitHub
- Подключите ваш репозиторий

### 2. Получение Sentinel Hub API ключей
- Перейдите на https://apps.sentinel-hub.com/dashboard/
- Создайте OAuth client
- Скопируйте Client ID и Client Secret

## 🔧 Настройка Backend сервиса

### Создание Web Service
1. В Render Dashboard нажмите "New +" → "Web Service"
2. Подключите ваш GitHub репозиторий
3. Настройте сервис:

**Основные настройки:**
- **Name**: `agrosky-backend`
- **Environment**: `Python 3`
- **Region**: `Oregon (US West)`
- **Branch**: `main`
- **Root Directory**: `backend`

**Build Command:**
```bash
pip install -r requirements.txt && python migrate_db.py
```

**Start Command:**
```bash
uvicorn main:app --host 0.0.0.0 --port $PORT
```

**Environment Variables:**
```
PYTHONPATH=/opt/render/project/src/backend
ENVIRONMENT=production
SENTINEL_CLIENT_ID=ваш_client_id
SENTINEL_CLIENT_SECRET=ваш_client_secret
SENTINEL_INSTANCE_ID=ваш_instance_id (опционально)
```

**Advanced Settings:**
- **Health Check Path**: `/health`
- **Auto Deploy**: `Yes`

## 🎨 Настройка Frontend сервиса

### Создание Static Site
1. В Render Dashboard нажмите "New +" → "Static Site"
2. Подключите тот же GitHub репозиторий
3. Настройте сервис:

**Основные настройки:**
- **Name**: `agrosky-frontend`
- **Branch**: `main`
- **Root Directory**: `frontend`

**Build Command:**
```bash
npm install && npm run build
```

**Publish Directory:**
```
dist
```

**Environment Variables:**
```
VITE_API_URL=https://agrosky-backend.onrender.com
```

**Advanced Settings:**
- **Auto Deploy**: `Yes`

## 🔄 Обновление URL в Frontend

После создания backend сервиса, обновите переменную окружения frontend:

1. Перейдите в настройки frontend сервиса
2. В разделе Environment Variables
3. Обновите `VITE_API_URL` на реальный URL вашего backend:
   ```
   VITE_API_URL=https://agrosky-backend.onrender.com
   ```
4. Нажмите "Save Changes"
5. Запустите новый деплой

## 📊 Мониторинг и отладка

### Проверка логов
- **Backend**: Dashboard → agrosky-backend → Logs
- **Frontend**: Dashboard → agrosky-frontend → Logs

### Health Check
- Backend: `https://agrosky-backend.onrender.com/health`
- Frontend: `https://agrosky-frontend.onrender.com`

### API Documentation
- Swagger UI: `https://agrosky-backend.onrender.com/docs`

## 🚨 Возможные проблемы

### 1. Build ошибки
- Проверьте, что все зависимости указаны в requirements.txt
- Убедитесь, что Python версия совместима

### 2. CORS ошибки
- Проверьте настройки CORS в backend/main.py
- Убедитесь, что frontend URL добавлен в allow_origins

### 3. Переменные окружения
- Убедитесь, что все переменные окружения установлены
- Проверьте правильность Sentinel Hub credentials

### 4. Database ошибки
- SQLite файл создается автоматически
- Проверьте права доступа к файловой системе

## 💰 Стоимость

**Free план включает:**
- 750 часов работы в месяц
- Автоматическое засыпание после 15 минут неактивности
- Пробуждение по первому запросу (занимает ~30 секунд)

**Для production рекомендуется:**
- Starter план ($7/месяц) для backend
- Static Site остается бесплатным

## 🔗 Полезные ссылки

- [Render.com Documentation](https://render.com/docs)
- [FastAPI Deployment](https://fastapi.tiangolo.com/deployment/)
- [Vite Build Configuration](https://vitejs.dev/guide/build.html)
- [Sentinel Hub API](https://docs.sentinel-hub.com/api/)

## ✅ Финальная проверка

После деплоя проверьте:
1. ✅ Backend доступен по https://agrosky-backend.onrender.com
2. ✅ Frontend доступен по https://agrosky-frontend.onrender.com  
3. ✅ API документация работает
4. ✅ Health check возвращает 200 OK
5. ✅ Frontend может обращаться к backend API
6. ✅ Sentinel Hub API работает (проверьте логи)

---

**🎉 Поздравляем! Ваш AgroSky Insight успешно развернут на Render.com!**
