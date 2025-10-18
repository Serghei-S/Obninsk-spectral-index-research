# 🚀 БЫСТРЫЙ ЗАПУСК AGROSKY INSIGHT

## ✅ ШАГ 1: BACKEND

Откройте **ТЕРМИНАЛ 1** (PowerShell) и выполните **последовательно**:

```powershell
cd C:\Users\Serghei\Desktop\obninsc\backend
.\venv\Scripts\activate
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Ожидаемый вывод:**
```
WARNING: rasterio not available...
INFO:     Uvicorn running on http://0.0.0.0:8000
INFO:     Application startup complete.
```

❗ **НЕ ЗАКРЫВАЙТЕ это окно!**

---

## ✅ ШАГ 2: FRONTEND

Откройте **ТЕРМИНАЛ 2** (PowerShell) и выполните:

```powershell
cd C:\Users\Serghei\Desktop\obninsc\frontend
npm run dev
```

**Ожидаемый вывод:**
```
VITE v5.x.x  ready in xxx ms
➜  Local:   http://localhost:3000/
```

❗ **НЕ ЗАКРЫВАЙТЕ это окно!**

---

## ✅ ШАГ 3: ОТКРОЙТЕ БРАУЗЕР

Откройте браузер и перейдите:

```
http://localhost:3000
```

---

## 🎯 НОВЫЙ ФУНКЦИОНАЛ

После входа в систему вы сможете:

1. **💾 Сохранять поля** - нарисуйте поле на карте и нажмите "Сохранить поле"
2. **📊 Создавать дашборд** - добавляйте анализы на персональный дашборд
3. **📥 Экспортировать данные** - скачивайте графики (PNG) и данные (CSV)
4. **🗺️ Просматривать дашборд** - нажмите кнопку "📊 Дашборд" в хедере

---

## ❓ ПРОБЛЕМЫ?

### Backend не запускается

**Проблема:** `ModuleNotFoundError`

**Решение:**
```powershell
cd backend
.\venv\Scripts\activate
pip install numpy matplotlib pillow
```

### Frontend не запускается  

**Проблема:** `Cannot find module`

**Решение:**
```powershell
cd frontend
npm install
```

### Аутентификация не работает

**Проверьте:**
1. Backend запущен на порту 8000
2. Frontend запущен (на любом порту - 3000 или 5173)
3. Оба окна терминала открыты и не показывают ошибок

---

## 📋 ПРОВЕРКА СТАТУСА

Откройте **ТЕРМИНАЛ 3** и выполните:

```powershell
# Проверка Backend
curl http://localhost:8000

# Проверка Frontend  
curl http://localhost:3000
```

Если обе команды выполнились - **всё работает!**

---

## 🔐 ВХОД В СИСТЕМУ

1. Откройте http://localhost:3000
2. Если у вас нет аккаунта - нажмите "Регистрация"
3. Введите email и пароль (минимум 6 символов)
4. Войдите в систему

---

## 🎉 ГОТОВО!

Теперь вы можете пользоваться всеми новыми функциями:
- Сохранение полей
- Персональный дашборд
- Экспорт графиков и данных
- Анализ временных рядов

**Удачи!** 🚀

