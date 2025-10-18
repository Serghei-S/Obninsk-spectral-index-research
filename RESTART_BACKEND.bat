@echo off
echo ========================================
echo   ПЕРЕЗАПУСК BACKEND С НОВОЙ БД
echo ========================================
echo.
echo Остановка процессов Python...
taskkill /F /IM python.exe >nul 2>&1
timeout /t 2 >nul

echo Удаление старой БД...
if exist backend\agrosky.db del /f backend\agrosky.db

echo.
echo Запуск backend сервера...
cd backend
call venv\Scripts\activate.bat
python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload


