# AgroSky Insight - API Examples

Примеры использования API для анализа полей.

## Base URL

```
http://localhost:8000
```

## Аутентификация

API в текущей версии не требует аутентификации (публичный доступ).

---

## Endpoints

### 1. Health Check

Проверка состояния сервера.

**Request:**
```bash
curl http://localhost:8000/health
```

**Response:**
```json
{
  "status": "healthy"
}
```

---

### 2. Analyze Field

Основной endpoint для анализа поля.

#### Пример 1: Базовый анализ

**Request:**
```bash
curl -X POST http://localhost:8000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "geometry": {
      "type": "Polygon",
      "coordinates": [[
        [37.6173, 55.7558],
        [37.6273, 55.7558],
        [37.6273, 55.7458],
        [37.6173, 55.7458],
        [37.6173, 55.7558]
      ]]
    },
    "date_range": ["2023-10-01", "2023-10-15"]
  }'
```

**Response:**
```json
{
  "status": "success",
  "image_url": "/results/a1b2c3d4-e5f6-7890/ndvi_visualization.png",
  "bounds": [[55.7458, 37.6173], [55.7558, 37.6273]],
  "stats": {
    "area_ha": 120.5,
    "mean_ndvi": 0.65,
    "capture_date": "2023-10-14",
    "cloud_coverage_percent": 5.2,
    "zones_percent": {
      "low (<0.3)": 10.0,
      "medium (0.3-0.6)": 30.0,
      "high (>0.6)": 60.0
    },
    "valid_pixels_percent": 94.8
  }
}
```

---

#### Пример 2: Анализ с автоматическим выбором дат

Если не указать `date_range`, используется текущий месяц.

**Request:**
```bash
curl -X POST http://localhost:8000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "geometry": {
      "type": "Polygon",
      "coordinates": [[
        [37.5, 55.75],
        [37.6, 55.75],
        [37.6, 55.70],
        [37.5, 55.70],
        [37.5, 55.75]
      ]]
    }
  }'
```

---

#### Пример 3: Анализ большого поля

**Request:**
```bash
curl -X POST http://localhost:8000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "geometry": {
      "type": "Polygon",
      "coordinates": [[
        [37.5, 55.8],
        [37.7, 55.8],
        [37.7, 55.65],
        [37.5, 55.65],
        [37.5, 55.8]
      ]]
    },
    "date_range": ["2023-09-01", "2023-09-30"]
  }'
```

---

### 3. Get Analysis Status

Получить статус конкретного анализа.

**Request:**
```bash
curl http://localhost:8000/api/v1/status/a1b2c3d4-e5f6-7890
```

**Response:**
```json
{
  "analysis_id": "a1b2c3d4-e5f6-7890",
  "status": "completed",
  "timestamp": "2023-10-14T12:34:56.789Z"
}
```

---

## Python Examples

### Использование с библиотекой `requests`

```python
import requests
import json

# API endpoint
url = "http://localhost:8000/api/v1/analyze"

# Данные запроса
payload = {
    "geometry": {
        "type": "Polygon",
        "coordinates": [[
            [37.6173, 55.7558],
            [37.6273, 55.7558],
            [37.6273, 55.7458],
            [37.6173, 55.7458],
            [37.6173, 55.7558]
        ]]
    },
    "date_range": ["2023-10-01", "2023-10-15"]
}

# Отправка запроса
response = requests.post(url, json=payload)

# Обработка ответа
if response.status_code == 200:
    result = response.json()
    print(f"Анализ успешен!")
    print(f"Средний NDVI: {result['stats']['mean_ndvi']:.3f}")
    print(f"Площадь поля: {result['stats']['area_ha']:.1f} га")
    print(f"Изображение: {result['image_url']}")
else:
    print(f"Ошибка: {response.status_code}")
    print(response.json())
```

### Использование с `aiohttp` (асинхронно)

```python
import aiohttp
import asyncio

async def analyze_field(geometry, date_range):
    url = "http://localhost:8000/api/v1/analyze"
    
    payload = {
        "geometry": geometry,
        "date_range": date_range
    }
    
    async with aiohttp.ClientSession() as session:
        async with session.post(url, json=payload) as response:
            if response.status == 200:
                return await response.json()
            else:
                raise Exception(f"API Error: {response.status}")

# Использование
geometry = {
    "type": "Polygon",
    "coordinates": [[
        [37.6173, 55.7558],
        [37.6273, 55.7558],
        [37.6273, 55.7458],
        [37.6173, 55.7458],
        [37.6173, 55.7558]
    ]]
}

result = asyncio.run(analyze_field(geometry, ["2023-10-01", "2023-10-15"]))
print(f"NDVI: {result['stats']['mean_ndvi']}")
```

---

## JavaScript/Node.js Examples

### Использование с `axios`

```javascript
const axios = require('axios');

const analyzeField = async (geometry, dateRange) => {
  try {
    const response = await axios.post('http://localhost:8000/api/v1/analyze', {
      geometry: geometry,
      date_range: dateRange
    });
    
    console.log('Анализ завершен!');
    console.log(`Средний NDVI: ${response.data.stats.mean_ndvi}`);
    console.log(`Площадь: ${response.data.stats.area_ha} га`);
    
    return response.data;
  } catch (error) {
    console.error('Ошибка анализа:', error.response?.data || error.message);
    throw error;
  }
};

// Использование
const geometry = {
  type: "Polygon",
  coordinates: [[
    [37.6173, 55.7558],
    [37.6273, 55.7558],
    [37.6273, 55.7458],
    [37.6173, 55.7458],
    [37.6173, 55.7558]
  ]]
};

analyzeField(geometry, ["2023-10-01", "2023-10-15"]);
```

### Использование с `fetch`

```javascript
const analyzeField = async (geometry, dateRange) => {
  const response = await fetch('http://localhost:8000/api/v1/analyze', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      geometry: geometry,
      date_range: dateRange
    })
  });
  
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  
  const data = await response.json();
  return data;
};
```

---

## Обработка ошибок

### Ошибка валидации (422)

**Request с неверными данными:**
```bash
curl -X POST http://localhost:8000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "geometry": {
      "type": "Point",
      "coordinates": [37.6173, 55.7558]
    }
  }'
```

**Response:**
```json
{
  "detail": [
    {
      "loc": ["body", "geometry", "type"],
      "msg": "Only Polygon geometry is supported",
      "type": "value_error"
    }
  ]
}
```

### Ошибка обработки (500)

**Response:**
```json
{
  "detail": "Analysis failed: Unable to fetch satellite data"
}
```

### Не найдено (404)

Когда нет подходящих снимков.

**Response:**
```json
{
  "detail": "No suitable Sentinel-2 imagery found for the specified area and date range"
}
```

---

## Интерпретация результатов

### Значения NDVI

| NDVI | Интерпретация |
|------|---------------|
| -1.0 to 0.0 | Вода, снег, облака |
| 0.0 to 0.2 | Голая почва, камни, искусственные объекты |
| 0.2 to 0.4 | Низкая/стрессовая растительность, начало вегетации |
| 0.4 to 0.6 | Средняя растительность |
| 0.6 to 1.0 | Здоровая, густая растительность |

### Зоны распределения

```json
"zones_percent": {
  "low (<0.3)": 10.0,      // Проблемные участки - требуют внимания
  "medium (0.3-0.6)": 30.0, // Нормальное состояние
  "high (>0.6)": 60.0      // Отличное состояние
}
```

### Облачность

```json
"cloud_coverage_percent": 5.2,      // Процент облачных пикселей
"valid_pixels_percent": 94.8        // Процент чистых данных
```

**Рекомендации:**
- `valid_pixels_percent > 80%` - хорошее качество данных
- `valid_pixels_percent < 50%` - рекомендуется выбрать другую дату

---

## Swagger UI

Интерактивная документация доступна по адресу:

```
http://localhost:8000/docs
```

Здесь вы можете:
- Просмотреть все endpoints
- Протестировать запросы
- Увидеть схемы данных
- Скачать OpenAPI спецификацию

---

## Rate Limiting (планируется)

В будущих версиях:
- Free tier: 60 запросов/час
- Pro tier: безлимит

---

## Дополнительная информация

- **Документация:** [README.md](README.md)
- **Архитектура:** [ARCHITECTURE.md](ARCHITECTURE.md)
- **Вклад в проект:** [CONTRIBUTING.md](CONTRIBUTING.md)


