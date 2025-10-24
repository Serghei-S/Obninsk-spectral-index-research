# 🚀 Быстрый старт R2-Фермер

## 📋 Предварительные требования

Выберите один из вариантов:

### Вариант 1: Docker (рекомендуется)
- **Docker Desktop** для Windows/Mac
- **Docker + Docker Compose** для Linux

### Вариант 2: Локальная установка
- **Python 3.11+**
- **Node.js 18+**
- **pip** и **npm**

---

## ⚡ Запуск через Docker

### 1. Подготовка

```bash
# Клонируйте репозиторий
git clone <your-repo-url>
cd obninsk_final_2
```

### 2. (Опционально) Настройка API ключей

Скопируйте `env_template.txt` в `.env` и заполните:

```env
# Sentinel Hub API (для реальных данных)
SENTINEL_CLIENT_ID=your_client_id
SENTINEL_CLIENT_SECRET=your_secret

# Google Gemini AI (для AI агронома)
GEMINI_API_KEY=your_gemini_key

# JWT секретный ключ
SECRET_KEY=your_super_secret_key_min_32_chars
```

**📝 Примечание:** Без API ключей приложение работает в mock-режиме с синтетическими данными.

### 3. Запуск

```bash
# Запустите Docker Desktop (для Windows/Mac)

# Соберите и запустите контейнеры
docker-compose up --build
```

### 4. Откройте в браузере

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000/docs
- **Health Check:** http://localhost:8000/health

---

## 💻 Локальная установка

### Backend

```bash
# 1. Перейдите в папку backend
cd backend

# 2. Создайте виртуальное окружение
python -m venv venv

# 3. Активируйте его
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# 4. Установите зависимости
pip install -r requirements.txt

# 5. (Опционально) Настройте переменные окружения
# Windows:
set GEMINI_API_KEY=your_key
set SECRET_KEY=your_secret
# Linux/Mac:
export GEMINI_API_KEY=your_key
export SECRET_KEY=your_secret

# 6. Запустите сервер
python main.py
```

Backend будет доступен на http://localhost:8000

### Frontend

Откройте **новый терминал**:

```bash
# 1. Перейдите в папку frontend
cd frontend

# 2. Установите зависимости
npm install

# 3. Запустите dev-сервер
npm run dev
```

Frontend будет доступен на http://localhost:3000

---

## 🎮 Первое использование

### 1. Регистрация
1. Откройте http://localhost:3000
2. Нажмите **"Регистрация"**
3. Введите email и пароль
4. Заполните профиль (необязательно)

### 2. Анализ поля
1. На главной странице нажмите **"Анализ полей"**
2. Найдите ваше поле на карте
3. Нажмите кнопку **□** (полигон) справа на карте
4. Обведите границы поля
5. Нажмите **"Анализировать поле"**
6. Дождитесь результата (10-30 секунд)

### 3. Просмотр результатов
- 🗺️ Цветная карта NDVI на поле
- 📊 Статистика (площадь, средний NDVI, зоны)
- 💬 Автоматическая интерпретация

### 4. Дополнительные функции
- **📈 Анализ динамики** — график изменения индексов за период
- **🤖 AI Агроном** — экспертный анализ с рекомендациями
- **🗺️ Зонирование** — разделение поля на зоны управления
- **💾 Дашборд** — сохранение и просмотр всех анализов

---

## 🔧 Полезные команды

### Docker

```bash
# Запуск
docker-compose up

# Запуск с пересборкой
docker-compose up --build

# Остановка
docker-compose down

# Просмотр логов
docker-compose logs -f

# Просмотр запущенных контейнеров
docker ps
```

### Backend

```bash
# Запуск тестов
cd backend
pytest

# Миграция базы данных
python migrate_db.py

# Проверка API
curl http://localhost:8000/health
```

### Frontend

```bash
# Запуск в dev режиме
npm run dev

# Сборка для production
npm run build

# Просмотр production сборки
npm run preview
```

---

## 🆘 Решение проблем

### Docker не запускается
- Убедитесь, что Docker Desktop запущен (зеленая иконка в трее)
- Проверьте, что Docker daemon работает
- Попробуйте перезапустить Docker Desktop

### Ошибка "Port already in use"
```bash
# Windows (остановить процесс на порту 3000)
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:3000 | xargs kill -9
```

### Backend не видит базу данных
```bash
cd backend
python migrate_db.py
```

### Frontend не может подключиться к backend
- Проверьте, что backend запущен на http://localhost:8000
- Проверьте файл `frontend/vite.config.js` - proxy должен указывать на localhost:8000

### Ошибка "Module not found"
```bash
# Backend
cd backend
pip install -r requirements.txt

# Frontend
cd frontend
npm install
```

---

## 📚 Дополнительная информация

### Получение API ключей

**Sentinel Hub:**
1. Зарегистрируйтесь: https://apps.sentinel-hub.com/dashboard/
2. Создайте OAuth Client
3. Скопируйте Client ID и Secret

**Google Gemini:**
1. Перейдите: https://makersuite.google.com/app/apikey
2. Создайте API ключ
3. Скопируйте ключ

### Структура проекта
```
obninsk_final_2/
├── backend/          # FastAPI сервер (Python)
├── frontend/         # React приложение (JavaScript)
├── docker-compose.yml
├── README.md         # Полная документация
└── QUICK_START.md    # Этот файл
```

### Полезные ссылки
- **Swagger UI:** http://localhost:8000/docs
- **ReDoc:** http://localhost:8000/redoc
- **GitHub:** [ваш репозиторий]

---

## ✅ Готово!

Теперь вы можете:
- ✅ Анализировать поля по спутниковым данным
- ✅ Отслеживать динамику вегетации
- ✅ Получать рекомендации от AI агронома
- ✅ Создавать зоны дифференцированного внесения
- ✅ Сохранять результаты на дашборд

**Приятного использования! 🌾**

Если возникнут вопросы — читайте [README.md](README.md) или обращайтесь в поддержку.




