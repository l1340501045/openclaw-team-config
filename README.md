# OpenClaw 团队配置包 - 保姆级教程

> 🎯 **目标**：让完全不懂技术的人也能 10 分钟内启动 AI 助手

支持 **macOS**、**Linux** 和 **Windows** 平台。

---

## 📖 目录

- [这是什么？](#这是什么)
- [我能用它做什么？](#我能用它做什么)
- [开始之前](#开始之前)
- [安装步骤（保姆级）](#安装步骤保姆级)
  - [macOS 用户](#macos-用户)
  - [Windows 用户](#windows-用户)
  - [Linux 用户](#linux-用户)
- [常见问题](#常见问题)
- [进阶配置](#进阶配置)

---

## 这是什么？

**OpenClaw** 是一个开源的 AI 助手框架，可以：
- 在命令行里和 AI 聊天
- 让 AI 帮你写代码、分析文件
- 通过 Telegram 随时随地和 AI 对话
- 自动化执行任务

**这个配置包**是一个开箱即用的模板，让你不用从零配置，直接开始使用。

---

## 我能用它做什么？

✅ **日常对话**：像 ChatGPT 一样聊天  
✅ **代码助手**：写代码、debug、代码审查  
✅ **文件分析**：分析文档、总结内容  
✅ **自动化任务**：定时提醒、批量处理  
✅ **Telegram 集成**：手机上也能用（可选）

---

## 开始之前

### 你需要准备什么？

1. **一台电脑**（macOS / Windows / Linux）
2. **网络连接**
3. **10-15 分钟时间**
4. **LiteLLM API 地址**（问你的团队管理员要）

### 不需要什么？

❌ 不需要懂编程  
❌ 不需要懂命令行（我们会教你）  
❌ 不需要付费（如果团队已有 API）

---

## 安装步骤（保姆级）

### macOS 用户

#### 第 1 步：安装 Homebrew（如果还没装）

1. 打开"终端"应用（在"应用程序" → "实用工具"里）
2. 复制粘贴这行命令，按回车：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. 等待安装完成（可能需要输入电脑密码）

#### 第 2 步：安装 Node.js

在终端里运行：

```bash
brew install node
```

验证安装成功：

```bash
node -v
```

应该显示类似 `v22.15.0` 的版本号。

#### 第 3 步：安装 OpenClaw

```bash
npm install -g openclaw
```

验证安装：

```bash
openclaw --version
```

#### 第 4 步：下载配置包

```bash
cd ~/Documents
git clone https://github.com/l1340501045/openclaw-team-config.git
cd openclaw-team-config
```

#### 第 5 步：配置你的信息

1. 复制配置模板：

```bash
cp config/.env.example config/.env
```

2. 编辑配置文件：

```bash
open -e config/.env
```

3. 在打开的文本编辑器里，修改这一行：

```env
LITELLM_BASE_URL=https://llm.xk-devops.com/v1
```

把 `https://llm.xk-devops.com/v1` 改成你们团队的 API 地址（问管理员要）。

4. 保存并关闭文件（Command + S，然后 Command + Q）

#### 第 6 步：运行安装脚本

```bash
chmod +x install.sh
./install.sh
```

看到 "✅ 安装完成！" 就成功了！

#### 第 7 步：启动服务

```bash
openclaw gateway start
```

#### 第 8 步：开始使用

**方式 1：命令行聊天**

```bash
openclaw chat
```

输入你的问题，按回车，AI 就会回答你！

**方式 2：网页界面**

打开浏览器，访问：`http://127.0.0.1:18789/`

#### 第 9 步：清理安装文件（可选）

安装完成后，配置已经复制到 `~/.openclaw/` 目录，可以删除下载的安装包：

```bash
cd ~/Documents
rm -rf openclaw-team-config
```

以后需要重新安装时，再 `git clone` 即可。

---

### Windows 用户

#### 第 1 步：安装 Node.js

1. 访问 https://nodejs.org/
2. 下载"LTS"版本（推荐版本）
3. 双击安装包，一路"下一步"
4. 安装完成后，重启电脑

#### 第 2 步：验证安装

1. 按 `Win + R`，输入 `cmd`，按回车打开命令提示符
2. 输入：

```cmd
node -v
```

应该显示版本号，比如 `v22.15.0`

#### 第 3 步：安装 OpenClaw

在命令提示符里输入：

```cmd
npm install -g openclaw
```

验证：

```cmd
openclaw --version
```

#### 第 4 步：安装 Git（如果还没装）

1. 访问 https://git-scm.com/download/win
2. 下载并安装
3. 安装时全部选默认选项即可

#### 第 5 步：下载配置包

在命令提示符里：

```cmd
cd %USERPROFILE%\Documents
git clone https://github.com/l1340501045/openclaw-team-config.git
cd openclaw-team-config
```

#### 第 6 步：配置你的信息

1. 复制配置模板：

```cmd
copy config\.env.example config\.env
```

2. 编辑配置文件：

```cmd
notepad config\.env
```

3. 在记事本里，修改这一行：

```env
LITELLM_BASE_URL=https://llm.xk-devops.com/v1
```

把地址改成你们团队的 API 地址。

4. 保存并关闭（Ctrl + S，然后关闭窗口）

#### 第 7 步：运行安装脚本

```cmd
install.bat
```

看到 "✅ 安装完成！" 就成功了！

#### 第 8 步：启动服务

```cmd
openclaw gateway start
```

#### 第 9 步：开始使用

**方式 1：命令行聊天**

```cmd
openclaw chat
```

**方式 2：网页界面**

打开浏览器，访问：`http://127.0.0.1:18789/`

#### 第 10 步：清理安装文件（可选）

安装完成后，可以删除下载的安装包：

```cmd
cd %USERPROFILE%\Documents
rmdir /s /q openclaw-team-config
```

以后需要重新安装时，再 `git clone` 即可。

---

### Linux 用户

#### 第 1 步：安装 Node.js

**Ubuntu / Debian:**

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**其他发行版：**
访问 https://nodejs.org/ 查看安装方法

验证：

```bash
node -v
```

#### 第 2 步：安装 OpenClaw

```bash
npm install -g openclaw
```

验证：

```bash
openclaw --version
```

#### 第 3 步：下载配置包

```bash
cd ~/Documents
git clone https://github.com/l1340501045/openclaw-team-config.git
cd openclaw-team-config
```

#### 第 4 步：配置你的信息

```bash
cp config/.env.example config/.env
nano config/.env  # 或用你喜欢的编辑器
```

修改 `LITELLM_BASE_URL` 为你们团队的地址，保存退出。

#### 第 5 步：运行安装脚本

```bash
chmod +x install.sh
./install.sh
```

#### 第 6 步：启动服务

```bash
openclaw gateway start
```

#### 第 7 步：开始使用

```bash
openclaw chat
```

或访问：`http://127.0.0.1:18789/`

#### 第 8 步：清理安装文件（可选）

安装完成后，可以删除下载的安装包：

```bash
cd ~/Documents
rm -rf openclaw-team-config
```

以后需要重新安装时，再 `git clone` 即可。

---

## 常见问题

### ❓ 提示"command not found"怎么办？

**macOS/Linux:**
```bash
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**Windows:**
重启电脑，或重新打开命令提示符。

### ❓ 安装脚本报错怎么办？

1. 检查 `config/.env` 文件是否正确填写
2. 确认网络连接正常
3. 查看错误信息，通常会提示缺少什么

### ❓ 如何停止服务？

```bash
openclaw gateway stop
```

### ❓ 如何重启服务？

```bash
openclaw gateway restart
```

### ❓ 如何查看状态？

```bash
openclaw status
```

### ❓ 如何更新配置？

1. 编辑 `~/.openclaw/openclaw.json`（macOS/Linux）
   或 `%USERPROFILE%\.openclaw\openclaw.json`（Windows）
2. 重启服务：`openclaw gateway restart`

### ❓ 忘记 Gateway Token 怎么办？

查看配置文件：

**macOS/Linux:**
```bash
cat ~/.openclaw/openclaw.json | grep token
```

**Windows:**
```cmd
type %USERPROFILE%\.openclaw\openclaw.json | findstr token
```

### ❓ 如何切换模型？

在聊天中输入：

```
/model litellm/claude-sonnet-4-6
```

可用模型：
- `litellm/claude-opus-4-6` - 最强，适合复杂任务
- `litellm/claude-sonnet-4-6` - 性价比高，日常使用

### ❓ 如何启用 Telegram？

1. 在 Telegram 找 [@BotFather](https://t.me/botfather)
2. 发送 `/newbot` 创建 Bot
3. 获取 Token
4. 编辑 `config/.env`，填写 `TELEGRAM_BOT_TOKEN`
5. 重新运行 `install.sh` 或 `install.bat`
6. 重启服务

---

## 进阶配置

### 个性化你的 AI 助手

配置文件位置：
- macOS/Linux: `~/.openclaw/workspace/`
- Windows: `%USERPROFILE%\.openclaw\workspace\`

**可以修改的文件：**

| 文件 | 说明 | 示例 |
|------|------|------|
| `USER.md` | 你的个人信息 | 名字、时区、偏好 |
| `IDENTITY.md` | AI 的身份 | 名字、性格、emoji |
| `SOUL.md` | AI 的行为准则 | 如何回答、边界 |
| `TOOLS.md` | 工具配置 | 摄像头名称、SSH 主机 |

### 查看日志

```bash
openclaw logs --follow
```

### 完全卸载

**macOS/Linux:**
```bash
npm uninstall -g openclaw
rm -rf ~/.openclaw
```

**Windows:**
```cmd
npm uninstall -g openclaw
rmdir /s %USERPROFILE%\.openclaw
```

---

## 🆘 需要帮助？

1. **查看官方文档**：https://docs.openclaw.ai
2. **加入 Discord 社区**：https://discord.com/invite/clawd
3. **GitHub Issues**：https://github.com/openclaw/openclaw/issues
4. **联系团队管理员**

---

## 🎉 恭喜！

你已经成功安装了 OpenClaw！现在可以：

- 💬 开始和 AI 聊天
- 📝 让 AI 帮你写代码
- 🤖 探索更多功能

**第一次使用建议：**

试试这些命令：
```
你好，介绍一下你自己
帮我写一个 Python 脚本，打印 Hello World
总结一下这个文件的内容：[拖入文件]
```

祝使用愉快！🚀
