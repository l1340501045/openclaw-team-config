# OpenClaw 团队配置包

开箱即用的 OpenClaw 配置，团队成员 clone 后即可快速启动。

支持 **macOS**、**Linux** 和 **Windows** 平台。

---

## 📋 前置要求

### 所有平台

- **Node.js** 18+ (推荐 22+)
- **npm** 或 **pnpm**

### macOS

```bash
# 使用 Homebrew 安装 Node.js
brew install node
```

### Linux (Ubuntu/Debian)

```bash
# 安装 Node.js 22.x
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Windows

1. 下载并安装 [Node.js](https://nodejs.org/)
2. 或使用 [Chocolatey](https://chocolatey.org/):
   ```cmd
   choco install nodejs
   ```

---

## 🚀 快速开始

### 1. 安装 OpenClaw

**所有平台：**
```bash
npm install -g openclaw
```

**验证安装：**
```bash
openclaw --version
```

### 2. Clone 本仓库

```bash
git clone <your-repo-url>
cd team-openclaw-config
```

### 3. 配置环境变量

**macOS / Linux:**
```bash
cp config/.env.example config/.env
nano config/.env  # 或使用你喜欢的编辑器
```

**Windows:**
```cmd
copy config\.env.example config\.env
notepad config\.env
```

**必填配置项：**
```env
LITELLM_BASE_URL=https://llm.xk-devops.com/v1
LITELLM_API_KEY=your_api_key_here  # 如果需要
```

**可选配置项：**
```env
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
GATEWAY_AUTH_TOKEN=  # 留空自动生成
```

### 4. 运行安装脚本

**macOS / Linux:**
```bash
chmod +x install.sh  # 首次需要添加执行权限
./install.sh
```

**Windows:**
```cmd
install.bat
```

**安装脚本会自动：**
- ✓ 检查依赖
- ✓ 生成配置文件
- ✓ 复制 workspace 文件
- ✓ 生成 Gateway Token（如未提供）
- ✓ 备份已有配置（如果存在）

### 5. 启动服务

**所有平台：**
```bash
openclaw gateway start
```

**查看状态：**
```bash
openclaw status
```

### 6. 开始使用

**命令行聊天：**
```bash
openclaw chat
```

**Web 控制台：**
浏览器打开 `http://127.0.0.1:18789/`

---

## 🔧 配置说明

### 已配置的模型

| 模型 | 用途 | 上下文 |
|------|------|--------|
| **claude-opus-4-6** | 主力模型，最强推理能力 | 128k |
| **claude-sonnet-4-6** | 备用模型，性价比高 | 128k |

**切换模型：**
```bash
/model litellm/claude-sonnet-4-6
```

### Workspace 文件说明

| 文件 | 说明 |
|------|------|
| `AGENTS.md` | Agent 行为规范和工作流程 |
| `SOUL.md` | Agent 个性、价值观和边界 |
| `TOOLS.md` | 工具使用说明和本地配置 |
| `IDENTITY.md` | Agent 身份信息（名字、emoji 等） |
| `HEARTBEAT.md` | 心跳检查配置（定期任务） |
| `USER.md` | 用户信息模板 |
| `BOOTSTRAP.md` | 首次启动引导 |

**首次使用建议：**
1. 编辑 `~/.openclaw/workspace/USER.md` 填写你的信息
2. 编辑 `~/.openclaw/workspace/IDENTITY.md` 自定义 Agent 身份
3. 根据需要调整 `SOUL.md` 中的个性设置

---

## 📁 目录结构

```
team-openclaw-config/
├── config/
│   ├── openclaw.template.json   # 配置模板
│   └── .env.example             # 环境变量示例
├── workspace/                   # Workspace 文件
│   ├── AGENTS.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── IDENTITY.md
│   ├── HEARTBEAT.md
│   ├── USER.md
│   └── BOOTSTRAP.md
├── install.sh                   # macOS/Linux 安装脚本
├── install.bat                  # Windows 安装脚本
├── .gitignore
└── README.md
```

---

## ⚠️ 注意事项

### 安全

1. **不要提交敏感信息**：`.env` 文件已在 `.gitignore` 中
2. **保管好 Gateway Token**：安装脚本会生成并显示，请妥善保存
3. **API Key 安全**：不要在公开仓库中暴露 API Key

### 个性化

- 首次运行后可以修改 `~/.openclaw/workspace/` 下的文件
- 配置文件位于 `~/.openclaw/openclaw.json`
- 不要直接修改仓库中的 workspace 文件（除非要更新团队模板）

### Telegram 集成（可选）

如不需要 Telegram 集成，保持配置中的 `channels.telegram.enabled: false`

如需启用：
1. 通过 [@BotFather](https://t.me/botfather) 创建 Bot
2. 获取 Bot Token
3. 在 `.env` 中填写 `TELEGRAM_BOT_TOKEN`
4. 重新运行安装脚本

---

## 🐛 故障排查

### 查看详细状态

```bash
openclaw status --all
```

### 查看实时日志

```bash
openclaw logs --follow
```

### 重启 Gateway

```bash
openclaw gateway restart
```

### 常见问题

**Q: 提示 "openclaw: command not found"**
- 确认 Node.js 已安装：`node -v`
- 确认 npm 全局路径在 PATH 中
- macOS/Linux: 检查 `~/.zshrc` 或 `~/.bashrc`
- Windows: 重启终端或重新登录

**Q: 安装脚本提示权限错误 (macOS/Linux)**
```bash
chmod +x install.sh
```

**Q: Gateway 启动失败**
- 检查端口 18789 是否被占用
- 查看日志：`openclaw logs`
- 尝试重启：`openclaw gateway restart`

**Q: 模型调用失败**
- 检查 `LITELLM_BASE_URL` 是否正确
- 检查网络连接
- 查看 Gateway 日志确认错误信息

---

## 📚 更多资源

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [GitHub 仓库](https://github.com/openclaw/openclaw)
- [Discord 社区](https://discord.com/invite/clawd)
- [技能市场](https://clawhub.com)

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 改进团队配置。

**更新团队模板：**
1. 修改 `workspace/` 或 `config/` 下的文件
2. 提交并推送到仓库
3. 团队成员重新运行安装脚本即可同步

---

## 📄 许可证

本配置包基于 OpenClaw 项目，遵循其开源许可证。
