@echo off
title NIKA Launcher

cd /d D:\Nika\nika

echo.
echo ========================================
echo Starting Docker containers...
echo ========================================

docker compose up -d --no-build

echo.
echo Waiting for problem-solver to become healthy...
echo.

:wait_health
for /f "tokens=*" %%i in ('docker inspect -f "{{.State.Health.Status}}" nika-problem-solver 2^>nul') do set HEALTH=%%i

if not "%HEALTH%"=="healthy" (
    echo Current status: %HEALTH%
    timeout /t 5 /nobreak >nul
    goto wait_health
)

echo.
echo problem-solver is healthy.
echo Restarting py-sc-server...
docker compose restart py-sc-server

echo.
echo Starting Wit.ai compatibility proxy...

start "NIKA Wit Proxy" cmd /k "cd /d D:\Nika\nika && python wit_proxy.py"

echo.
echo Waiting for NIKA UI...
timeout /t 5 /nobreak >nul

echo.
echo Opening NIKA in browser...
start http://localhost:3033

echo.
echo ========================================
echo NIKA is running.
echo ========================================
echo.
echo Do not close the "NIKA Wit Proxy" window while using NIKA.
echo.

pause