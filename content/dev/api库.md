---
title: "API库"
date: 2019-10-21T06:41:57+08:00
weight: 5001
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





JS 库-**[ethereumjs](https://github.com/ethereumjs/)**

以太坊JS社区构建了Javascript工具，以实现以太坊核心技术，协议和API，以帮助开发人员与以太坊网络进行交互并构建自己的应用程序。

TypeScript库-web3-wrapper](https://0x.org/docs/web3-wrapper)**

是对 Web3JS 的TypeScript封装。

**[Web3.js](https://github.com/ethereum/web3.js/)** 

以太坊官方提供的以太坊 JS API库。并有对应的其他编程语言版本的库：

- Python [Web3.py](https://github.com/ethereum/web3.py)
- Haskell [hs-web3](https://github.com/airalab/hs-web3)
- Java [web3j](https://github.com/web3j/web3j)
- Scala [web3j-scala](https://github.com/mslinn/web3j-scala)
- Purescript [purescript-web3](https://github.com/f-o-a-m/purescript-web3)
- PHP [web3.php](https://github.com/sc0Vu/web3.php)

**[Nethereum](https://nethereum.com/)**

Nethereum是以太坊的.Net集成库，允许你通过RPC与 [Go客户端(go-ethereum)](http://ethdoc.cn/ethereum-clients/go-ethereum/index.html#go-ethereum) ， [C++客户端(cpp-ethereum)](http://ethdoc.cn/ethereum-clients/cpp-ethereum/index.html#cpp-ethereum) 或 [Rust客户端(Parity)](http://ethdoc.cn/ethereum-clients/parity/index.html#parity) 客户端进行交互。











[Sublime Text](http://sublimetext.com/) with [Ethereum plugin](https://packagecontrol.io/packages/Ethereum)

[Webstorm](https://www.jetbrains.com/webstorm/?fromMenu) also has plugins available.

[Remix](https://github.com/ethereum/remix)

[Truffle](https://github.com/ConsenSys/truffle)

[ether.camp](https://live.ether.camp/) Even Microsoft thinks the winds are changing with their online IDE solution