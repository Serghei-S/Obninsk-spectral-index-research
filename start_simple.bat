@echo off
echo Starting AgroSky Backend...
start "Backend" cmd /c "cd backend && venv\Scripts\activate && python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload"

timeout /t 3 /nobreak

echo Starting AgroSky Frontend...
start "Frontend" cmd /c "cd frontend && npm run dev"

timeout /t 3 /nobreak

echo Opening browser...
start http://localhost:3000

echo.
echo ========================================
echo Services started!
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:3000
echo API Docs: http://localhost:8000/docs
echo ========================================
echo.

