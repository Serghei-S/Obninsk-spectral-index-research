# Contributing to AgroSky Insight

Спасибо за интерес к проекту AgroSky Insight! Мы приветствуем любой вклад.

## Как помочь проекту

### 🐛 Сообщения об ошибках

Если вы нашли баг:
1. Проверьте, что баг еще не был reported в Issues
2. Создайте новый Issue с детальным описанием:
   - Шаги для воспроизведения
   - Ожидаемое поведение
   - Фактическое поведение
   - Скриншоты (если применимо)
   - Версия системы и браузера

### 💡 Предложения улучшений

Есть идея? Создайте Issue с меткой "enhancement" и опишите:
- Какую проблему решает
- Как это должно работать
- Примеры использования

### 🔧 Pull Requests

1. **Fork** репозитория
2. Создайте **feature branch** (`git checkout -b feature/AmazingFeature`)
3. Внесите изменения
4. Добавьте **тесты** (если применимо)
5. Убедитесь, что код проходит **линтеры**:
   ```bash
   # Backend
   cd backend
   black .
   flake8 .
   
   # Frontend
   cd frontend
   npm run lint
   ```
6. **Commit** изменений (`git commit -m 'Add some AmazingFeature'`)
7. **Push** в branch (`git push origin feature/AmazingFeature`)
8. Откройте **Pull Request**

## Стандарты кода

### Python (Backend)

- Следуйте **PEP 8**
- Используйте **type hints**
- Документируйте функции с помощью **docstrings**
- Покрытие тестами > 80%

Пример:
```python
def calculate_ndvi(red: np.ndarray, nir: np.ndarray) -> np.ndarray:
    """
    Calculate NDVI from Red and NIR bands.
    
    Args:
        red: Red band array
        nir: Near-infrared band array
        
    Returns:
        NDVI array with values between -1 and 1
    """
    return (nir - red) / (nir + red)
```

### JavaScript/React (Frontend)

- Используйте **ES6+** синтаксис
- Компоненты - **functional** с hooks
- Именование: **camelCase** для переменных, **PascalCase** для компонентов
- Добавляйте **PropTypes** или TypeScript типы

Пример:
```javascript
function MapView({ onGeometrySelected, analysisResult }) {
  const [selectedArea, setSelectedArea] = useState(null)
  
  // Component logic
  
  return (
    <div className="map-container">
      {/* JSX */}
    </div>
  )
}
```

## Структура коммитов

Используйте **Conventional Commits**:

- `feat:` - новая функциональность
- `fix:` - исправление бага
- `docs:` - изменения в документации
- `style:` - форматирование, отсутствующие точки с запятой и т.д.
- `refactor:` - рефакторинг кода
- `test:` - добавление тестов
- `chore:` - обновление зависимостей, конфигурации и т.д.

Примеры:
```
feat: add temporal analysis of NDVI changes
fix: correct cloud masking for SCL values
docs: update API documentation
```

## Процесс разработки

1. **Issue** создается для обсуждения
2. **Согласование** подхода в комментариях
3. **Разработка** в feature branch
4. **Code review** в Pull Request
5. **Merge** после одобрения

## Тестирование

### Backend тесты

```bash
cd backend
pytest tests/ -v
```

### Frontend тесты

```bash
cd frontend
npm test
```

## Локальная разработка

### Быстрый старт

```bash
# С Docker
docker-compose up --build

# Без Docker
./start.sh  # Linux/Mac
start.bat   # Windows
```

### Backend отдельно

```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
python main.py
```

### Frontend отдельно

```bash
cd frontend
npm install
npm run dev
```

## Вопросы?

Не стесняйтесь задавать вопросы в Issues или Discussions!

---

**Спасибо за вклад в AgroSky Insight! 🌾**


