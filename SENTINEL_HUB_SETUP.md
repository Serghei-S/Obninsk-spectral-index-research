# 🛰️ Настройка Sentinel Hub API

Этот проект использует **Sentinel Hub API** для получения реальных спутниковых данных Sentinel-2. Без ключей API проект работает в **MOCK режиме** с тестовыми данными.

## 📋 Как получить ключи API

### Шаг 1: Регистрация на Sentinel Hub

1. Перейдите на сайт: **https://www.sentinel-hub.com/**
2. Нажмите **"Try for free"** или **"Sign up"**
3. Заполните форму регистрации
4. Подтвердите email

### Шаг 2: Создание OAuth клиента

1. Войдите в **Dashboard**: https://apps.sentinel-hub.com/dashboard/
2. В левом меню выберите **"User Settings"**
3. Перейдите в раздел **"OAuth clients"**
4. Нажмите **"+ New OAuth Client"**
5. Введите название (например: `AgroSky Insight`)
6. Нажмите **"Create"**

### Шаг 3: Получение ключей

После создания OAuth клиента вы увидите:

- ✅ **Client ID** - публичный идентификатор
- ✅ **Client Secret** - секретный ключ (⚠️ показывается только один раз!)

**ВАЖНО:** Сохраните Client Secret немедленно! Он больше не будет показан.

### Шаг 4 (опционально): Instance ID

Instance ID не обязателен для базовой работы, но может потребоваться для некоторых функций:

1. В Dashboard перейдите в **"Configuration Utility"**
2. Создайте новую конфигурацию
3. Скопируйте Instance ID

---

## 🔧 Настройка проекта

### Вариант 1: Переменные окружения (для Docker) ⭐ Рекомендуется

1. Создайте файл `.env` в корне проекта:

```bash
# .env
SENTINEL_CLIENT_ID=ваш_client_id_здесь
SENTINEL_CLIENT_SECRET=ваш_client_secret_здесь
SENTINEL_INSTANCE_ID=ваш_instance_id_здесь
```

2. Перезапустите Docker контейнеры:

```bash
docker compose down
docker compose up
```

### Вариант 2: Файл конфигурации (для локального запуска)

1. Откройте файл `backend/config.py`

2. Добавьте ваши ключи:

```python
SENTINEL_CLIENT_ID = "ваш_client_id_здесь"
SENTINEL_CLIENT_SECRET = "ваш_client_secret_здесь"
SENTINEL_INSTANCE_ID = "ваш_instance_id_здесь"
```

3. Перезапустите backend

---

## ✅ Проверка настройки

После добавления ключей, проверьте логи backend при запуске:

### MOCK режим (без ключей):
```
WARNING:services.sentinel_service:Sentinel Hub credentials not found. Using MOCK mode.
```

### REAL режим (с ключами):
```
INFO:services.sentinel_service:Sentinel Hub credentials found. Using REAL API mode.
```

---

## 📊 Бесплатный тариф

Sentinel Hub предоставляет **бесплатный trial** с ограничениями:

- ✅ **5,000 Processing Units** в месяц
- ✅ Доступ ко всем данным Sentinel
- ✅ 30 дней trial периода

После trial можно перейти на:
- **Free tier**: 1,000 PU/месяц (достаточно для демо)
- **Pay-as-you-go**: от €0.0012 за Processing Unit

### Что такое Processing Unit (PU)?

1 PU ≈ обработка 1 км² спутниковых данных

Пример: анализ поля 100 га (1 км²) ≈ 1 PU

---

## 🔒 Безопасность

⚠️ **НЕ ПУБЛИКУЙТЕ** ваши ключи в GitHub или других публичных местах!

Файлы с ключами уже добавлены в `.gitignore`:
- `.env`
- `backend/config.py`

---

## 🆘 Помощь и документация

- 📚 **Официальная документация**: https://docs.sentinel-hub.com/
- 💬 **Форум**: https://forum.sentinel-hub.com/
- 📧 **Поддержка**: support@sentinel-hub.com
- 🎓 **Примеры**: https://github.com/sentinel-hub/sentinelhub-py

---

## 🧪 Работа без ключей

Если вы не хотите регистрироваться прямо сейчас:

✅ Проект работает в **MOCK режиме**
✅ Генерирует синтетические NDVI данные для демонстрации
✅ Все функции интерфейса доступны
✅ Идеально для тестирования и разработки

Для хакатона и демо **MOCK режим вполне достаточен**! 🎯

