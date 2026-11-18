@echo off

cd /d D:\Nika\nika

echo.
echo ===== Docker status =====
docker compose ps

echo.
echo ===== py-sc-server last logs =====
docker compose logs py-sc-server --since 1m

echo.
pause