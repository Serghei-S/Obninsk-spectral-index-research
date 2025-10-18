@echo off
echo ==========================================
echo   AgroSky Insight - Статус серверов
echo ==========================================
echo.

echo Проверка Backend (порт 8000)...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8000/docs' -UseBasicParsing -TimeoutSec 5; Write-Host '✅ Backend запущен!' -ForegroundColor Green } catch { Write-Host '❌ Backend не отвечает' -ForegroundColor Red }"

echo.
echo Проверка Frontend (порт 5173)...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:5173' -UseBasicParsing -TimeoutSec 5; Write-Host '✅ Frontend запущен!' -ForegroundColor Green } catch { Write-Host '❌ Frontend не отвечает' -ForegroundColor Red }"

echo.
echo ==========================================
echo   Ссылки для доступа:
echo ==========================================
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend API: http://localhost:8000
echo 📚 API Docs: http://localhost:8000/docs
echo ==========================================
echo.
echo Нажмите любую клавишу для выхода...
pause > nul
