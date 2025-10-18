@echo off
chcp 65001 > nul
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║     🚀 ЗАПУСК AGROSKY INSIGHT                          ║
echo ╚════════════════════════════════════════════════════════╝
echo.

REM Проверка и остановка старых процессов
echo [1/4] Остановка старых процессов...
taskkill /F /IM python.exe >nul 2>&1
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 >nul

REM Запуск Backend
echo [2/4] Запуск Backend сервера...
start "AgroSky Backend" cmd /k "cd backend && venv\Scripts\activate && python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload"
timeout /t 5 >nul

REM Запуск Frontend
echo [3/4] Запуск Frontend...
start "AgroSky Frontend" cmd /k "cd frontend && npm run dev"
timeout /t 3 >nul

REM Открытие браузера
echo [4/4] Открытие браузера...
timeout /t 3 >nul
start http://localhost:3000

echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║     ✅ ВСЕ СЕРВИСЫ ЗАПУЩЕНЫ!                          ║
echo ╠════════════════════════════════════════════════════════╣
echo ║  Frontend:  http://localhost:3000                      ║
echo ║  Backend:   http://localhost:8000                      ║
echo ║  API Docs:  http://localhost:8000/docs                 ║
echo ╚════════════════════════════════════════════════════════╝
echo.
pause


