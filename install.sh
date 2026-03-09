#!/bin/bash
set -e

echo "🚀 OpenClaw 团队配置安装脚本"
echo "================================"

# 检查是否已安装 OpenClaw
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw 未安装"
    echo "请先安装 OpenClaw: npm install -g openclaw"
    exit 1
fi

echo "✓ OpenClaw 已安装"

# 获取当前用户名
USERNAME=$(whoami)
OPENCLAW_DIR="$HOME/.openclaw"
CONFIG_FILE="$OPENCLAW_DIR/openclaw.json"
WORKSPACE_DIR="$OPENCLAW_DIR/workspace"

# 创建必要目录
mkdir -p "$OPENCLAW_DIR"
mkdir -p "$WORKSPACE_DIR"

echo ""
echo "📝 配置 OpenClaw..."

# 检查是否存在 .env 文件
if [ ! -f "config/.env" ]; then
    echo "⚠️  未找到 config/.env 文件"
    echo "请复制 config/.env.example 为 config/.env 并填写配置"
    exit 1
fi

# 加载环境变量
source config/.env

# 检查必要的环境变量
if [ -z "$LITELLM_BASE_URL" ]; then
    echo "❌ 缺少 LITELLM_BASE_URL 配置"
    exit 1
fi

echo "✓ 环境变量已加载"

# 生成 Gateway Token（如果未提供）
if [ -z "$GATEWAY_AUTH_TOKEN" ]; then
    GATEWAY_AUTH_TOKEN=$(openssl rand -hex 24)
    echo "🔑 已生成 Gateway Token: $GATEWAY_AUTH_TOKEN"
fi

# 复制并替换配置文件
echo "📄 生成配置文件..."

cat config/openclaw.template.json | \
    sed "s|YOUR_LITELLM_BASE_URL|$LITELLM_BASE_URL|g" | \
    sed "s|YOUR_TELEGRAM_BOT_TOKEN|${TELEGRAM_BOT_TOKEN:-}|g" | \
    sed "s|YOUR_GATEWAY_AUTH_TOKEN|$GATEWAY_AUTH_TOKEN|g" | \
    sed "s|/Users/YOUR_USERNAME|$HOME|g" > "$CONFIG_FILE"

echo "✓ 配置文件已生成: $CONFIG_FILE"

# 复制 workspace 文件
echo "📁 复制 workspace 文件..."
cp -r workspace/* "$WORKSPACE_DIR/"
echo "✓ Workspace 文件已复制"

echo ""
echo "✅ 安装完成！"
echo ""
echo "下一步："
echo "1. 启动 Gateway: openclaw gateway start"
echo "2. 查看状态: openclaw status"
echo "3. 开始使用: openclaw chat"
echo ""
echo "Gateway Token: $GATEWAY_AUTH_TOKEN"
echo "请妥善保管此 Token"
