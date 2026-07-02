项目主题：**链上留言板**。用户可以发布留言，作者或合约 owner 可以把留言标记为删除。

> 这是学习项目，不建议未审计就用于主网生产环境。
> 
功能
- 发布链上留言
- 查询单条留言
- 分页查询留言
- 作者或 owner 删除留言
- owner 修改最大留言长度
- owner 转移所有权
- Solidity 单元测试
- Hardhat Ignition 部署模块
- GitHub Actions CI

技术栈

- Solidity `^0.8.28`
- Hardhat 3
- Hardhat Ignition
- TypeScript
- Viem toolbox

项目结构

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

| 函数 | 说明 |
|---|---|
| `postMessage(string content)` | 发布留言 |
| `deleteMessage(uint256 id)` | 删除留言，作者或 owner 可调用 |
| `getMessage(uint256 id)` | 查询单条留言 |
| `getMessages(uint256 offset, uint256 limit)` | 分页查询留言 |
| `setMaxMessageLength(uint256 newMaxMessageLength)` | owner 修改最大留言长度 |
| `transferOwnership(address newOwner)` | owner 转移所有权 |
