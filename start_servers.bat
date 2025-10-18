@echo off
title AgroSky Insight - Запуск серверов
color 0A

echo ==========================================
echo   AgroSky Insight - Запуск серверов
echo ==========================================
echo.

echo [1/4] Активация виртуального окружения...
cd backend
call .\venv\Scripts\activate.bat

echo [2/4] Запуск Backend сервера...
start "Backend Server" cmd /k "python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000"

echo [3/4] Ожидание запуска Backend (5 секунд)...
timeout /t 5 /nobreak > nul

echo [4/4] Запуск Frontend сервера...
cd ..\frontend
start "Frontend Server" cmd /k "npm run dev"

echo.
echo ==========================================
echo   Серверы запущены!
echo ==========================================
echo.
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend:  http://localhost:8000
echo 📚 API Docs: http://localhost:8000/docs
echo.
echo Нажмите любую клавишу для выхода...
pause > nul
