# AgroSky Insight - Техническая архитектура

## Общий обзор

AgroSky Insight построен на микросервисной архитектуре с четким разделением ответственности между компонентами.

## Диаграмма архитектуры

```
┌─────────────────────────────────────────────────────────────┐
│                         CLIENT LAYER                        │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         React Application (Port 3000)                │  │
│  │                                                      │  │
│  │  ┌────────────┐  ┌────────────┐  ┌──────────────┐  │  │
│  │  │   MapView  │  │  Sidebar   │  │   Header     │  │  │
│  │  │  (Leaflet) │  │ (Controls) │  │              │  │  │
│  │  └────────────┘  └────────────┘  └──────────────┘  │  │
│  │                                                      │  │
│  │  Services:                                           │  │
│  │  - axios (HTTP client)                               │  │
│  │  - State management (React hooks)                    │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP/JSON
                              │
┌─────────────────────────────▼─────────────────────────────────┐
│                      API GATEWAY LAYER                        │
│                                                               │
│  ┌────────────────────────────────────────────────────────┐  │
│  │         FastAPI Application (Port 8000)                │  │
│  │                                                        │  │
│  │  Endpoints:                                            │  │
│  │  - POST /api/v1/analyze                                │  │
│  │  - GET  /api/v1/status/{id}                            │  │
│  │  - GET  /health                                        │  │
│  │                                                        │  │
│  │  Middleware:                                           │  │
│  │  - CORS                                                │  │
│  │  - Request validation (Pydantic)                       │  │
│  │  - Error handling                                      │  │
│  └────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              │
┌─────────────────────────────▼─────────────────────────────────┐
│                      SERVICE LAYER                            │
│                                                               │
│  ┌──────────────────────┐      ┌────────────────────────┐    │
│  │  SentinelService     │      │   GeoProcessor         │    │
│  │                      │      │                        │    │
│  │  - fetch_data()      │      │  - calculate_ndvi()    │    │
│  │  - _get_access_token()      │  - apply_cloud_mask()  │    │
│  │  - _fetch_real_data()│      │  - calc_statistics()   │    │
│  │  - _generate_mock()  │      │  - generate_viz()      │    │
│  └──────────────────────┘      └────────────────────────┘    │
│           │                                 │                 │
│           │                                 │                 │
└───────────┼─────────────────────────────────┼─────────────────┘
            │                                 │
            │                                 │
┌───────────▼─────────────────────────────────▼─────────────────┐
│                     DATA PROCESSING LAYER                     │
│                                                               │
│  ┌─────────────┐  ┌──────────────┐  ┌──────────────────┐    │
│  │  Rasterio   │  │    NumPy     │  │   Shapely        │    │
│  │  (GeoTIFF)  │  │  (Math ops)  │  │   (Geometry)     │    │
│  └─────────────┘  └──────────────┘  └──────────────────┘    │
│                                                               │
│  ┌─────────────┐  ┌──────────────┐                           │
│  │ Matplotlib  │  │   SciPy      │                           │
│  │ (Visuals)   │  │  (Resample)  │                           │
│  └─────────────┘  └──────────────┘                           │
└───────────────────────────────────────────────────────────────┘
                              │
                              │
┌───────────────────────────▼─────────────────────────────────┐
│                    EXTERNAL DATA LAYER                      │
│                                                             │
│  ┌────────────────────────────────────────────────────┐    │
│  │         Sentinel Hub API                           │    │
│  │         (Sentinel-2 L2A Data)                      │    │
│  │                                                    │    │
│  │  - B04 (Red, 665nm, 10m)                           │    │
│  │  - B08 (NIR, 842nm, 10m)                           │    │
│  │  - SCL (Scene Classification, 20m)                 │    │
│  └────────────────────────────────────────────────────┘    │
│                                                             │
│  Alternative: Mock Data Generator (for testing)             │
└─────────────────────────────────────────────────────────────┘
```

## Слои приложения

### 1. Client Layer (Frontend)

**Технологии:** React 18, Leaflet.js, Vite

**Компоненты:**
- `MapView`: Интерактивная карта с инструментами рисования
- `Sidebar`: Панель управления и отображения статистики
- `Header`: Заголовок приложения

**Ответственность:**
- Визуализация данных
- Взаимодействие с пользователем
- Управление состоянием UI
- HTTP запросы к API

### 2. API Gateway Layer (Backend Router)

**Технологии:** FastAPI, Pydantic

**Endpoints:**

#### POST /api/v1/analyze
```python
Request:
  - geometry: GeoJSON Polygon
  - date_range: [start_date, end_date]

Response:
  - status: "success"
  - image_url: "/results/{uuid}/image.png"
  - bounds: [[lat, lon], [lat, lon]]
  - stats: FieldStats
```

**Ответственность:**
- Валидация входных данных
- Маршрутизация запросов
- Обработка ошибок
- CORS политика

### 3. Service Layer

#### SentinelService

**Файл:** `backend/services/sentinel_service.py`

**Методы:**
```python
async def fetch_data(geometry, date_range) -> Dict[str, np.ndarray]
def _get_access_token() -> str
def _fetch_real_data(...) -> Optional[Dict]
def _generate_mock_data(...) -> Dict
```

**Ответственность:**
- Аутентификация с Sentinel Hub
- Запрос спутниковых данных
- Генерация mock данных для тестирования
- Кэширование токенов

#### GeoProcessor

**Файл:** `backend/services/geo_processor.py`

**Методы:**
```python
def calculate_ndvi(red, nir) -> np.ndarray
def apply_cloud_mask(data, scl) -> np.ndarray
def calculate_statistics(ndvi, geometry) -> FieldStats
def process_field(...) -> Dict
def generate_visualization(...) -> str
```

**Ответственность:**
- Расчет NDVI по формуле (NIR-Red)/(NIR+Red)
- Применение облачной маски через SCL
- Расчет зональной статистики
- Генерация визуализаций с цветовой картой

### 4. Data Processing Layer

**Библиотеки:**

- **Rasterio**: Чтение/запись растровых данных (GeoTIFF)
- **NumPy**: Математические операции над массивами
- **Shapely**: Обработка векторной геометрии
- **Matplotlib**: Генерация изображений с цветовыми картами
- **SciPy**: Ресамплинг данных (SCL 20m → 10m)

### 5. External Data Layer

#### Sentinel Hub API

**Endpoint:** `https://services.sentinel-hub.com`

**Процесс:**
1. OAuth2 аутентификация
2. Запрос данных через evalscript
3. Получение каналов B04, B08, SCL
4. Обработка multipart/form-data ответа

#### Mock Data Generator

Для тестирования без API ключей:
- Генерирует реалистичные паттерны вегетации
- Симулирует облачность (~5%)
- Использует фиксированный seed для воспроизводимости

## Поток данных

### Основной сценарий анализа

```
1. User рисует полигон на карте
   └─> Frontend: MapView.handleCreated()
   
2. Получение GeoJSON координат
   └─> Frontend: onGeometrySelected(geometry)
   
3. User нажимает "Анализировать"
   └─> Frontend: Sidebar.handleAnalyze()
   
4. HTTP POST запрос к /api/v1/analyze
   └─> Backend: routes.analyze_field()
   
5. Валидация входных данных
   └─> Pydantic: AnalysisRequest schema
   
6. Запрос спутниковых данных
   └─> SentinelService.fetch_data()
   └─> Sentinel Hub API / Mock Generator
   
7. Обработка данных
   └─> GeoProcessor.process_field()
       ├─> calculate_ndvi(red, nir)
       ├─> apply_cloud_mask(ndvi, scl)
       └─> calculate_statistics(ndvi)
   
8. Генерация визуализации
   └─> GeoProcessor.generate_visualization()
   └─> Сохранение PNG в /results/{uuid}/
   
9. Формирование ответа
   └─> AnalysisResponse schema
   
10. Отображение результатов
    └─> Frontend: Sidebar (статистика)
    └─> Frontend: MapView (ImageOverlay)
```

## Модель данных

### Geometry (Input)

```json
{
  "type": "Polygon",
  "coordinates": [
    [
      [lon1, lat1],
      [lon2, lat2],
      [lon3, lat3],
      [lon4, lat4],
      [lon1, lat1]
    ]
  ]
}
```

### FieldStats (Output)

```python
@dataclass
class FieldStats:
    area_ha: float                    # Площадь в гектарах
    mean_ndvi: float                  # Средний NDVI [-1, 1]
    capture_date: str                 # Дата съемки
    cloud_coverage_percent: float     # % облачности
    zones_percent: Dict[str, float]   # Распределение по зонам
    valid_pixels_percent: float       # % валидных пикселей
```

### Sentinel-2 Bands

```python
{
    "red": np.ndarray,   # B04, shape (H, W), dtype uint16
    "nir": np.ndarray,   # B08, shape (H, W), dtype uint16
    "scl": np.ndarray    # SCL, shape (H, W), dtype uint8
}
```

## Безопасность

### CORS Configuration

```python
allow_origins = [
    "http://localhost:3000",
    "http://localhost:5173"
]
```

### API Key Management

- Credentials хранятся в environment variables
- Не коммитятся в Git
- Токены кэшируются на время сессии

### Input Validation

- GeoJSON валидация через Pydantic
- Проверка типа геометрии (только Polygon)
- Минимум 3 точки в полигоне
- Валидация дат

## Масштабируемость

### Текущая реализация

- Синхронная обработка запросов
- In-memory хранение результатов
- Single instance deployment

### Планы по масштабированию

1. **Асинхронная обработка**
   - Celery для background tasks
   - Redis для очереди задач

2. **Кэширование**
   - Redis для результатов анализа
   - CDN для статических изображений

3. **База данных**
   - PostgreSQL + PostGIS для хранения результатов
   - История анализов пользователя

4. **Горизонтальное масштабирование**
   - Load balancer (nginx)
   - Несколько инстансов FastAPI
   - Kubernetes оркестрация

## Тестирование

### Backend Tests

```
backend/tests/
├── test_api.py              # API endpoint тесты
├── test_geo_processor.py    # Unit тесты обработки
└── test_sentinel_service.py # Интеграционные тесты
```

### Frontend Tests

```
frontend/src/__tests__/
├── MapView.test.jsx
├── Sidebar.test.jsx
└── App.test.jsx
```

## Deployment

### Docker Architecture

```yaml
services:
  backend:
    - FastAPI app
    - Port 8000
    - Volume: results/
    
  frontend:
    - Vite dev server
    - Port 3000
    - Proxy to backend
```

### Production Considerations

- Use production WSGI server (Gunicorn + Uvicorn workers)
- Nginx reverse proxy
- SSL/TLS certificates
- Environment-based configuration
- Logging и monitoring
- Automated backups

## Мониторинг и логирование

### Логи

```python
import logging

logger = logging.getLogger(__name__)
logger.info("Processing field analysis...")
logger.error("Failed to fetch data", exc_info=True)
```

### Метрики (планируется)

- Request rate
- Response time
- Error rate
- NDVI calculation time
- Data fetch time

---

Документация обновлена: 2024


