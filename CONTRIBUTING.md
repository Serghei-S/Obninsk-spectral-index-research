# 🤝 Руководство по внесению вклада

Спасибо за интерес к проекту **R2-Фермер**! Мы рады любому вкладу в развитие платформы.

## 📋 Как внести вклад

### 1. Fork репозитория

Создайте свою копию проекта:
1. Нажмите кнопку **Fork** в правом верхнем углу
2. Клонируйте свой fork локально:
   ```bash
   git clone https://github.com/YOUR_USERNAME/obninsk_final_2.git
   cd obninsk_final_2
   ```

### 2. Создайте ветку для изменений

```bash
git checkout -b feature/your-feature-name
# или
git checkout -b fix/your-bugfix-name
```

**Соглашение об именовании веток:**
- `feature/` — новая функциональность
- `fix/` — исправление багов
- `docs/` — изменения в документации
- `refactor/` — рефакторинг кода
- `test/` — добавление тестов

### 3. Внесите изменения

Следуйте стандартам кодирования (см. ниже).

### 4. Протестируйте изменения

**Backend:**
```bash
cd backend
pytest
```

**Frontend:**
```bash
cd frontend
npm test
```

### 5. Commit изменений

```bash
git add .
git commit -m "feat: добавлена функция экспорта в Excel"
```

**Формат commit сообщений:**
- `feat:` — новая функциональность
- `fix:` — исправление бага
- `docs:` — изменения в документации
- `style:` — форматирование кода
- `refactor:` — рефакторинг
- `test:` — добавление тестов
- `chore:` — обслуживание проекта

### 6. Push в ваш fork

```bash
git push origin feature/your-feature-name
```

### 7. Создайте Pull Request

1. Перейдите на страницу вашего fork на GitHub
2. Нажмите **"New Pull Request"**
3. Выберите ветку с изменениями
4. Заполните описание PR (см. шаблон ниже)
5. Нажмите **"Create Pull Request"**

---

## 📝 Шаблон Pull Request

```markdown
## Описание

Краткое описание изменений.

## Тип изменений

- [ ] 🐛 Исправление бага
- [ ] ✨ Новая функциональность
- [ ] 📚 Обновление документации
- [ ] ♻️ Рефакторинг
- [ ] ✅ Добавление тестов

## Чеклист

- [ ] Код соответствует стандартам проекта
- [ ] Добавлены/обновлены тесты
- [ ] Все тесты проходят
- [ ] Обновлена документация
- [ ] Проверена работа в dev-окружении

## Связанные Issue

Closes #123
```

---

## 🎨 Стандарты кодирования

### Python (Backend)

**Стиль:** PEP 8

```python
# ✅ Хорошо
def calculate_ndvi(red: np.ndarray, nir: np.ndarray) -> np.ndarray:
    """
    Рассчитывает NDVI.
    
    Args:
        red: Красный канал
        nir: Ближний инфракрасный канал
        
    Returns:
        NDVI массив
    """
    with np.errstate(divide='ignore', invalid='ignore'):
        ndvi = (nir - red) / (nir + red)
    return np.nan_to_num(ndvi, nan=-1.0)

# ❌ Плохо
def calc(r,n):
    return (n-r)/(n+r)
```

**Инструменты:**
```bash
# Проверка стиля
pip install flake8 black
flake8 .
black --check .

# Автоформатирование
black .
```

### JavaScript/React (Frontend)

**Стиль:** ESLint + Prettier

```jsx
// ✅ Хорошо
import React, { useState, useEffect } from 'react';

const MapView = ({ geometry, onAnalyze }) => {
  const [isLoading, setIsLoading] = useState(false);
  
  useEffect(() => {
    // Инициализация карты
  }, []);
  
  const handleAnalysis = async () => {
    setIsLoading(true);
    try {
      await onAnalyze(geometry);
    } catch (error) {
      console.error('Ошибка анализа:', error);
    } finally {
      setIsLoading(false);
    }
  };
  
  return <div className="map-view">...</div>;
};

export default MapView;

// ❌ Плохо
const MapView = (props) => {
  let loading = false;
  return <div>...</div>
}
```

**Инструменты:**
```bash
# Проверка стиля
npm run lint

# Автоформатирование
npm run format
```

---

## 🧪 Написание тестов

### Backend тесты

```python
# backend/tests/test_geo_processor.py
import pytest
import numpy as np
from services.geo_processor import calculate_ndvi

def test_calculate_ndvi_basic():
    """Тест базового расчета NDVI."""
    red = np.array([[100, 150]])
    nir = np.array([[200, 250]])
    
    expected = np.array([[0.333, 0.25]], dtype=np.float32)
    result = calculate_ndvi(red, nir)
    
    np.testing.assert_array_almost_equal(result, expected, decimal=3)

def test_calculate_ndvi_zero_division():
    """Тест обработки деления на ноль."""
    red = np.array([[0, 0]])
    nir = np.array([[0, 0]])
    
    result = calculate_ndvi(red, nir)
    
    assert np.all(result == -1.0)
```

### Frontend тесты

```jsx
// frontend/src/components/MapView.test.jsx
import { render, screen, fireEvent } from '@testing-library/react';
import MapView from './MapView';

describe('MapView', () => {
  it('рендерит карту', () => {
    render(<MapView />);
    expect(screen.getByTestId('map-container')).toBeInTheDocument();
  });
  
  it('вызывает onAnalyze при нажатии кнопки', async () => {
    const mockOnAnalyze = jest.fn();
    render(<MapView onAnalyze={mockOnAnalyze} />);
    
    const button = screen.getByText('Анализировать');
    fireEvent.click(button);
    
    expect(mockOnAnalyze).toHaveBeenCalled();
  });
});
```

---

## 📚 Документация

### Docstrings (Python)

Используйте Google Style:

```python
def process_field(geometry: dict, indices: list) -> dict:
    """
    Обрабатывает поле и вычисляет индексы.
    
    Args:
        geometry: GeoJSON геометрия поля
        indices: Список индексов для расчета (например, ['NDVI', 'EVI'])
        
    Returns:
        Словарь с результатами анализа:
        {
            'ndvi': np.ndarray,
            'stats': dict,
            'image_url': str
        }
        
    Raises:
        ValueError: Если геометрия некорректна
        RuntimeError: Если данные недоступны
        
    Example:
        >>> geometry = {"type": "Polygon", "coordinates": [...]}
        >>> result = process_field(geometry, ['NDVI'])
        >>> result['stats']['mean_ndvi']
        0.65
    """
    pass
```

### JSDoc (JavaScript)

```javascript
/**
 * Анализирует поле и возвращает результаты.
 * 
 * @param {Object} geometry - GeoJSON геометрия поля
 * @param {string[]} indices - Массив индексов для расчета
 * @returns {Promise<Object>} Результаты анализа
 * @throws {Error} Если геометрия некорректна
 * 
 * @example
 * const result = await analyzeField(geometry, ['NDVI']);
 * console.log(result.stats.mean_ndvi); // 0.65
 */
async function analyzeField(geometry, indices) {
  // ...
}
```

---

## 🐛 Отчеты об ошибках

При создании Issue об ошибке включите:

1. **Описание проблемы** — что произошло и что ожидалось
2. **Шаги воспроизведения** — как повторить ошибку
3. **Окружение:**
   - ОС (Windows/Linux/Mac)
   - Версия Python / Node.js
   - Браузер (Chrome/Firefox/Safari)
4. **Логи и скриншоты**
5. **Возможное решение** (опционально)

**Шаблон Issue:**

```markdown
## Описание проблемы

При попытке анализа поля вылетает ошибка 500.

## Шаги воспроизведения

1. Зарегистрироваться в системе
2. Нарисовать полигон на карте
3. Нажать "Анализировать поле"
4. Видим ошибку 500

## Окружение

- ОС: Windows 11
- Python: 3.11.5
- Node.js: 18.17.0
- Браузер: Chrome 119

## Логи

```
ERROR: Division by zero in calculate_ndvi
...
```

## Скриншоты

[прикрепите скриншот]
```

---

## ✨ Предложения функций

При создании Issue с предложением включите:

1. **Описание функции** — что она делает
2. **Зачем это нужно** — какую проблему решает
3. **Примеры использования** — как это будет работать
4. **Альтернативы** — рассматривали ли другие варианты

---

## 🔍 Code Review

Ваш Pull Request будет проверен мейнтейнерами проекта. Мы обращаем внимание на:

- ✅ Соответствие стандартам кодирования
- ✅ Покрытие тестами
- ✅ Производительность
- ✅ Безопасность
- ✅ Документация
- ✅ Обратная совместимость

**Будьте готовы:**
- Ответить на вопросы
- Внести правки по запросу
- Обновить PR при конфликтах с main

---

## 🎯 Приоритетные направления

Сейчас особенно приветствуется помощь в:

1. **Тестирование** — увеличение покрытия тестами
2. **Документация** — улучшение README и guides
3. **Производительность** — оптимизация обработки данных
4. **UX** — улучшение интерфейса
5. **Интернационализация** — перевод на английский язык

---

## 💬 Связь

- **GitHub Issues** — вопросы и баги
- **GitHub Discussions** — общие обсуждения
- **Telegram** — @r2farmer_dev (чат разработчиков)
- **Email** — dev@r2farmer.com

---

## 📜 Лицензия

Внося вклад в проект, вы соглашаетесь с тем, что ваш код будет распространяться под лицензией MIT.

---

**Спасибо за ваш вклад! 🌾💚**




