@echo off
title Stop NIKA

cd /d D:\Nika\nika

echo.
echo ========================================
echo Stopping NIKA Docker containers...
echo ========================================

docker compose stop

echo.
echo Docker containers stopped.
echo.
echo You can close the Wit Proxy window with Ctrl+C.
echo.

pause