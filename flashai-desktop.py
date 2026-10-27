#!/usr/bin/env python3
"""FLASHAI Desktop — 原生独立窗口"""
import webview
import subprocess
import sys
import time
import os

# 端口跟后端一致：FLASHAI_PORT（默认 3000）；写回环境变量让子进程 FLASHAI.exe 听同一个端口，
# 否则设了 FLASHAI_PORT 时窗口打 3000、后端在别的端口，页面永远打不开。
try:
    PORT = int(os.environ.get("FLASHAI_PORT") or 3000)
except (TypeError, ValueError):
    PORT = 3000
os.environ["FLASHAI_PORT"] = str(PORT)
URL = f"http://127.0.0.1:{PORT}"

# 启动后端服务
exe = os.path.join(os.path.dirname(__file__), "FLASHAI.exe")
if os.path.exists(exe):
    subprocess.Popen([exe], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print(f"启动服务: {exe}")
else:
    print("FLASHAI.exe 未找到，请先运行 build.py 打包")
    sys.exit(1)

# 等待服务就绪
import urllib.request
for _ in range(20):
    try:
        urllib.request.urlopen(URL, timeout=1)
        break
    except:
        time.sleep(0.5)

# 创建原生窗口
window = webview.create_window(
    title="Flash AI",
    url=URL,
    width=1400,
    height=900,
    min_size=(800, 600),
    resizable=True,
    fullscreen=False
)

webview.start()
