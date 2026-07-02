# Chain Message Board

一个可以直接发布到 GitHub 的 Solidity + Hardhat 3 入门项目。

项目主题：**链上留言板**。用户可以发布留言，作者或合约 owner 可以把留言标记为删除。

> 这是学习项目，不建议未审计就用于主网生产环境。

## 功能

- 发布链上留言
- 查询单条留言
- 分页查询留言
- 作者或 owner 删除留言
- owner 修改最大留言长度
- owner 转移所有权
- Solidity 单元测试
- Hardhat Ignition 部署模块
- GitHub Actions CI

## 技术栈

- Solidity `^0.8.28`
- Hardhat 3
- Hardhat Ignition
- TypeScript
- Viem toolbox

## 项目结构

```text
chain-message-board/
├── contracts/
│   ├── MessageBoard.sol
│   └── MessageBoard.t.sol
├── ignition/
│   └── modules/
│       └── MessageBoard.ts
├── .github/
│   └── workflows/
│       └── ci.yml
├── .env.example
├── .gitignore
├── hardhat.config.ts
├── package.json
├── SECURITY.md
├── tsconfig.json
└── README.md
```

## 环境要求

Hardhat 3 需要 Node.js `22.13.0` 或更高版本。

检查版本：

```bash
node -v
npm -v
```

## 本地运行

安装依赖：

```bash
npm ci
```

如果你想不使用 lock 文件，也可以运行：

```bash
npm install
```

编译合约：

```bash
npm run build
```

运行测试：

```bash
npm test
```

只运行 Solidity 测试：

```bash
npm run test:solidity
```

## 本地部署

直接部署到 Hardhat 的内存网络：

```bash
npm run deploy:local
```

如果你想用持久的本地节点：

终端 1：

```bash
npx hardhat node
```

终端 2：

```bash
npx hardhat ignition deploy ignition/modules/MessageBoard.ts --network localhost
```

## 部署到 Sepolia 测试网

`.env.example` 只是模板。Hardhat 3 的配置变量默认从系统环境变量读取，所以部署前请在命令行设置环境变量。

注意：不要把 `.env`、私钥或助记词上传到 GitHub。

macOS / Linux：

```bash
SEPOLIA_RPC_URL="你的 RPC" SEPOLIA_PRIVATE_KEY="你的私钥" npm run deploy:sepolia
```

Windows PowerShell 示例：

```powershell
$env:SEPOLIA_RPC_URL="你的 RPC"
$env:SEPOLIA_PRIVATE_KEY="你的私钥"
npm run deploy:sepolia
```

## 发布到 GitHub

在项目根目录执行：

```bash
git init
git add .
git commit -m "Initial Solidity message board project"
git branch -M main
git remote add origin https://github.com/你的用户名/chain-message-board.git
git push -u origin main
```

## 合约说明

主合约：`contracts/MessageBoard.sol`

主要函数：

| 函数 | 说明 |
|---|---|
| `postMessage(string content)` | 发布留言 |
| `deleteMessage(uint256 id)` | 删除留言，作者或 owner 可调用 |
| `getMessage(uint256 id)` | 查询单条留言 |
| `getMessages(uint256 offset, uint256 limit)` | 分页查询留言 |
| `setMaxMessageLength(uint256 newMaxMessageLength)` | owner 修改最大留言长度 |
| `transferOwnership(address newOwner)` | owner 转移所有权 |

## 安全提醒

- 这个项目适合学习和作品集展示。
- 不要上传私钥、助记词、`.env` 文件。
- 不要直接用主网真钱测试。
- 真正上线前需要测试、审计和前端安全检查。

## License

MIT
