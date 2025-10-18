# ✅ Чек-лист деплоя на Render.com

## 📁 Созданные файлы для деплоя:

- ✅ `backend/Dockerfile.prod` - Production Dockerfile для backend
- ✅ `frontend/Dockerfile.prod` - Production Dockerfile для frontend  
- ✅ `frontend/nginx.conf` - Nginx конфигурация
- ✅ `render.yaml` - Автоматическая конфигурация Render
- ✅ `RENDER_DEPLOY_GUIDE.md` - Подробная инструкция
- ✅ `RENDER_QUICK_START.md` - Быстрый старт
- ✅ `RENDER_ENV_VARS.md` - Переменные окружения
- ✅ `RENDER_BACKEND_CONFIG.md` - Конфигурация backend
- ✅ `RENDER_FRONTEND_CONFIG.md` - Конфигурация frontend

## 🔧 Обновленные файлы:

- ✅ `frontend/vite.config.js` - Добавлена production конфигурация
- ✅ `backend/main.py` - Обновлены CORS настройки для production

## 🚀 Следующие шаги:

### 1. Закоммитьте изменения:
```bash
git add .
git commit -m "Add Render.com deployment configuration"
git push origin main
```

### 2. Создайте сервисы на Render.com:

**Backend (Web Service):**
- Name: `agrosky-backend`
- Environment: `Python 3`
- Root Directory: `backend`
- Build Command: `pip install -r requirements.txt && python migrate_db.py`
- Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`

**Frontend (Static Site):**
- Name: `agrosky-frontend`
- Root Directory: `frontend`
- Build Command: `npm install && npm run build`
- Publish Directory: `dist`

### 3. Настройте переменные окружения:

**Backend Environment Variables:**
```
SENTINEL_CLIENT_ID=e6753813-f4e6-41dd-887f-1c0a78c8ce88
SENTINEL_CLIENT_SECRET=QZSOjOPB0h2kaP4kCK5MeSDW1DpKfaKg
ENVIRONMENT=production
```

**Frontend Environment Variables:**
```
VITE_API_URL=https://agrosky-backend.onrender.com
```

### 4. Проверьте деплой:
- ✅ Backend доступен: `https://agrosky-backend.onrender.com/health`
- ✅ Frontend доступен: `https://agrosky-frontend.onrender.com`
- ✅ API документация: `https://agrosky-backend.onrender.com/docs`

## 📊 Мониторинг:

- **Логи**: Dashboard → Service → Logs
- **Метрики**: Dashboard → Service → Metrics
- **Health Check**: `/health` endpoint

## 🔄 Обновления:

После каждого push в main ветку:
- Backend автоматически пересоберется и перезапустится
- Frontend автоматически пересоберется и обновится

## 💡 Советы:

1. **Free план**: Сервисы засыпают после 15 мин неактивности
2. **Пробуждение**: Занимает ~30 секунд при первом запросе
3. **Логи**: Всегда проверяйте логи при проблемах
4. **Переменные**: Не забывайте обновить VITE_API_URL после создания backend

---

**🎉 Ваш AgroSky Insight готов к деплою на Render.com!**
