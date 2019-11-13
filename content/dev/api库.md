---
title: "API库"
date: 2019-10-21T06:41:57+08:00
weight: 5009
menu:
    docs:
      name: "API库"
      parent: "dev"
      identifier: ""
---



以太坊客户端通过一系列基于`JSON-RPC <https://github.com/ethereum/wiki/wiki/JSON-RPC>`_ 的方法与外界进行交互，然而，直接使用JSON-RPC进行交互，会极大增加开发者的负担，比如：

> - JSON-RPC 协议的实现
> - 智能合约的创建交互过程中二进制数据的编码和解码
> - 256位的数字类型
> - 管理命令的支持 - 例如：创建/管理地址，交易签名

一些列的库文件已经被编写好来解决这些问题，允许应用程序的开发者专注于各自的应用，而不被这些底层的协议交互干扰到。



## 前端 JavaScript API



- [Web3.js](https://github.com/ethereum/web3.js/)-以太坊官方提供的以太坊 JS API库。下面是同样具有 web3 能力的 库。
  - [Eth.js](https://github.com/ethjs) - Javascript Web3 alternative
  - [Ethers.js](https://github.com/ethers-io/ethers.js/) - Javascript Web3 alternative, useful utilities and wallet features
  - [light.js](https://github.com/paritytech/js-libs/tree/master/packages/light.js) A high-level reactive JS library optimized for light clients.
  - [Web3Wrapper](https://www.npmjs.com/package/@0xproject/web3-wrapper) - 是对 Web3JS 的TypeScript封装。
  - [Ethereumjs](https://github.com/ethereumjs/) - 以太坊JS社区构建了Javascript工具，以实现以太坊核心技术，协议和API，以帮助开发人员与以太坊网络进行交互并构建自己的应用程序，包含了一系列的以太坊工具库，如 [ethereumjs-util](https://github.com/ethereumjs/ethereumjs-util) and [ethereumjs-tx](https://github.com/ethereumjs/ethereumjs-tx)。
  - [flex-contract](https://github.com/merklejerk/flex-contract) and [flex-ether](https://github.com/merklejerk/flex-ether) Modern, zero-configuration, high-level libraries for interacting with smart contracts and making transactions.
  - [ez-ens](https://github.com/merklejerk/ez-ens) Simple, zero-configuration Ethereum Name Service address resolver.
  - [web3x](https://github.com/xf00f/web3x) - A TypeScript port of web3.js. Benefits includes tiny builds and full type safety, including when interacting with contracts.
  - 下面这些是对 Web3.js 的不同编程语言的实现：
    - Python [Web3.py](https://github.com/ethereum/web3.py)
    - Haskell [hs-web3](https://github.com/airalab/hs-web3)
    - Java [web3j](https://github.com/web3j/web3j)
    - Scala [web3j-scala](https://github.com/mslinn/web3j-scala)
    - Purescript [purescript-web3](https://github.com/f-o-a-m/purescript-web3)
    - PHP [web3.php](https://github.com/sc0Vu/web3.php)
- [Nethereum](https://github.com/Nethereum/) - 跨平台的以太坊开发框架，是以太坊的.Net集成库，允许你通过RPC与 [Go客户端(go-ethereum)](http://ethdoc.cn/ethereum-clients/go-ethereum/index.html#go-ethereum) ， [C++客户端(cpp-ethereum)](http://ethdoc.cn/ethereum-clients/cpp-ethereum/index.html#cpp-ethereum) 或 [Rust客户端(Parity)](http://ethdoc.cn/ethereum-clients/parity/index.html#parity) 客户端进行交互。
- [Drizzle](https://github.com/truffle-box/drizzle-box) - 从前端连接到区块链的Redux库
- [Tasit SDK](https://github.com/tasitlabs/tasitsdk) - 采用React Native开发原生手机DApp的一个JavaScript SDK
- [Subproviders](https://0x.org/docs/tools/subproviders) - 与 [Web3-provider-engine](https://github.com/MetaMask/provider-engine/)结合使用的几个有用的子模块（包括用于向dApp添加Ledger硬件钱包支持的LedgerSubprovider）
- [web3-react](https://github.com/NoahZinsmeister/web3-react) - 用于构建单页以太坊DApp的React框架
- [ethvtx](https://github.com/ticket721/ethvtx) - ethereum-ready & framework-agnostic redux store configuration. [docs](https://ticket721.github.io/ethvtx/)
- [Vortex](https://github.com/Horyus/vortex) - 一个内置Dapp支持的Redux状态库。采用WebSocket实现智能、动态的后台数据刷新。
  支持[Truffle](https://github.com/Horyus/vortex-demo) 和[Embark](https://github.com/Horyus/vortex-demo-embark)。
- Strictly Typed - Javascript替代
  - [elm-ethereum](https://github.com/cmditch/elm-ethereum)
  - [purescript-web3](https://github.com/f-o-a-m/purescript-web3)
- [ChainAbstractionLayer](https://github.com/liquality/chainabstractionlayer) - 使用单一接口实现与不过区块链的通信，支持以太坊。
- [Delphereum](https://github.com/svanas/delphereum) -访问以太坊区块链的Delphi接口，支持跨平台的原生DApp开发：Windows、macOS、iOS以及 Android.
- [ColonyJS](https://github.com/JoinColony/colonyJS) - 一个JavaScript客户端，提供了与Colony网络智能合约交互的API
- [ArcJS](https://github.com/daostack/arc.js) - 一个访问DAOstack Arc以太坊智能合约的JavaScript开发库
- [Arkane Connect](https://docs.arkane.network/pages/connect-js.html) - 一个JavaScript客户端，提供了访问Arkane网络的API以及用于构建DApp的钱包提供器
- [Blocknative](https://blocknative.com/) - Assist.js是一个可嵌入的组件，用于提高DApp的可用性。



## [后端开发包](http://localhost:1313/dev/安全分析.html#后端开发包)

- [Web3.py](https://github.com/ethereum/web3.py) - Python Web3
- [Web3.php](https://github.com/sc0Vu/web3.php) - PHP Web3
- [Ethereum-php](https://github.com/digitaldonkey/ethereum-php) - PHP Web3
- [Web3j](https://github.com/web3j/web3j) - Java Web3
- [Nethereum](https://nethereum.com/) - .Net Web3
- [Ethereum.rb](https://github.com/EthWorks/ethereum.rb) - Ruby Web3
- [Web3.hs](https://hackage.haskell.org/package/web3) - Haskell Web3
- [KEthereum](https://github.com/walleth/kethereum) - Kotlin Web3
- [Pyethereum](https://github.com/ethereum/pyethereum) - 以太坊项目的Python核心库
- [Eventeum](https://github.com/ConsenSys/eventeum) - 以太坊智能合约事件和后台微服务桥接实现，Java实现
- [Ethereumex](https://github.com/mana-ethereum/ethereumex) - Elixir实现的以太坊JSON-RPC 客户端
- [EthContract](https://github.com/AgileAlpha/eth_contract) - 帮助查询以太坊智能合约的Elixir辅助工具包
- [Ethereum Contract Service](https://github.com/mesg-foundation/service-ethereum-contract) - 一个MESG服务，实现与以太坊智能合约的交互
- [Ethereum Service](https://github.com/mesg-foundation/service-ethereum) - 一个MESG服务，监听以太坊事件并与区块链交互



## 以太坊ABI工具

- [ABI decoder](https://github.com/ConsenSys/abi-decoder) - 用于解码以太坊交易中的数据参数和事件的开发库
- [ABI-gen](https://github.com/0xProject/0x-monorepo/tree/v2-prototype/packages/abi-gen) - 基于合约ABI生成TypeScript合约包装类
- [Ethereum ABI UI](https://github.com/hiddentao/ethereum-abi-ui) - 基于合约ABI自动生成用户界面表单
- [headlong](https://github.com/esaulpaugh/headlong/) - 类型安全的合约ABI以及RLP编码Java库
- [One Click dApp](https://oneclickdapp.com/) - 基于ABI即时创建一个DApp并提供访问URL
- [Truffle Pig](https://www.npmjs.com/package/trufflepig) - 一个用于查找和读取Truffle生成的合约构件的开发工具，提供简单的HTTP API。 用于本地开发，通过http提供合约ABI
- [Ethereum Contract Service](https://github.com/mesg-foundation/service-ethereum-contract) - 一个MESG服务，用于访问以太坊合约



## 区块链开发 API 大全

作为一个区块链应用开发者，除了可以利用本地节点的API实现你想要的特性， 还可以借助众多的云端开放API来简化实现或者增强功能。下表为区块链与数字 加密货币领域的开放API：

| API                                                          | 说明                                          | 身份认证 | HTTPS | CORS   |
| :----------------------------------------------------------- | :-------------------------------------------- | :------- | :---- | :----- |
| [Binance](https://github.com/binance-exchange/binance-official-api-docs) | 币安交易所API                                 | apiKey | 是    |        |
| [BitcoinAverage](https://apiv2.bitcoinaverage.com/)          | 区块链数字资产的价格信息API                   | apiKey | 是    |        |
| [BitcoinCharts](https://bitcoincharts.com/about/exchanges/)  | 比特币网络相关的财经与技术数据API             |          | 是    |        |
| [Bitfinex](https://docs.bitfinex.com/docs/introduction)      | bitfinex加密货币交易平台API                   | apiKey | 是    |        |
| [Bitmex](https://www.bitmex.com/app/apiOverview)             | 实时加密货币衍生品交易平台API                 | apiKey | 是    |        |
| [Bittrex](https://bittrex.com/Home/Api)                      | 下一代加密货币交易平台API                     | apiKey | 是    |        |
| [Block](https://www.block.io/docs/basic)                     | 比特币支付、钱包和交易数据API                 | apiKey | 是    |        |
| [Blockchain](https://www.blockchain.info/api)                | 比特币支付、钱包和交易数据API                 |          | 是    |        |
| [Chasing Coin](https://chasing-coins.com/api)                | 数字加密货币、代币数据API                     |          | 是    |        |
| [CoinAPI](https://docs.coinapi.io/)                          | 数字货币交易所和数字资产信息API               | apiKey | 是    | 不支持 |
| [Coinbase](https://developers.coinbase.com/)                 | 比特币、比特币现金、莱特币和以太坊价格信息API | apiKey | 是    |        |
| [Coinbase Pro](https://docs.pro.coinbase.com/#api)           | 数字加密币交易平台API                         | apiKey | 是    |        |
| [CoinBin](https://coinbin.org/)                              | 虚拟货币信息API                               |          | 是    |        |
| [CoinDesk](http://www.coindesk.com/api/)                     | 比特币价格指数API                             |          |       |        |
| [Coinigy](https://coinigy.docs.apiary.io/)                   | Coinigy交易所及账户API                        | apiKey | 是    |        |
| [CoinLayer](https://coinlayer.com/)                          | 数字加密货币实时汇率API                       | apiKey | 是    |        |
| [Coinlore](https://www.coinlore.com/cryptocurrency-data-api) | 数字加密货币价格、流量等信息API               |          | 是    |        |
| [CoinMarketCap](https://coinmarketcap.com/api/)              | 数字加密货币价格API                           |          | 是    |        |
| [Coinpaprika](https://api.coinpaprika.com/)                  | 数字加密货币价格、流量等信息API               |          | 是    | 支持   |
| [CoinRanking](https://docs.coinranking.com/)                 | 实时数字加密货币信息API                       |          | 是    |        |
| [CryptoCompare](https://www.cryptocompare.com/api#)          | 数字加密货币比较API                           |          | 是    |        |
| [Cryptonator](https://www.cryptonator.com/api/)              | 数字加密货币汇率API                           |          | 是    |        |
| [Gemini](https://docs.gemini.com/rest-api/)                  | Gemini交易所API                               |          | 是    |        |
| [ICObench](https://icobench.com/developers)                  | 数字加密货币首次上市、评级、统计等信息API     | apiKey | 是    |        |
| [Livecoin](https://www.livecoin.net/api)                     | 交易所API                                     |          | 是    |        |
| [MercadoBitcoin](https://www.mercadobitcoin.net/api-doc/)    | 巴西的交易所信息API                           |          | 是    |        |
| [Nexchange](https://nexchange2.docs.apiary.io/)              | 数字加密货币自动兑换API                       |          |       | 支持   |
| [NiceHash](https://www.nicehash.com/doc-api)                 | 最大的加密货币矿场API                         | apiKey | 是    |        |
| [Poloniex](https://poloniex.com/support/api/)                | 数字资产交易所API                             | apiKey | 是    |        |
| [WorldCoinIndex](https://www.worldcoinindex.com/apiservice)  | 数字加密货币价格信息API                       | apiKey | 是    |        |
| [Zloader](https://www.zloadr.com/cryptocurrency-developers.php) | 尽职调查数据平台API                           |          |       |        |
