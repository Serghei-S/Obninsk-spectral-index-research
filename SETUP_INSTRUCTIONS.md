# 🚀 Инструкция по установке и запуску AgroSky Insight

## Текущая ситуация

Для запуска проекта необходимо установить зависимости. У вас есть два варианта:

---

## ✅ Вариант 1: Docker (Рекомендуется - БЫСТРЕЕ ВСЕГО)

### Шаг 1: Запустите Docker Desktop

1. Найдите Docker Desktop в меню Пуск Windows
2. Запустите приложение
3. Дождитесь полной загрузки (иконка Docker в трее станет зеленой)

### Шаг 2: Запустите проект

Откройте PowerShell в корне проекта и выполните:

```powershell
docker-compose up --build
```

### Шаг 3: Откройте в браузере

Через 2-3 минуты (время на сборку) откройте:
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000/docs

✅ **Готово!** Проект работает.

---

## Вариант 2: Локальная установка (без Docker)

### Требования:

#### 1. Python 3.11+

**Скачайте и установите:**
https://www.python.org/downloads/

⚠️ **ВАЖНО:** При установке отметьте "Add Python to PATH"

**Проверка установки:**
```powershell
python --version
```

#### 2. Node.js 18+

**Скачайте и установите:**
https://nodejs.org/

**Проверка установки:**
```powershell
node --version
npm --version
```

### Запуск Backend

Откройте PowerShell #1:

```powershell
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
python main.py
```

Backend запустится на http://localhost:8000

### Запуск Frontend

Откройте PowerShell #2 (новое окно):

```powershell
cd frontend
npm install
npm run dev
```

Frontend запустится на http://localhost:3000

---

## 🎯 Быстрая проверка работы

После запуска:

1. Откройте http://localhost:3000
2. Вы должны увидеть карту
3. Нажмите на иконку прямоугольника справа вверху
4. Нарисуйте область на карте
5. Нажмите "Анализировать поле"
6. Через 10-15 секунд увидите результаты

---

## ❌ Решение проблем

### Docker Desktop не запускается

1. Проверьте, включена ли виртуализация в BIOS
2. В Windows: откройте "Turn Windows features on or off"
3. Включите:
   - Hyper-V
   - Windows Subsystem for Linux (WSL2)
4. Перезагрузите компьютер

### Python не найден

После установки Python перезапустите PowerShell или перезагрузите компьютер.

### Ошибки при установке Python пакетов

Если возникают ошибки с GDAL/Rasterio на Windows:

```powershell
pip install pipwin
pipwin install gdal
pipwin install rasterio
pip install -r requirements.txt
```

Или используйте Docker (проще!).

### Frontend не запускается

Очистите кэш:
```powershell
cd frontend
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm install
npm run dev
```

---

## 📞 Нужна помощь?

Если возникли проблемы:
1. Проверьте, что Docker Desktop запущен (для варианта 1)
2. Проверьте, что Python и Node.js установлены (для варианта 2)
3. Убедитесь, что порты 3000 и 8000 свободны

---

**Рекомендация:** Используйте Docker - это самый простой и быстрый способ! Просто запустите Docker Desktop и выполните `docker-compose up --build`.


