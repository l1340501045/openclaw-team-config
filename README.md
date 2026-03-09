# OpenClaw 团队配置包

开箱即用的 OpenClaw 配置，团队成员 clone 后即可快速启动。

## 快速开始

### 1. 安装 OpenClaw

```bash
npm install -g openclaw
```

### 2. Clone 本仓库

```bash
git clone <your-repo-url>
cd team-openclaw-config
```

### 3. 配置环境变量

```bash
cp config/.env.example config/.env
# 编辑 config/.env，填写必要的配置
```

需要配置的变量：
- `LITELLM_BASE_URL`: LiteLLM API 地址
- `LITELLM_API_KEY`: API 密钥（可选，如果需要）
- `TELEGRAM_BOT_TOKEN`: Telegram Bot Token（可选）

### 4. 运行安装脚本

**macOS / Linux:**
```bash
./install.sh
```

**Windows:**
```cmd
install.bat
```

### 5. 启动服务

```bash
openclaw gateway start
openclaw status
```

### 6. 开始使用

```bash
openclaw chat
```

## 配置说明

### 已配置的模型

- **claude-opus-4-6**: 主力模型，最强推理能力
- **claude-sonnet-4-6**: 备用模型，性价比高

切换模型：
```bash
/model litellm/claude-sonnet-4-6
```

### Workspace 文件

- `AGENTS.md`: Agent 行为规范
- `SOUL.md`: Agent 个性和价值观
- `TOOLS.md`: 工具使用说明
- `IDENTITY.md`: Agent 身份信息
- `HEARTBEAT.md`: 心跳检查配置
- `USER.md`: 用户信息模板
- `BOOTSTRAP.md`: 首次启动引导

## 目录结构

```
team-openclaw-config/
├── config/
│   ├── openclaw.template.json   # 配置模板
│   └── .env.example             # 环境变量示例
├── workspace/                   # Workspace 文件
├── install.sh                   # 安装脚本
└── README.md
```

## 注意事项

1. **不要提交敏感信息**：`.env` 文件已在 `.gitignore` 中
2. **个性化配置**：首次运行后可以修改 `USER.md` 和 `IDENTITY.md`
3. **Telegram 可选**：如不需要 Telegram 集成，保持 `channels.telegram.enabled: false`

## 故障排查

查看状态：
```bash
openclaw status --all
```

查看日志：
```bash
openclaw logs --follow
```

重启 Gateway：
```bash
openclaw gateway restart
```

## 更多文档

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [GitHub](https://github.com/openclaw/openclaw)
- [Discord 社区](https://discord.com/invite/clawd)
