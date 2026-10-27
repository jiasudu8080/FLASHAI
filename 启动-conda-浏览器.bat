@echo off
chcp 65001 >nul 2>&1
setlocal
cd /d "%~dp0"

:: ===== FLASHAI 源码启动（conda 环境 · 浏览器模式）=====
set "PY=D:\tools\miniconda3\envs\flashai\python.exe"
set "APP_DIR=%~dp0"
set "FLASHAI_APP_DIR=%APP_DIR%"
set "FLASHAI_DATA_DIR=%APPDATA%\FLASHAI"
set "PORT=3000"

:: 释放被旧官方 NOVAI 占用的 3000 端口（重名产品，先停旧版）
taskkill /F /IM NOVAI.exe >nul 2>&1

echo [FLASHAI] 正在启动后端服务（http://127.0.0.1:%PORT%/）...
start "" "%PY%" main.py --port %PORT%

:: 等后端就绪后打开浏览器
timeout /t 4 /nobreak >nul
start http://127.0.0.1:%PORT%/

echo [FLASHAI] 已在浏览器打开。关闭后端控制台窗口即可停止服务。
pause
