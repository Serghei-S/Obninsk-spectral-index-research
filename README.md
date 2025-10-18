# 🛰️ AgroSky Insight

**Веб-сервис для мониторинга здоровья сельскохозяйственных полей на основе спутниковых данных Sentinel-2**

![Python](https://img.shields.io/badge/Python-3.11-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104-green)
![React](https://img.shields.io/badge/React-18.2-61dafb)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📋 Содержание

- [О проекте](#о-проекте)
- [Возможности](#возможности)
- [Технологический стек](#технологический-стек)
- [Архитектура](#архитектура)
- [Быстрый старт](#быстрый-старт)
- [Установка и запуск](#установка-и-запуск)
- [Использование](#использование)
- [API документация](#api-документация)
- [Научная методология](#научная-методология)
- [Roadmap](#roadmap)

## 🌾 О проекте

AgroSky Insight - это современный веб-сервис для анализа состояния сельскохозяйственных полей с использованием реальных спутниковых данных Sentinel-2. Система позволяет в реальном времени оценивать здоровье растительности через расчет различных вегетационных индексов (NDVI, EVI, PSRI, NBR, NDSI).

### Ключевые преимущества:

✅ **Научная достоверность** - использование данных Sentinel-2 Level 2A с атмосферной коррекцией  
✅ **Фильтрация облачности** - автоматическая маскировка облаков и теней для точности анализа  
✅ **Удобный интерфейс** - интуитивная работа с картой и инструментами рисования  
✅ **Реальное время** - обработка данных "на лету" без предварительной загрузки  
✅ **Детальная статистика** - площадь поля, средние значения индексов, распределение по зонам  
✅ **Анализ динамики** - отслеживание изменений индексов во времени  
✅ **Аутентификация** - персонализированный доступ для каждого фермера  
✅ **Темная тема** - комфортная работа в любое время суток

## 🚀 Возможности

### Основные функции
- 🗺️ **Интерактивная карта** с возможностью выбора произвольной области поля (полигон или прямоугольник)
- 📊 **Множественные вегетационные индексы**:
  - **NDVI** - Normalized Difference Vegetation Index (здоровье растительности)
  - **EVI** - Enhanced Vegetation Index (улучшенный индекс растительности)
  - **PSRI** - Plant Senescence Reflectance Index (индекс старения растений)
  - **NBR** - Normalized Burn Ratio (индекс выгорания)
  - **NDSI** - Normalized Difference Snow Index (снежный индекс)
- ☁️ **Умная маскировка облаков** с использованием Scene Classification Layer (SCL)
- 🔄 **Автоматический retry** - если данные недоступны, система автоматически пытается найти лучший снимок
- 📈 **Детальная статистика** поля (площадь, средние значения, распределение по зонам)
- 🎨 **Красивая визуализация** результатов с цветовыми картами и легендами
- 📅 **Выбор периода** анализа для поиска оптимального снимка
- 📊 **Анализ временной динамики** - график изменения индексов за период
- 💾 **Экспорт результатов** в виде изображений

### UI/UX
- 🎨 **Современный дизайн** - минималистичный интерфейс с использованием шрифта Inter
- 🌓 **Темная тема** - переключение между светлой и темной темами с сохранением настроек
- 🏠 **Красивый Welcome Screen** - приветственный экран с анимацией
- ⚠️ **Креативная страница ошибок** - уникальная страница с плачущим фермером
- 📱 **Адаптивность** - работает на различных устройствах

### Безопасность
- 🔐 **Аутентификация пользователей** - регистрация и вход через JWT токены
- 🔒 **Защищенные маршруты** - доступ к анализу только для авторизованных пользователей
- 💾 **Сохранение сессии** - автоматическое восстановление сессии при перезагрузке страницы

## 🛠 Технологический стек

### Backend
- **FastAPI** - современный асинхронный веб-фреймворк
- **Rasterio** - работа с растровыми геоданными
- **NumPy** - быстрые математические операции
- **Shapely/GeoPandas** - обработка векторных данных
- **Matplotlib** - генерация визуализаций
- **Pydantic** - валидация данных
- **SQLAlchemy** - ORM для работы с базой данных
- **Passlib + Bcrypt** - безопасное хеширование паролей
- **Python-Jose** - работа с JWT токенами

### Frontend
- **React 18** - современная UI библиотека
- **Leaflet.js** - интерактивная картография
- **Leaflet-Draw** - инструменты рисования
- **Chart.js** - визуализация статистики и временных рядов
- **Axios** - HTTP клиент с автоматическим добавлением JWT
- **Vite** - быстрый сборщик и dev сервер
- **React Context API** - глобальное управление состоянием аутентификации

### Инфраструктура
- **Docker + Docker Compose** - контейнеризация и оркестрация
- **SQLite** - легковесная база данных для хранения пользователей
- **Nginx** (опционально) - reverse proxy для production

### Данные
- **Sentinel-2 L2A** - спутниковые данные с атмосферной коррекцией
- **Sentinel Hub Process API** - доступ к данным через REST API
- **Каналы**: B02 (Blue), B03 (Green), B04 (Red), B08 (NIR), B11 (SWIR1), B12 (SWIR2), SCL

## 🏗 Архитектура

```
┌─────────────┐
│ Пользователь │
└──────┬──────┘
       │
┌──────▼───────────────────────────────────────┐
│    Frontend (React + Leaflet + Auth)         │
│  - Приветственный экран                      │
│  - Система аутентификации                    │
│  - Интерактивная карта с инструментами       │
│  - Дашборд со статистикой                    │
│  - Анализ временной динамики                 │
│  - Темная тема                               │
└──────┬───────────────────────────────────────┘
       │ HTTP/JSON + JWT Bearer Token
┌──────▼───────────────────────────────────────┐
│         Backend (FastAPI + Auth)             │
│  ┌────────────────────────────────────────┐ │
│  │  Auth Routes (/api/v1/auth/*)          │ │
│  │  - Register, Login, Get User           │ │
│  └────────┬───────────────────────────────┘ │
│  ┌────────▼────────────────────────────────┐│
│  │  API Routes (/api/v1/analyze)           ││
│  │  - Field analysis                       ││
│  │  - Time series analysis                 ││
│  └────────┬────────────────────────────────┘│
│           │                                  │
│  ┌────────▼────────────┐  ┌───────────────┐ │
│  │  Sentinel Service   │  │ Geo Processor │ │
│  │  - Получение данных │  │ - Расчет NDVI │ │
│  │  - Retry логика     │  │ - Расчет EVI  │ │
│  │  - Cloud masking    │  │ - Расчет PSRI │ │
│  └────────┬────────────┘  │ - Расчет NBR  │ │
│           │               │ - Расчет NDSI │ │
│           │               │ - Маскировка  │ │
│           │               │ - Статистика  │ │
│           │               └───────────────┘ │
└───────────┼───────────────────────────────────┘
            │
┌───────────▼───────────────────────────────────┐
│      Sentinel Hub Process API                │
│   (Sentinel-2 L2A: B02-B12, SCL)            │
└──────────────────────────────────────────────┘
```

## ⚡ Быстрый старт

### Вариант 1: Docker (Рекомендуется)

```bash
# Клонировать репозиторий
git clone https://github.com/your-username/agrosky-insight.git
cd agrosky-insight

# Настроить Sentinel Hub API ключи (опционально)
# Скопируйте .env.example в .env и заполните:
# SENTINEL_CLIENT_ID=your_client_id
# SENTINEL_CLIENT_SECRET=your_secret

# Запустить с помощью Docker Compose
docker-compose up --build

# Открыть в браузере
# Frontend: http://localhost:3000
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Вариант 2: Локальная установка

#### Backend

```bash
cd backend

# Создать виртуальное окружение
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Установить зависимости
pip install -r requirements.txt

# Настроить environment variables
export SENTINEL_CLIENT_ID=your_client_id
export SENTINEL_CLIENT_SECRET=your_secret
export SECRET_KEY=your_jwt_secret_key

# Запустить сервер
uvicorn main:app --reload --port 8000
```

#### Frontend

```bash
cd frontend

# Установить зависимости
npm install

# Запустить dev сервер
npm run dev
```

## 📖 Использование

### 1. Регистрация и вход

1. Откройте приложение в браузере (http://localhost:3000)
2. Зарегистрируйте новый аккаунт или войдите в существующий
3. Система автоматически сохранит вашу сессию

### 2. Выбор области поля

1. Нажмите кнопку "Начать" на приветственном экране
2. Используйте инструменты рисования на карте (правый верхний угол)
3. Нарисуйте полигон или прямоугольник вокруг интересующего поля

### 3. Настройка параметров

- Выберите диапазон дат для поиска снимков
- Выберите вегетационные индексы для расчета (NDVI, EVI, PSRI, NBR, NDSI)
- По умолчанию используется текущий месяц

### 4. Запуск анализа

- Нажмите кнопку "Анализировать поле"
- Дождитесь обработки данных (5-30 секунд в зависимости от качества снимков)
- Система автоматически попытается найти лучший снимок при необходимости

### 5. Просмотр результатов

- **Карта**: визуализация индексов с цветовыми картами и легендами
- **Статистика**: площадь, средние значения, облачность, распределение по зонам
- **Дополнительные индексы**: просмотр и сравнение различных индексов
- **Интерпретация**: автоматическая оценка состояния поля

### 6. Анализ динамики

1. Нажмите кнопку "Анализ динамики"
2. Выберите период для анализа (минимум 10 дней)
3. Выберите интересующий индекс
4. Нажмите "Анализировать динамику"
5. Просмотрите график изменения индекса во времени

## 📚 API Документация

### Аутентификация

#### POST /api/v1/auth/register
Регистрация нового пользователя

**Request Body:**
```json
{
  "email": "farmer@example.com",
  "password": "securepassword123"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "User registered successfully."
}
```

#### POST /api/v1/auth/login
Вход пользователя

**Request Body:**
```json
{
  "email": "farmer@example.com",
  "password": "securepassword123"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

#### GET /api/v1/auth/me
Получение информации о текущем пользователе

**Headers:** `Authorization: Bearer <token>`

**Response:**
```json
{
  "id": "uuid-here",
  "email": "farmer@example.com"
}
```

### Анализ полей

#### POST /api/v1/analyze
Анализ сельскохозяйственного поля (требует авторизации)

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "geometry": {
    "type": "Polygon",
    "coordinates": [
      [
        [37.6173, 55.7558],
        [37.6273, 55.7558],
        [37.6273, 55.7458],
        [37.6173, 55.7458],
        [37.6173, 55.7558]
      ]
    ]
  },
  "date_range": ["2025-10-01", "2025-10-15"],
  "indices": ["NDVI", "EVI", "PSRI"]
}
```

**Response:**
```json
{
  "status": "success",
  "image_url": "/results/uuid/ndvi_visualization.png",
  "bounds": [[55.7458, 37.6173], [55.7558, 37.6273]],
  "stats": {
    "area_ha": 120.5,
    "mean_ndvi": 0.65,
    "capture_date": "2025-10-14",
    "cloud_coverage_percent": 5.2,
    "zones_percent": {
      "low (<0.3)": 10.0,
      "medium (0.3-0.6)": 30.0,
      "high (>0.6)": 60.0
    },
    "valid_pixels_percent": 94.8
  },
  "additional_indices": [
    {
      "index_type": "EVI",
      "mean_value": 0.55,
      "image_url": "/results/uuid/evi_visualization.png",
      "interpretation": "Средняя растительность"
    }
  ]
}
```

#### POST /api/v1/analyze/timeseries
Анализ временной динамики (требует авторизации)

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "geometry": { "type": "Polygon", "coordinates": [...] },
  "start_date": "2025-08-01",
  "end_date": "2025-10-15",
  "index_type": "NDVI"
}
```

**Response:**
```json
{
  "status": "success",
  "data_points": [
    {
      "date": "2025-08-05",
      "value": 0.42
    },
    {
      "date": "2025-08-15",
      "value": 0.48
    }
  ],
  "index_type": "NDVI",
  "stats": {
    "min": 0.38,
    "max": 0.72,
    "mean": 0.56,
    "trend": "increasing"
  }
}
```

**Swagger UI:** http://localhost:8000/docs

## 🔬 Научная методология

### Вегетационные индексы

#### 1. NDVI (Normalized Difference Vegetation Index)
**Формула:** NDVI = (NIR - Red) / (NIR + Red)

- **Назначение**: Основной индекс оценки здоровья растительности
- **Диапазон**: -1.0 до +1.0
- **Интерпретация**:
  - < 0.2: Почва, вода, искусственные объекты
  - 0.2 - 0.4: Низкая/стрессовая растительность
  - 0.4 - 0.6: Средняя растительность
  - > 0.6: Здоровая, густая растительность

#### 2. EVI (Enhanced Vegetation Index)
**Формула:** EVI = 2.5 × ((NIR - Red) / (NIR + 6×Red - 7.5×Blue + 1))

- **Назначение**: Улучшенная версия NDVI, менее чувствительная к атмосферным условиям
- **Преимущества**: Лучше работает в областях с высокой плотностью растительности

#### 3. PSRI (Plant Senescence Reflectance Index)
**Формула:** PSRI = (Red - Green) / NIR

- **Назначение**: Оценка старения растений и созревания урожая
- **Применение**: Определение оптимального времени для уборки

#### 4. NBR (Normalized Burn Ratio)
**Формула:** NBR = (NIR - SWIR2) / (NIR + SWIR2)

- **Назначение**: Оценка повреждений от пожаров или стресса
- **Применение**: Мониторинг засухи и повреждений

#### 5. NDSI (Normalized Difference Snow Index)
**Формула:** NDSI = (Green - SWIR1) / (Green + SWIR1)

- **Назначение**: Определение снежного покрова
- **Применение**: Оценка увлажнения почвы весной

### Маскировка облачности

Используется Scene Classification Layer (SCL) из Sentinel-2 L2A:

- **Код 0**: No Data - исключается
- **Код 3**: Тени от облаков - исключается
- **Код 8**: Облака средней вероятности - исключается
- **Код 9**: Облака высокой вероятности - исключается
- **Код 10**: Тонкие перистые облака - исключается

### Автоматический Retry механизм

Если первоначальный запрос возвращает менее 1% валидных пикселей:
1. Система переключается на `mosaickingOrder: "leastCC"` (наименьшая облачность)
2. Расширяет временное окно (+30-60 дней)
3. Увеличивает допустимый процент облачности (до 60-80%)

### Источник данных

**Sentinel-2** - европейская миссия наблюдения Земли:
- Пространственное разрешение: 10м (B02, B03, B04, B08), 20м (B11, B12)
- Временное разрешение: 5 дней (2 спутника)
- Уровень обработки: L2A (с атмосферной коррекцией)
- API: Sentinel Hub Process API

## 🎯 Roadmap

### Реализовано ✅

- [x] Базовый backend на FastAPI с аутентификацией
- [x] Интеграция с Sentinel-2 через Sentinel Hub API
- [x] Расчет множественных вегетационных индексов (NDVI, EVI, PSRI, NBR, NDSI)
- [x] Маскировка облачности через SCL
- [x] Автоматический retry с адаптивными параметрами
- [x] Интерактивный фронтенд с Leaflet и инструментами рисования
- [x] Визуализация результатов с легендами
- [x] Детальная статистика с распределением по зонам
- [x] Анализ временной динамики
- [x] Docker контейнеризация
- [x] Система аутентификации (JWT)
- [x] Темная тема с сохранением настроек
- [x] Красивый приветственный экран
- [x] Креативная страница ошибок

### В разработке 🚧

- [ ] Сохранение истории анализов для пользователя
- [ ] Экспорт отчетов в PDF
- [ ] Множественные поля одновременно
- [ ] Уведомления об изменениях в полях

### Планируется 📋

- [ ] Дополнительные индексы (NDWI, SAVI, LAI)
- [ ] ML-модели для детекции болезней растений
- [ ] Интеграция с данными погоды
- [ ] Прогнозирование урожайности
- [ ] Мобильное приложение (React Native)
- [ ] API для интеграции с агротехникой (IoT)
- [ ] Социальные функции (обмен опытом между фермерами)
- [ ] Marketplace для агроуслуг

## 🔐 Конфигурация

### Sentinel Hub API

Для работы с реальными данными:

1. Зарегистрируйтесь на https://apps.sentinel-hub.com/dashboard/
2. Создайте OAuth Client
3. Настройте environment variables:

```bash
export SENTINEL_CLIENT_ID="your_client_id"
export SENTINEL_CLIENT_SECRET="your_secret"
```

Или создайте `.env` файл:

```env
SENTINEL_CLIENT_ID=your_client_id
SENTINEL_CLIENT_SECRET=your_secret
SECRET_KEY=your_jwt_secret_key_here
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

**Важно**: Без credentials система не сможет получать реальные данные.

### JWT Configuration

```env
SECRET_KEY=your_very_secure_secret_key_minimum_32_characters
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

Для генерации безопасного ключа:
```bash
openssl rand -hex 32
```

## 🧪 Тестирование

```bash
# Backend тесты
cd backend
pytest

# Frontend тесты
cd frontend
npm test
```

## 📦 Деплой в Production

### Docker Compose

```bash
# Сборка production образов
docker-compose -f docker-compose.prod.yml build

# Запуск в production режиме
docker-compose -f docker-compose.prod.yml up -d
```

### Environment Variables для Production

```env
# Backend
SENTINEL_CLIENT_ID=your_production_client_id
SENTINEL_CLIENT_SECRET=your_production_secret
SECRET_KEY=strong_random_secret_key
DATABASE_URL=postgresql://user:pass@host:5432/agrosky
CORS_ORIGINS=https://yourdomain.com

# Frontend
VITE_API_URL=https://api.yourdomain.com
```

## 🤝 Вклад в проект

Мы приветствуем вклад в развитие проекта!

1. Fork репозитория
2. Создайте feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit изменений (`git commit -m 'Add some AmazingFeature'`)
4. Push в branch (`git push origin feature/AmazingFeature`)
5. Откройте Pull Request

### Правила разработки

- Следуйте PEP 8 для Python кода
- Используйте ESLint для JavaScript кода
- Добавляйте тесты для новых функций
- Обновляйте документацию
- Пишите понятные commit сообщения

## 📄 Лицензия

MIT License - см. файл [LICENSE](LICENSE)

## 👥 Команда

Проект разработан для хакатона по анализу спутниковых данных.

**Powered by R² negative** - When your models go beyond reality!

## 📞 Контакты

- GitHub: [AgroSky Insight Repository](https://github.com/your-username/agrosky-insight)
- Email: support@agrosky-insight.com
- Telegram: @agrosky_support

## 🙏 Благодарности

- **ESA Copernicus Programme** за открытые данные Sentinel-2
- **Sentinel Hub** за удобный Process API
- **OpenStreetMap** за базовую картографию
- **Open Source сообщество** за замечательные библиотеки
- **FastAPI** за отличный фреймворк
- **React** за мощный UI инструмент
- **Leaflet.js** за картографическую библиотеку

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=your-username/agrosky-insight&type=Date)](https://star-history.com/#your-username/agrosky-insight&Date)

## 📊 Проектная статистика

- **Языки**: Python, JavaScript, CSS
- **Строк кода**: ~15,000+
- **Commits**: 100+
- **Contributors**: 1+ (ждем вас!)
- **Stars**: ⭐ (поставьте звезду!)

---

**Сделано с ❤️ для устойчивого сельского хозяйства и продовольственной безопасности**

### 🌍 Sustainable Development Goals (SDG)

Этот проект поддерживает следующие цели устойчивого развития ООН:
- 🌾 **SDG 2**: Ликвидация голода
- 🌱 **SDG 13**: Борьба с изменением климата
- 🤝 **SDG 17**: Партнерство в интересах устойчивого развития
