# 🤖 AI Агроном - Руководство по интеграции и использованию

## Обзор

Модуль **AI Агроном** предоставляет интеллектуальный анализ спутниковых данных с использованием Google Gemini LLM. Система генерирует научно обоснованные агрономические рекомендации и отвечает на вопросы фермеров через интерактивный чат.

---

## 📋 Возможности

### 1. Генерация AI отчетов
- Анализ здоровья поля на основе NDVI и других индексов
- Оценка неоднородности и выявление проблемных зон
- Рекомендации по VRA (Variable Rate Application)
- План действий для агронома

### 2. Интерактивный чат (RAG)
- Контекстно-зависимые ответы на вопросы
- Опирается на данные анализа поля
- Профессиональные агрономические консультации

### 3. Интеграция с существующей системой
- Использует результаты зонирования VRA
- Учитывает погодный контекст
- Поддержка множественных индексов (NDVI, EVI, PSRI, NBR, NDSI)

---

## 🚀 Быстрый старт

### Шаг 1: Получение Google Gemini API ключа

1. Перейдите на [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Войдите с Google аккаунтом
3. Создайте новый API ключ
4. Скопируйте ключ

### Шаг 2: Настройка окружения

Создайте файл `.env` в корне проекта (или используйте `env_template.txt`):

```env
# Google Gemini AI API Key
GEMINI_API_KEY=AIzaSyABC123def456GHI789jkl...

# Sentinel Hub (опционально для MOCK режима)
SENTINEL_CLIENT_ID=your-client-id
SENTINEL_CLIENT_SECRET=your-client-secret
SENTINEL_INSTANCE_ID=your-instance-id
```

### Шаг 3: Установка зависимостей

**Backend:**
```bash
cd backend
pip install -r requirements.txt
```

**Frontend:**
```bash
cd frontend
npm install
```

### Шаг 4: Запуск через Docker

```bash
# Из корня проекта
docker compose down
docker compose up --build
```

Приложение будет доступно:
- Frontend: http://localhost:3000
- Backend: http://localhost:8000

### Шаг 5: Проверка AI сервиса

Проверьте статус AI сервиса:
```bash
curl http://localhost:8000/api/v1/ai/health
```

Ожидаемый ответ:
```json
{
  "status": "available",
  "service": "Google Gemini AI",
  "model": "gemini-1.5-pro",
  "message": "AI service is ready"
}
```

---

## 🏗️ Архитектура модуля

### Backend структура

```
backend/
├── api/
│   ├── ai_schemas.py          # Pydantic модели для AI контрактов
│   └── routes.py              # AI эндпоинты (/analysis/ai_report, /analysis/ai_chat)
├── services/
│   └── ai_agronomist.py       # AIAgronomistService с Google Gemini
└── requirements.txt           # google-generativeai==0.3.2
```

### Frontend структура

```
frontend/
├── src/
│   ├── types/
│   │   └── ai.ts              # TypeScript интерфейсы
│   ├── utils/
│   │   └── aiService.js       # API клиент для AI endpoints
│   └── components/
│       ├── AIReportViewer.jsx       # Отображение Markdown отчета
│       ├── AIReportViewer.css
│       ├── AIAgronomistPanel.jsx    # Главный компонент AI панели
│       └── AIAgronomistPanel.css
└── package.json               # react-markdown==9.0.1
```

---

## 🔌 API Endpoints

### 1. Генерация AI отчета

**POST** `/api/v1/analysis/ai_report`

**Request Body:**
```json
{
  "context": {
    "field_info": {
      "name": "Поле Озимые-3",
      "location": {"region": "Калужская область", "lat": 55.1, "lon": 36.6},
      "area_ha": 150.5,
      "crop_type": "Озимая пшеница",
      "sowing_date": "2025-09-01"
    },
    "analysis_info": {
      "date_of_scan": "2025-10-18",
      "satellite": "Sentinel-2"
    },
    "indices_summary": {
      "NDVI": {"mean": 0.55, "std_dev": 0.20, "min": 0.15, "max": 0.85}
    },
    "zonation_results_VRA": {
      "zones": [...]
    }
  }
}
```

**Response:**
```json
{
  "status": "success",
  "report_markdown": "### Отчет Виртуального Агронома\n...",
  "generation_time_seconds": 3.2,
  "model_used": "gemini-1.5-pro"
}
```

### 2. AI Чат

**POST** `/api/v1/analysis/ai_chat`

**Request Body:**
```json
{
  "original_context": {...},
  "chat_history": [
    {"role": "assistant", "content": "Отчет..."},
    {"role": "user", "content": "Какие зоны требуют внимания?"}
  ],
  "new_question": "Как лучше внести азот?"
}
```

**Response:**
```json
{
  "status": "success",
  "answer": "Рекомендую дифференцированное внесение...",
  "generation_time_seconds": 1.5,
  "model_used": "gemini-1.5-pro"
}
```

### 3. Проверка здоровья AI

**GET** `/api/v1/ai/health`

---

## 💻 Использование в React приложении

### Пример интеграции AIAgronomistPanel

```jsx
import React, { useState } from 'react';
import AIAgronomistPanel from './components/AIAgronomistPanel';
import aiService from './utils/aiService';

function MapPage() {
  const [showAIPanel, setShowAIPanel] = useState(false);
  const [analysisContext, setAnalysisContext] = useState(null);

  const handleAnalysisComplete = (stats, zones) => {
    // Построить контекст для AI
    const context = aiService.buildAnalysisContext({
      fieldName: "Мое поле",
      fieldLocation: { region: "Калужская область", lat: 55.1, lon: 36.6 },
      fieldAreaHa: 150.5,
      cropType: "Озимая пшеница",
      sowingDate: "2025-09-01",
      dateOfScan: new Date().toISOString().split('T')[0],
      ndviStats: stats,
      zones: zones
    });

    setAnalysisContext(context);
    setShowAIPanel(true);
  };

  return (
    <div>
      {/* ... карта и анализ ... */}
      
      <button onClick={() => handleAnalysisComplete(stats, zones)}>
        🤖 Консультация AI Агронома
      </button>

      {showAIPanel && analysisContext && (
        <AIAgronomistPanel
          analysisContext={analysisContext}
          onClose={() => setShowAIPanel(false)}
        />
      )}
    </div>
  );
}
```

### Построение контекста вручную

```javascript
const context = {
  field_info: {
    name: "Поле 1",
    location: { region: "Калужская область", lat: 55.1, lon: 36.6 },
    area_ha: 150.5,
    crop_type: "Озимая пшеница",
    sowing_date: "2025-09-01"
  },
  analysis_info: {
    date_of_scan: "2025-10-18",
    satellite: "Sentinel-2"
  },
  indices_summary: {
    NDVI: { mean: 0.55, std_dev: 0.20 }
  },
  zonation_results_VRA: {
    zones: [
      { id: 1, label: "Низкая", area_ha: 20, percentage: 13.3, mean_NDVI: 0.25 },
      // ...
    ]
  }
};
```

---

## 🎯 System Prompts

### Промпт для генерации отчетов

Система использует специализированный промпт для генерации отчетов, который:
- Анализирует данные с учетом типа культуры и фазы роста
- Выявляет неоднородность через стандартное отклонение и зонирование
- Устанавливает причинно-следственные связи с погодой
- Предоставляет практичные VRA рекомендации
- Указывает на необходимость наземного скаутинга

### Промпт для чата (RAG)

Чат-промпт гарантирует:
- Ответы только на основе предоставленных данных
- Профессиональную терминологию
- Указание на недостаток данных для точного ответа
- Запрет на off-topic вопросы

---

## ⚠️ Обработка ошибок

### Типы ошибок

1. **api_timeout** - Превышен таймаут запроса (60-90 сек)
2. **quota_exceeded** - Превышен лимит Gemini API
3. **service_unavailable** - GEMINI_API_KEY не установлен
4. **api_error** - Общая ошибка API

### Пример обработки

```javascript
try {
  const report = await aiService.generateReport(context);
} catch (error) {
  if (error.errorType === 'api_timeout') {
    console.error('AI перегружен, попробуйте позже');
  } else if (error.errorType === 'quota_exceeded') {
    console.error('Превышен лимит запросов');
  }
}
```

---

## 🧪 Тестирование

### Проверка backend

```bash
# Запустите backend
cd backend
python main.py

# В другом терминале
curl -X POST http://localhost:8000/api/v1/analysis/ai_report \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d @test_ai_request.json
```

### Проверка frontend

```bash
cd frontend
npm run dev

# Откройте http://localhost:3000
# Выполните анализ поля → Откройте AI Агронома
```

---

## 📊 Производительность

- **Генерация отчета:** 3-10 секунд (зависит от размера контекста)
- **Ответ в чате:** 1-3 секунды
- **Таймаут:** 60 секунд (чат), 90 секунд (отчет)

---

## 🔐 Безопасность

- API ключи хранятся в `.env` (не коммитьте в Git!)
- Аутентификация пользователя через JWT токены
- Валидация входных данных через Pydantic
- Sanitization Markdown контента перед рендером

---

## 📚 Дополнительные ресурсы

- [Google Gemini API Documentation](https://ai.google.dev/docs)
- [Precision Agriculture Guide](https://en.wikipedia.org/wiki/Precision_agriculture)
- [NDVI Interpretation](https://gisgeography.com/ndvi-normalized-difference-vegetation-index/)

---

## 🐛 Troubleshooting

### AI сервис недоступен
```
Решение: Проверьте GEMINI_API_KEY в .env файле
```

### Таймаут при генерации отчета
```
Решение: Упростите контекст, уменьшите количество зон
```

### Ошибка импорта google.generativeai
```
Решение: pip install google-generativeai==0.3.2
```

---

## 👨‍💻 Разработка и расширение

### Добавление новых индексов

1. Обновите `IndicesSummary` в `ai_schemas.py`
2. Добавьте расчет индекса в `geo_processor.py`
3. Обновите `buildAnalysisContext` в `aiService.js`

### Настройка System Prompts

Промпты находятся в `backend/services/ai_agronomist.py`:
- `SYSTEM_PROMPT_REPORT_GENERATION`
- `SYSTEM_PROMPT_CHAT`

### Смена модели LLM

В `ai_agronomist.py` измените:
```python
self.model_name = "gemini-1.5-pro"  # или gemini-1.5-flash
```

---

## ✅ Чеклист готовности

- [x] Установлен GEMINI_API_KEY
- [x] Backend зависимости установлены
- [x] Frontend зависимости установлены
- [x] Docker контейнеры запущены
- [x] `/api/v1/ai/health` возвращает "available"
- [x] AIAgronomistPanel интегрирован в UI
- [x] Тестовый отчет успешно сгенерирован

---

**Версия модуля:** 1.0.0  
**Последнее обновление:** Октябрь 2025  
**Автор:** AI Development Team

