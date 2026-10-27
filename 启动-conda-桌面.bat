@echo off
chcp 65001 >nul 2>&1
setlocal
cd /d "%~dp0"

:: ===== FLASHAI 源码启动（conda 环境 · 原生窗口模式，需 pywebview）=====
set "PY=D:\tools\miniconda3\envs\flashai\python.exe"
set "APP_DIR=%~dp0"
set "FLASHAI_APP_DIR=%APP_DIR%"
set "FLASHAI_DATA_DIR=%APPDATA%\FLASHAI"
set "FLASHAI_PORT=3000"

:: 释放被旧官方 NOVAI 占用的 3000 端口（重名产品，先停旧版）
taskkill /F /IM NOVAI.exe >nul 2>&1

echo [FLASHAI] 正在启动原生桌面窗口...
"%PY%" launcher.py

echo [FLASHAI] 已退出。
pause
