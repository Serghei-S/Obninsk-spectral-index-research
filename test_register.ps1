# Тест регистрации
$uri = "http://localhost:8000/api/v1/auth/register"
$body = @{
    email = "testuser@example.com"
    password = "Pass123456"
} | ConvertTo-Json

Write-Host "`n🧪 ТЕСТИРОВАНИЕ РЕГИСТРАЦИИ`n" -ForegroundColor Magenta

try {
    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/json"
    Write-Host "✅ Регистрация успешна!" -ForegroundColor Green
    Write-Host "Email: $($response.email)" -ForegroundColor Cyan
    Write-Host "ID: $($response.id)" -ForegroundColor Cyan
} catch {
    Write-Host "❌ Ошибка регистрации" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}

# Тест логина
Write-Host "`n🔐 ТЕСТИРОВАНИЕ ВХОДА`n" -ForegroundColor Magenta

$loginUri = "http://localhost:8000/api/v1/auth/login"
try {
    $loginResponse = Invoke-RestMethod -Uri $loginUri -Method Post -Body $body -ContentType "application/json"
    Write-Host "✅ Вход успешен!" -ForegroundColor Green
    Write-Host "Token получен: $($loginResponse.access_token.Substring(0,20))..." -ForegroundColor Cyan
} catch {
    Write-Host "❌ Ошибка входа" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}


