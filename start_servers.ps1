# Запуск серверов AgroSky Insight
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   AgroSky Insight - Запуск серверов" -ForegroundColor Cyan  
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Запуск Backend
Write-Host "🚀 Запуск Backend сервера..." -ForegroundColor Yellow
Set-Location backend
& .\venv\Scripts\Activate.ps1
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000"

# Ожидание
Write-Host "⏳ Ожидание запуска Backend (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Запуск Frontend  
Write-Host "🚀 Запуск Frontend сервера..." -ForegroundColor Yellow
Set-Location ..\frontend
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; npm run dev"

# Ожидание
Write-Host "⏳ Ожидание запуска Frontend (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Проверка статуса
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Проверка статуса серверов" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri 'http://localhost:8000/docs' -UseBasicParsing -TimeoutSec 5
    Write-Host "✅ Backend запущен на http://localhost:8000" -ForegroundColor Green
} catch {
    Write-Host "❌ Backend не отвечает" -ForegroundColor Red
}

try {
    $response = Invoke-WebRequest -Uri 'http://localhost:5173' -UseBasicParsing -TimeoutSec 5
    Write-Host "✅ Frontend запущен на http://localhost:5173" -ForegroundColor Green
} catch {
    Write-Host "❌ Frontend не отвечает" -ForegroundColor Red
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Ссылки для доступа:" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🌐 Frontend: http://localhost:5173" -ForegroundColor White
Write-Host "🔧 Backend:  http://localhost:8000" -ForegroundColor White  
Write-Host "📚 API Docs: http://localhost:8000/docs" -ForegroundColor White
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Нажмите любую клавишу для выхода..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
