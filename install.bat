@echo off
setlocal enabledelayedexpansion

echo 🚀 OpenClaw 团队配置安装脚本 (Windows)
echo ================================

REM 检查是否已安装 OpenClaw
where openclaw >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ OpenClaw 未安装
    echo 请先安装 OpenClaw: npm install -g openclaw
    exit /b 1
)

echo ✓ OpenClaw 已安装

REM 设置路径
set OPENCLAW_DIR=%USERPROFILE%\.openclaw
set CONFIG_FILE=%OPENCLAW_DIR%\openclaw.json
set WORKSPACE_DIR=%OPENCLAW_DIR%\workspace

REM 创建必要目录
if not exist "%OPENCLAW_DIR%" mkdir "%OPENCLAW_DIR%"
if not exist "%WORKSPACE_DIR%" mkdir "%WORKSPACE_DIR%"

echo.
echo 📝 配置 OpenClaw...

REM 检查是否存在 .env 文件
if not exist "config\.env" (
    echo ⚠️  未找到 config\.env 文件
    echo 请复制 config\.env.example 为 config\.env 并填写配置
    exit /b 1
)

REM 读取环境变量
for /f "usebackq tokens=1,2 delims==" %%a in ("config\.env") do (
    set %%a=%%b
)

REM 检查必要的环境变量
if "%LITELLM_BASE_URL%"=="" (
    echo ❌ 缺少 LITELLM_BASE_URL 配置
    exit /b 1
)

echo ✓ 环境变量已加载

REM 生成 Gateway Token（如果未提供）
if "%GATEWAY_AUTH_TOKEN%"=="" (
    set GATEWAY_AUTH_TOKEN=%RANDOM%%RANDOM%%RANDOM%%RANDOM%
    echo 🔑 已生成 Gateway Token: !GATEWAY_AUTH_TOKEN!
)

REM 复制并替换配置文件
echo 📄 生成配置文件...

powershell -Command "(Get-Content config\openclaw.template.json) -replace 'YOUR_LITELLM_BASE_URL', '%LITELLM_BASE_URL%' -replace 'YOUR_TELEGRAM_BOT_TOKEN', '%TELEGRAM_BOT_TOKEN%' -replace 'YOUR_GATEWAY_AUTH_TOKEN', '%GATEWAY_AUTH_TOKEN%' -replace '/Users/YOUR_USERNAME', '%USERPROFILE:\=/%' | Set-Content '%CONFIG_FILE%'"

echo ✓ 配置文件已生成: %CONFIG_FILE%

REM 复制 workspace 文件
echo 📁 复制 workspace 文件...
xcopy /E /I /Y workspace\* "%WORKSPACE_DIR%"
echo ✓ Workspace 文件已复制

echo.
echo ✅ 安装完成！
echo.
echo 下一步：
echo 1. 启动 Gateway: openclaw gateway start
echo 2. 查看状态: openclaw status
echo 3. 开始使用: openclaw chat
echo.
echo Gateway Token: %GATEWAY_AUTH_TOKEN%
echo 请妥善保管此 Token

pause
