# 🛰️ Быстрая настройка Sentinel Hub для реальных данных

## 📋 Шаги для получения реальных спутниковых данных

### Шаг 1: Регистрация на Sentinel Hub

1. **Перейдите на сайт:** https://apps.sentinel-hub.com/dashboard/
2. **Зарегистрируйтесь** (можно через Google/GitHub)
3. **Подтвердите email**

### Шаг 2: Получение учетных данных

1. **Войдите в Dashboard:** https://apps.sentinel-hub.com/dashboard/
2. **Перейдите:** User Settings → OAuth clients
3. **Создайте новый OAuth client:**
   - Name: `AgroSky Insight`
   - Click "Create OAuth client"
4. **Скопируйте:**
   - ✅ Client ID (например: `abc123-def456-...`)
   - ✅ Client Secret (например: `xyz789-abc123-...`)

### Шаг 3: Настройка credentials в проекте

#### Вариант 1: Через config.py (Рекомендуется)

Откройте файл `backend/config.py` и вставьте ваши данные:

```python
# Sentinel Hub API Credentials
SENTINEL_CLIENT_ID = "ВАШ_CLIENT_ID_СЮДА"
SENTINEL_CLIENT_SECRET = "ВАШ_CLIENT_SECRET_СЮДА"
SENTINEL_INSTANCE_ID = ""  # Опционально
```

#### Вариант 2: Через переменные окружения

**Windows PowerShell:**
```powershell
$env:SENTINEL_CLIENT_ID="ВАШ_CLIENT_ID"
$env:SENTINEL_CLIENT_SECRET="ВАШ_CLIENT_SECRET"
```

**Windows CMD:**
```cmd
set SENTINEL_CLIENT_ID=ВАШ_CLIENT_ID
set SENTINEL_CLIENT_SECRET=ВАШ_CLIENT_SECRET
```

**Linux/Mac:**
```bash
export SENTINEL_CLIENT_ID="ВАШ_CLIENT_ID"
export SENTINEL_CLIENT_SECRET="ВАШ_CLIENT_SECRET"
```

### Шаг 4: Перезапуск сервера

После настройки credentials:

1. **Остановите backend** (если запущен)
2. **Запустите снова:**
   ```bash
   cd backend
   .\venv\Scripts\activate  # Windows
   python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

3. **Проверьте логи** - должно быть:
   ```
   INFO:services.sentinel_service:Sentinel Hub credentials found. Using REAL API mode.
   ```

---

## 🎯 Проверка работы

1. Откройте сайт: http://localhost:3000
2. Войдите в систему
3. Перейдите на карту
4. Нарисуйте поле
5. Выберите даты и запустите анализ
6. **Теперь будут использоваться реальные спутниковые снимки!** 🎉

---

## 💰 Бесплатные лимиты Sentinel Hub

- ✅ **30,000** Processing Units в месяц (бесплатно)
- ✅ Достаточно для **~1000 запросов** в месяц
- ✅ Идеально для тестирования и демо

---

## ⚠️ Troubleshooting

### Проблема: "MOCK mode" в логах
**Решение:** Проверьте, что credentials правильно введены в `config.py`

### Проблема: "401 Unauthorized"
**Решение:** Проверьте правильность Client ID и Client Secret

### Проблема: "429 Too Many Requests"
**Решение:** Превышен лимит запросов, подождите или обновите план

---

## 📝 Важные заметки

- 🔒 **НЕ публикуйте** credentials на GitHub!
- 🔑 Держите Client Secret в секрете
- 📊 Следите за использованием в Dashboard
- 🔄 Можно сбросить credentials в любой момент

---

**После настройки вы получите реальные данные Sentinel-2!** 🛰️

