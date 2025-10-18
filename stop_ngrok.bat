@echo off
chcp 65001 >nul
echo ========================================
echo 🛑 Остановка ngrok туннеля
echo ========================================
echo.

echo Остановка процессов ngrok...
taskkill /F /IM ngrok.exe >nul 2>&1

if %errorlevel% equ 0 (
    echo ✅ ngrok успешно остановлен
) else (
    echo ⚠️  Процессы ngrok не найдены
)

echo.
echo Готово!
timeout /t 2 /nobreak >nul

