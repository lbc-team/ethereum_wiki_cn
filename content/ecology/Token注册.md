---
title: "Token注册"
date: 2019-10-21T06:32:23+08:00
weight: 9999
menu:
    docs:
      name: "Token注册"
      parent: "ecology"
      identifier: ""
---

在以太坊中注册一个 Token，实际上是在以太坊中部署一个包含 Token 信息的智能合约。目前在以太坊中可以参加两种类型的 Token： ERC20 和 ERC777，其中ERC777内容更丰富且包含 ERC20内容。本文是对 ERC777 的说明，目前不建议大家注册 ERC20 Token。

想必很多同学都已经使用过 [ERC20 创建过代币](https://learnblockchain.cn/2018/01/12/create_token/)，或许已经被老板要求在 ERC20 代币上实现一些附加功能搞的焦头烂额，如果还有选择，一定要选择 ERC777 。

## ERC20 的问题

以下是一个遇到很多次的场景：有一天老板过来找你（开发者），最近存币生息很火，我们也做一个合约吧， 用户打币过来给他计算利息， 看起来是一个很简单的需求，你满口答应说好，结果自己一研究发现，使用 ERC20 标准没办法在合约里记录是谁发过来多少币，从而没法计算利息（因为接收者合约并不知道自己接收到 ERC20 代币）。

> ERC20 标准下，可以通过一个变通的办法，采用两个交易组合完成，方法是：第 1 步：先让用户把要转移的金额用 ERC20 的 approve 授权的存币生息合约（这步通常称为解锁），第 2 步：再次让用户调用存币生息合约的计息函数，计息函数中通过 transferFrom 把代币从用户手里转移的合约内，并开始计息。

同样由于 **ERC20 标准没有一个转账通知机制**，很多 ERC20 代币误转到合约之后，再也没有办法把币转移出来，已经有大量的 ERC20 因为这个原因被锁死，如[锁死的 QTUM](https://etherscan.io/address/0x9a642d6b3368ddc662CA244bAdf32cDA716005BC)，[锁死的 EOS](https://etherscan.io/address/0x86fa049857e0209aa7d9e616f7eb3b3b78ecfdb0) 。

另外一个问题是 **ERC20 转账时，无法携带额外的信息**，例如：我们有一些客户希望让用户使用 ERC20 代币购买商品，因为转账没法携带额外的信息， 用户的代币转移过来，不知道用户具体要购买哪件商品，从而展加了线下额外的沟通成本。

ERC777 很好的解决了这些问题，同时 ERC777 也兼容 ERC20 标准。因此强烈建议新开发的代币使用 ERC777 标准。

ERC777 在 ERC20 的基础上定义了 `send(dest, value, data)` 来转移代币， send 函数额外的参数用来携带其他的信息，send 函数会检查持有者和接收者是否实现了相应的钩子函数，如果有实现（不管是普通用户地址还是合约地址都可以实现钩子函数），则调用相应的钩子函数。

## ERC1820 接口注册表合约

即便是一个普通用户地址，同样可以实现对 ERC777 转账的监听， 听起来有点神奇，其实这是通过 ERC1820 接口注册表合约来是实现的。

> ERC1820 如此的重要，以至于 ERC777 单独把它拆出来作为一个 EIP。

ERC1820 是一个全局的合约，有一个唯一在以太坊链上都相同的合约地址，它总是 `0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24` ，这个合约是通过非常巧妙的方式进行部署的，有兴趣的同学可以阅读 [EIP1820 文档](https://learnblockchain.cn/docs/eips/eip-1820.html)。

ERC 1820 合约的官方实现代码在 [ERC1820 文档](https://learnblockchain.cn/docs/eips/eip-1820.html)可以查阅，这里说明合约实现的主要内容。

ERC1820 合约提过了两个主要接口：

- setInterfaceImplementer(address _addr, bytes32 _interfaceHash, address _implementer)
  用来设置地址（_addr）的接口（_interfaceHash 接口名称的 keccak256 ）由哪个合约实现（_implementer）。
- getInterfaceImplementer(address _addr, bytes32 _interfaceHash) external view returns (address)
  这个函数用来查询地址（_addr）的接口由哪个合约实现。

setInterfaceImplementer 函数会参数信息记录到下面这个 interfaces 映射里：

```
// 记录 地址(第一个键) 的接口（第二个键）的实现地址（第二个值）
mapping(address => mapping(bytes32 => address)) interfaces;
```



相对应的 getInterfaceImplementer () 通过 interfaces 这个 mapping 来获得接口的实现。

ERC777 使用 send 转账时会分别在持有者和接收者地址上使用 ERC1820 的 getInterfaceImplementer 函数进行查询，查看是否有对应的实现合约，ERC777 标准规范里预定了接口及函数名称，如果有实现则进行相应的调用。

## ERC777 标准规范

### ERC777 接口

ERC777 为了在实现上可以兼容 ERC20，除了查询函数和 ERC20 一致外，操作接口均采用的独立的命名（避免相同的命令无法分辨是哪个标准），ERC777 的接口定义如下，要求所有的 ERC777 代币合约都必须实现这些接口：

```solidity
interface ERC777Token {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function balanceOf(address holder) external view returns (uint256);

    // 定义代币最小的划分粒度
    function granularity() external view returns (uint256);

    // 操作员 相关的操作（操作员是可以代表持有者发送和销毁代币的账号地址）
    function defaultOperators() external view returns (address[] memory);
    function isOperatorFor(
        address operator,
        address holder
    ) external view returns (bool);
    function authorizeOperator(address operator) external;
    function revokeOperator(address operator) external;

    // 发送代币
    function send(address to, uint256 amount, bytes calldata data) external;
    function operatorSend(
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    // 销毁代币
    function burn(uint256 amount, bytes calldata data) external;
    function operatorBurn(
        address from,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    // 发送代币事件
    event Sent(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    // 铸币事件
    event Minted(
        address indexed operator,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    // 销毁代币事件
    event Burned(
        address indexed operator,
        address indexed from,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    // 授权操作员事件
    event AuthorizedOperator(
        address indexed operator,
        address indexed holder
    );

    // 撤销操作员事件
    event RevokedOperator(address indexed operator, address indexed holder);
}
```

接口定义在 [openzeppelin 代码库](https://github.com/OpenZeppelin/openzeppelin-contracts) 里找到，路径为：`contracts/token/ERC777/IERC777.sol` 。

### 接口说明与实现约定

所有的 ERC777 合约除了必须实现上述接口，还有一些其他的必须遵守的约定（直接导致了 ERC777 官方文档又长又臭… 哭～）。

ERC777 合约必须要通过 ERC1820 注册 `ERC777Token` 接口，这样任何人都可以查询合约是否是 ERC777 标准的合约，注册方法是：调用 ERC1820 注册合约的 setInterfaceImplementer 方法，参数 _addr 及 _implementer 均是合约的地址，_interfaceHash 是 `ERC777Token` 的 keccak256 哈希值（0xac7fbab5…177054）

如果 ERC777 要实现 ERC20 标准，还必须通过 ERC1820 注册 `ERC20Token` 接口。

#### ERC777 信息说明函数

name ()，symbol ()，totalSupply ()，balanceOf (address) 和含义和在 ERC20 中完全一样。

granularity () 用来定义代币最小的划分粒度（>=1）， 要求必须在创建时设定，之后不可以更改，不管是在铸币、发送还是销毁操作的代币数量，必需是粒度的整数倍。

> granularity 和 ERC20 的 decimals 不一样，decimals 用来定义小数位数，decimals 是 ERC20 可选函数，为了兼容 ERC20 代币，decimals 函数要求必须返回 18。而 granularity 表示的是基于最小位数 (内部存储) 的划分粒度。例如：0.5 个代币存储为 `500,000,000,000,000,000` (0.5 X 10^18)，如果粒度为 2，则最小转账单位是 2（相对于 `500,000,000,000,000,000`）。

#### 操作员

ERC777 定义了一个新的操作员角色，操作员被作为移动代币的地址。 每个地址直观地移动自己的代币，将持有人和操作员的概念分开可以提供更大的灵活性。

> 与 ERC20 中的 approve 、 transferFrom 不同，其未明确定义批准地址的角色。

此外，ERC777 还可以定义默认操作员（默认操作员列表只能在代币创建时定义的，并且不能更改），默认操作员是被所有持有人授权的操作员，这可以为项目方管理代币带来方便，当然认何持有人仍然有权撤销默认操作员。

**操作员相关的函数**：

- defaultOperators (): 获取代币合约默认的操作员列表.
- authorizeOperator (address operator): 设置一个地址作为 msg.sender 的操作员，需要触发 AuthorizedOperator 事件。
- revokeOperator (address operator): 移除 msg.sender 上 operator 操作员的权限， 需要触发 RevokedOperator 事件。
- isOperatorFor (address operator, address holder)： 是否是某个持有者的操作员。

#### 发送代币

ERC777 发送代币 使用以下两个方法：

```solidity
send(address to, uint256 amount, bytes calldata data) external

function operatorSend(
    address from,
    address to,
    uint256 amount,
    bytes calldata data,
    bytes calldata operatorData
) external
```

operatorSend 可以通过参数 `operatorData` 携带操作者的信息，发送代币除了执行对应账户的余额加减和触发事件之外，还有**额外的规定**：

1. 如果持有者有通过 ERC1820 注册 `ERC777TokensSender` 实现接口， 代币合约必须调用其 `tokensToSend` 钩子函数。
2. 如果接收者有通过 ERC1820 注册 `ERC777TokensRecipient` 实现接口， 代币合约必须调用其 `tokensReceived` 钩子函数。
3. 如果有 `tokensToSend` 钩子函数，必须在修改余额状态之前调用。
4. 如果有 `tokensReceived` 钩子函数，必须在修改余额状态之后调用。
5. 调用钩子函数及触发事件时， `data` 和 `operatorData` 必须原样传递，因为 tokensToSend 和 tokensReceived 函数可能根据这个数据取消转账（触发 `revert`）。

**ERC777TokensSender 接口**定义如下：

```solidity
interface ERC777TokensSender {
    function tokensToSend(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external;
}
```



如果持有者希望在转账时收到代币转移通知，就需要在 ERC1820 合约上注册及实现 `ERC777TokensSender` 接口（稍后有案例介绍）。

有一个地方需要注意：对于所有的 ERC777 合约， 一个持有者地址只能注册一个 ERC777TokensSender 接口实现。因此 ERC777TokensSender 实现会被多个 ERC777 合约调用，在 ERC777TokensSender 接口的实现合约里， msg.sender 是 ERC777 合约地址，而不是操作者。

**ERC777TokensRecipient 接口**定义如下：

```solidity
interface ERC777TokensRecipient {
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;
}
```

如果接收者希望在转账时收到代币转移通知，就需要在 ERC1820 合约上注册及实现 `ERC777TokensRecipient` 接口。

如果接收者是一个合约地址， 则必须要注册及实现 `ERC777TokensRecipient` 接口（这样可以防止代币被锁死），如果没有实现，ERC777 代币合约必须 `revert` 回退交易状态。

#### 铸币与销毁

铸币（挖矿）是产生新币的过程，销毁代币则相反，在 ERC20 中，没有明确定义这两个行为，通常会 transfer 方法和 Transfer 事件来表达。
ERC777 则定义了代币从铸币、转移到销毁的整个生命周期。

ERC777 没有定义铸币的方法名，只定义了 Minted 事件，因为很多代币，是在创建的时候就确定好代币的数量。
如果有需要合约可以自己定义铸币函数，铸币函数在实现时要求：

1. 必须触发 Minted 事件
2. 发行量需要加上铸币量， 接收者是不为 0 ，且接收者余额加上铸币量。
3. 如果接收者有通过 ERC1820 注册 ERC777TokensRecipient 实现接口， 代币合约必须调用其 tokensReceived 钩子函数。

ERC777 定义了两个函数用于销毁代币 (`burn` 和 `operatorBurn`)，可以方便钱包和 dapps 有统一的接口交互。`burn` 和 `operatorBurn` 的实现要求：

1. 必须触发 Burned 事件。
2. 总供应量必须减少代币销毁量， 持有者的余额必须减少代币销毁的数量。
3. 如果持有者通过 ERC1820 注册 ERC777TokensSender 实现，必须调用持有者的 tokensToSend 钩子函数。

> 注意，零个代币数量的交易（不管是转移、铸币与销毁）也是合法的，同样满足粒度（granularity) 的整数倍，因此需要正确处理。

## ERC777 代币实现

OpenZeppelin 实现了一个 ERC777 基础合约，要实现自己的 ERC777 代币只需要继承 OpenZeppelin ERC777。想了解 OpenZeppelin 的 ERC777 的实现可阅读 [ERC777 源码解析](https://learnblockchain.cn/2019/09/26/erc777-code/)。

如果大家是 Truffle 开发（或者是 Node 工程），可以使用以下方式安装 OpenZeppelin 合约库：

```bash
npm install @openzeppelin/contracts
```

发行一个 2100 个的 LBC7 代币的代码就很简单了：

```solidity
pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

contract MyERC777 is ERC777 {
    constructor(
        address[] memory defaultOperators
    )
        ERC777("MyERC777", "LBC7", defaultOperators)
        public
    {
        uint initialSupply = 2100 * 10 ** 18;
        _mint(msg.sender, msg.sender, initialSupply, "", "");
    }
}
```

实现主要是两步：通过基类 ERC777 的构造函数确认代币名称、代号以及默认操作员（可为空），然后调用 _mint 初始化发行量，注意发行量的小数位是固定的 18 位（和 ether 保持一致），在合约内部是按小数位保存的，因此发行的币数需要乘上 1018。

## 监听代币收款

我们假设有这样一个需求：寺庙要实现了一个功德箱合约接收捐赠，功德箱合约需要记录每位施主的善款金额。这时候就可以通过**实现 ERC777TokensRecipient 接口**来完成。代码也很简单：

```solidity
pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts/token/ERC777/IERC777.sol";
import "@openzeppelin/contracts/introspection/IERC1820Registry.sol";

contract Merit is IERC777Recipient {

  mapping(address => uint) public givers;
  address _owner;
  IERC777 _token;

  IERC1820Registry private _erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);

  // keccak256("ERC777TokensRecipient")
  bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH =
      0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;

  constructor(IERC777 token) public {
    _erc1820.setInterfaceImplementer(address(this), TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    _owner = msg.sender;
    _token = token;
  }

// 收款时被回调
  function tokensReceived(
      address operator,
      address from,
      address to,
      uint amount,
      bytes calldata userData,
      bytes calldata operatorData
  ) external {
    givers[from] += amount;
  }

// 方丈取回功德箱token
  function withdraw () external {
    require(msg.sender == _owner, "no permision");
    uint balance = _token.balanceOf(address(this));
    _token.send(_owner, balance, "");
  }

}
```

功德箱合约在构造时，调用 ERC1820 注册表合约的 setInterfaceImplementer 函数 注册 ERC777TokensRecipient 接口实现（接口的实现是自身），这样在收到代币时，会回调 tokensReceived 函数，tokensReceived 函数通过 givers 映射来保存每个施主的善款金额。

> 注意： 如果是在本地的开发者网络环境，可能会没有 ERC1820 注册表合约，如果没有需要先部署 ERC1820 注册表合约，参考 [eip-1820 中文文档](https://learnblockchain.cn/docs/eips/eip-1820.html)。

功德箱这个实例仅仅是抛砖引玉，告诉大家如何实现收款时的回调，之后有时间，我写一个完整的存币生息应用。

## 普通账户地址监听代币转出

功德箱合约的例子，收款地址和收款监听是同一个合约， 现在来看看一个普通的用户地址，如何委托一个合约来监听代币的转出。
监听代币的转出可以让持有者对发出去的代币有更多的控制，例如持有者可以设置一些黑名单，禁止操作员对黑名单内账号转账。

相关文章

- [OpenZeppelin ERC777 源码解析](https://learnblockchain.cn/2019/09/26/erc777-code/)
- [使用 ethers.js 开发以太坊 Web 钱包 4 - 发送 Token (代币）](https://learnblockchain.cn/2018/10/26/eth-web-wallet_4/)
- [如何通过以太坊智能合约来进行众筹（ICO）](https://learnblockchain.cn/2018/02/28/ico-crowdsale/)
- [实现一个可管理、增发、兑换、冻结等高级功能的代币](https://learnblockchain.cn/2018/01/27/create-token2/)
- [创建自己的数字货币（ERC20 代币）进行 ICO](https://learnblockchain.cn/2018/01/12/create_token/)