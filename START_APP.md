# 🚀 Инструкция по запуску AgroSky Insight

## ✅ Быстрый запуск

### Шаг 1: Запуск Backend

Откройте **первый терминал PowerShell** и выполните:

```powershell
cd C:\Users\Serghei\Desktop\obninsc\backend
.\venv\Scripts\activate
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Ожидаемый вывод:**
```
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

### Шаг 2: Запуск Frontend

Откройте **второй терминал PowerShell** и выполните:

```powershell
cd C:\Users\Serghei\Desktop\obninsc\frontend
npm run dev
```

**Ожидаемый вывод:**
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h + enter to show help
```

### Шаг 3: Откройте браузер

Откройте браузер и перейдите по адресу:
```
http://localhost:5173
```

## 🔧 Если возникли ошибки

### Backend не запускается

**Ошибка:** `ModuleNotFoundError`

**Решение:**
```powershell
cd backend
.\venv\Scripts\activate
pip install fastapi uvicorn sqlalchemy pydantic python-jose[cryptography] passlib[bcrypt] python-multipart email-validator
```

**Ошибка:** База данных

**Решение:**
```powershell
cd backend
.\venv\Scripts\activate
python migrate_db.py
```

### Frontend не запускается

**Ошибка:** `Cannot find module 'react-router-dom'`

**Решение:**
```powershell
cd frontend
npm install react-router-dom
```

## 📝 Проверка статуса

После запуска обоих серверов, откройте **третий терминал** и выполните:

```powershell
# Проверка Backend
Invoke-WebRequest -Uri http://localhost:8000/docs -UseBasicParsing

# Проверка Frontend  
Invoke-WebRequest -Uri http://localhost:5173 -UseBasicParsing
```

Если обе команды выполнились без ошибок - всё работает!

## 🌐 Ссылки

- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:8000
- **API Документация:** http://localhost:8000/docs

## 🎯 Новый функционал

После успешного запуска вы сможете:

1. **💾 Сохранять поля** - нарисуйте поле и сохраните его
2. **📊 Создавать дашборд** - добавляйте анализы на персональный дашборд
3. **📥 Экспортировать данные** - скачивайте графики (PNG) и данные (CSV)
4. **🗺️ Просматривать дашборд** - нажмите "📊 Дашборд" в хедере

Удачи! 🎉

