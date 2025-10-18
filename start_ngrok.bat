@echo off
chcp 65001 >nul
echo ========================================
echo 🚀 Запуск R2-Фермер через ngrok
echo ========================================
echo.

REM Проверка, запущены ли контейнеры Docker
echo 🔍 Проверка Docker контейнеров...
docker ps --filter "name=agrosky" --format "{{.Names}}" | findstr /C:"agrosky" >nul
if %errorlevel% neq 0 (
    echo ⚠️  Контейнеры не запущены. Запускаю Docker...
    docker-compose up -d
    timeout /t 5 /nobreak >nul
) else (
    echo ✅ Контейнеры уже запущены
)

echo.
echo 🔧 Остановка старых процессов ngrok...
taskkill /F /IM ngrok.exe >nul 2>&1

timeout /t 2 /nobreak >nul

echo.
echo 🌐 Запуск ngrok туннеля на порту 8080...
start /MIN ngrok.exe http 8080

echo.
echo ⏳ Ожидание запуска ngrok...
timeout /t 4 /nobreak >nul

echo.
echo ========================================
echo ✅ Получение публичного URL...
echo ========================================
powershell -Command "$tunnels = Invoke-RestMethod -Uri 'http://localhost:4040/api/tunnels'; $url = $tunnels.tunnels[0].public_url; Write-Host ''; Write-Host '🎉 Проект доступен через Интернет!' -ForegroundColor Green; Write-Host ''; Write-Host 'Public URL:' -ForegroundColor Yellow; Write-Host $url -ForegroundColor Cyan; Write-Host ''; Write-Host 'Frontend:     ' -NoNewline; Write-Host $url -ForegroundColor Cyan; Write-Host 'Backend API:  ' -NoNewline; Write-Host ($url + '/api') -ForegroundColor Cyan; Write-Host 'API Docs:     ' -NoNewline; Write-Host ($url + '/docs') -ForegroundColor Cyan; Write-Host ''; Write-Host 'Мониторинг:   http://localhost:4040' -ForegroundColor Gray; Write-Host ''"

echo ========================================
echo.
echo 📝 Инструкции:
echo   - Поделитесь публичным URL с другими
echo   - Для остановки: закройте окно ngrok
echo   - Для перезапуска: запустите этот файл снова
echo.
echo ⚠️  Не закрывайте это окно, пока используете туннель!
echo.
pause

