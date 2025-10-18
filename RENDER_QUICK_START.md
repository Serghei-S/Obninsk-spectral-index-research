# ⚡ Быстрый деплой на Render.com

## 🚀 За 5 минут

### 1. Подготовка (1 мин)
```bash
# Убедитесь, что код закоммичен в GitHub
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### 2. Создание Backend (2 мин)
1. Откройте https://render.com/dashboard
2. "New +" → "Web Service"
3. Подключите репозиторий
4. Настройки:
   - **Name**: `agrosky-backend`
   - **Environment**: `Python 3`
   - **Root Directory**: `backend`
   - **Build Command**: `pip install -r requirements.txt && python migrate_db.py`
   - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`

### 3. Создание Frontend (2 мин)
1. "New +" → "Static Site"
2. Подключите тот же репозиторий
3. Настройки:
   - **Name**: `agrosky-frontend`
   - **Root Directory**: `frontend`
   - **Build Command**: `npm install && npm run build`
   - **Publish Directory**: `dist`

### 4. Переменные окружения
**Backend:**
```
SENTINEL_CLIENT_ID=e6753813-f4e6-41dd-887f-1c0a78c8ce88
SENTINEL_CLIENT_SECRET=QZSOjOPB0h2kaP4kCK5MeSDW1DpKfaKg
```

**Frontend:**
```
VITE_API_URL=https://agrosky-backend.onrender.com
```

## ✅ Готово!

- Backend: `https://agrosky-backend.onrender.com`
- Frontend: `https://agrosky-frontend.onrender.com`
- API Docs: `https://agrosky-backend.onrender.com/docs`

## 🔧 Если что-то не работает:

1. **Build ошибка** → Проверьте логи в Render Dashboard
2. **CORS ошибка** → Обновите VITE_API_URL в frontend
3. **API не отвечает** → Проверьте переменные окружения
4. **Frontend не загружается** → Проверьте build команду

## 📞 Поддержка
- Render Docs: https://render.com/docs
- Логи сервисов: Dashboard → Service → Logs
