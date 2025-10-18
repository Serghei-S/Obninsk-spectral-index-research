# 🚀 НЕМЕДЛЕННЫЙ ДЕПЛОЙ НА RENDER.COM

## ✅ ГОТОВО К ДЕПЛОЮ!

Все файлы закоммичены и отправлены в GitHub. Теперь можно развернуть сайт за 5 минут!

## 📋 ЧТО НУЖНО СДЕЛАТЬ ПРЯМО СЕЙЧАС:

### 1. Откройте Render.com (1 мин)
- Перейдите на https://render.com
- Войдите через GitHub
- Нажмите "New +" → "Web Service"

### 2. Создайте Backend сервис (2 мин)

**Подключение репозитория:**
- Выберите ваш репозиторий: `Serghei-S/Obninsk-spectral-index-research`
- Branch: `main`

**Настройки сервиса:**
- **Name**: `agrosky-backend`
- **Environment**: `Docker`
- **Region**: `Oregon (US West)`
- **Root Directory**: `backend`
- **Build Command**: (оставить пустым - Docker сам соберет)
- **Start Command**: (оставить пустым - Docker сам запустит)

**Environment Variables (добавьте в разделе Environment):**
```
SENTINEL_CLIENT_ID=e6753813-f4e6-41dd-887f-1c0a78c8ce88
SENTINEL_CLIENT_SECRET=QZSOjOPB0h2kaP4kCK5MeSDW1DpKfaKg
ENVIRONMENT=production
```

**Advanced Settings:**
- Health Check Path: `/health`
- Auto Deploy: `Yes`

### 3. Создайте Frontend сервис (2 мин)

**После создания backend:**
- Нажмите "New +" → "Static Site"
- Выберите тот же репозиторий
- Branch: `main`

**Настройки сервиса:**
- **Name**: `agrosky-frontend`
- **Environment**: `Docker`
- **Root Directory**: `frontend`
- **Build Command**: (оставить пустым - Docker сам соберет)
- **Start Command**: (оставить пустым - Docker сам запустит)

**Environment Variables:**
```
VITE_API_URL=https://agrosky-backend.onrender.com
```

**Advanced Settings:**
- Auto Deploy: `Yes`

## 🎯 РЕЗУЛЬТАТ:

После создания обоих сервисов у вас будет:
- **Backend**: `https://agrosky-backend.onrender.com`
- **Frontend**: `https://agrosky-frontend.onrender.com`
- **API Docs**: `https://agrosky-backend.onrender.com/docs`

## ⚡ БЫСТРАЯ ПРОВЕРКА:

1. Откройте backend URL + `/health` - должно показать `{"status": "healthy"}`
2. Откройте frontend URL - должен загрузиться интерфейс
3. Проверьте API docs - должна открыться Swagger документация

## 🔧 ЕСЛИ ЧТО-ТО НЕ РАБОТАЕТ:

1. **Build ошибка** → Проверьте логи в Render Dashboard
2. **Frontend не видит backend** → Обновите VITE_API_URL в настройках frontend
3. **CORS ошибка** → Проверьте что backend URL правильный

## 📊 МОНИТОРИНГ:

- **Логи**: Dashboard → Service → Logs
- **Метрики**: Dashboard → Service → Metrics
- **Health**: `https://agrosky-backend.onrender.com/health`

---

## 🎉 ГОТОВО!

Ваш AgroSky Insight будет развернут и доступен в интернете!

**Время деплоя: ~5 минут**
**Стоимость: БЕСПЛАТНО (Free план)**
