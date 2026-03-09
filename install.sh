#!/bin/bash
set -e

echo "🚀 OpenClaw 团队配置安装脚本"
echo "================================"

# 检测操作系统
OS="$(uname -s)"
case "$OS" in
    Linux*)     PLATFORM=linux;;
    Darwin*)    PLATFORM=macos;;
    MINGW*|MSYS*|CYGWIN*)  PLATFORM=windows;;
    *)          echo "❌ 不支持的操作系统: $OS"; exit 1;;
esac

echo "✓ 检测到平台: $PLATFORM"

# 检查是否已安装 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装"
    if [ "$PLATFORM" = "macos" ]; then
        echo "安装方式: brew install node"
    elif [ "$PLATFORM" = "linux" ]; then
        echo "安装方式: curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt-get install -y nodejs"
    fi
    exit 1
fi
echo "✓ Node.js $(node -v)"

# 检查是否已安装 OpenClaw
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw 未安装"
    echo "请先安装: npm install -g openclaw"
    exit 1
fi
echo "✓ OpenClaw 已安装"

# 设置路径
OPENCLAW_DIR="$HOME/.openclaw"
CONFIG_FILE="$OPENCLAW_DIR/openclaw.json"
WORKSPACE_DIR="$OPENCLAW_DIR/workspace"

# 创建必要目录
mkdir -p "$OPENCLAW_DIR"
mkdir -p "$WORKSPACE_DIR"

echo ""
echo "📝 配置 OpenClaw..."

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 检查是否存在 .env 文件
if [ ! -f "$SCRIPT_DIR/config/.env" ]; then
    echo "⚠️  未找到 config/.env 文件"
    echo "请复制 config/.env.example 为 config/.env 并填写配置"
    cp "$SCRIPT_DIR/config/.env.example" "$SCRIPT_DIR/config/.env"
    echo "已为你创建 config/.env，请编辑后重新运行此脚本"
    exit 1
fi

# 加载环境变量（兼容注释行和空行）
while IFS='=' read -r key value; do
    # 跳过注释和空行
    [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
    # 去除空格
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    export "$key=$value"
done < "$SCRIPT_DIR/config/.env"

# 检查必要的环境变量
if [ -z "$LITELLM_BASE_URL" ]; then
    echo "❌ 缺少 LITELLM_BASE_URL 配置"
    exit 1
fi
echo "✓ 环境变量已加载"

# 生成 Gateway Token（如果未提供）
if [ -z "$GATEWAY_AUTH_TOKEN" ]; then
    GATEWAY_AUTH_TOKEN=$(openssl rand -hex 24 2>/dev/null || head -c 48 /dev/urandom | xxd -p | head -c 48)
    echo "🔑 已自动生成 Gateway Token"
fi

# 备份已有配置
if [ -f "$CONFIG_FILE" ]; then
    BACKUP="$CONFIG_FILE.bak.$(date +%Y%m%d%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP"
    echo "📦 已备份原配置: $BACKUP"
fi

# 生成配置文件（兼容 macOS 和 Linux 的 sed）
echo "📄 生成配置文件..."
if [ "$PLATFORM" = "macos" ]; then
    sed -e "s|YOUR_LITELLM_BASE_URL|$LITELLM_BASE_URL|g" \
        -e "s|YOUR_TELEGRAM_BOT_TOKEN|${TELEGRAM_BOT_TOKEN:-}|g" \
        -e "s|YOUR_GATEWAY_AUTH_TOKEN|$GATEWAY_AUTH_TOKEN|g" \
        -e "s|/Users/YOUR_USERNAME|$HOME|g" \
        "$SCRIPT_DIR/config/openclaw.template.json" > "$CONFIG_FILE"
else
    sed -e "s|YOUR_LITELLM_BASE_URL|$LITELLM_BASE_URL|g" \
        -e "s|YOUR_TELEGRAM_BOT_TOKEN|${TELEGRAM_BOT_TOKEN:-}|g" \
        -e "s|YOUR_GATEWAY_AUTH_TOKEN|$GATEWAY_AUTH_TOKEN|g" \
        -e "s|/Users/YOUR_USERNAME|$HOME|g" \
        "$SCRIPT_DIR/config/openclaw.template.json" > "$CONFIG_FILE"
fi
echo "✓ 配置文件已生成: $CONFIG_FILE"

# 复制 workspace 文件（不覆盖已存在的文件）
echo "📁 复制 workspace 文件..."
for f in "$SCRIPT_DIR/workspace/"*; do
    filename=$(basename "$f")
    target="$WORKSPACE_DIR/$filename"
    if [ -f "$target" ]; then
        echo "  ⏭ 跳过已存在: $filename"
    else
        cp "$f" "$target"
        echo "  ✓ 复制: $filename"
    fi
done

echo ""
echo "============================================"
echo "✅ 安装完成！"
echo "============================================"
echo ""
echo "下一步："
echo "  1. 启动 Gateway:  openclaw gateway start"
echo "  2. 查看状态:      openclaw status"
echo "  3. 开始使用:      openclaw chat"
echo ""
echo "Gateway Token: $GATEWAY_AUTH_TOKEN"
echo "请妥善保管此 Token"
