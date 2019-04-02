# Aadhaar-security-through-blockchain
As the world's largest aadhaar database is centralised and vulnerable to many security threats, this project aims to decentralise the aadhaar database and store it in blocks.
## Installation
Install ganache-cli and solidity compiler
```bash
npm install ganache-cli web3@1.0.0-beta.37
npm install solc
```
## Check ganache
```
node_modules/.bin/ganache-cli

The above command when run in terminal should give the following output

The output should look like below
Ganache CLI v6.3.0 (ganache-core: 2.4.0)
Available Accounts
==================
(0) 0x66d1dda957bc7a087324130c89547ce579cee563 (~100 ETH)
(1) 0xf98e7d03f312c8329d01ef0642b74e77740cc203 (~100 ETH)
(2) 0x71d4ee31cd935d17a2b00b7d8873651d6aefbf73 (~100 ETH)
(3) 0x2fdaa99748e6224e03e3e5a1a9a89abd906df671 (~100 ETH)
(4) 0xfb32d320a858747453ac1b4e23c849fecd6ebf33 (~100 ETH)
(5) 0x2c00cd8a488a8ae569553dfe90bf90d65af97630 (~100 ETH)
(6) 0xa4099d0d4a0e7ce5bf26c3f4078a001daf5cedff (~100 ETH)
(7) 0xa53c14d56683bdc775c19540679b0809bbf95a2b (~100 ETH)
(8) 0x3ba642d43a2a24a0160fa22c358cf697aa4a627f (~100 ETH)
(9) 0x81c43af78fdb4a2c8078ec37875e9616e3c5a3e4 (~100 ETH)
Private Keys
==================
(0) 0xee670c7915b5e73b6f5c82da3919701f19ed1f72a1d4f31007836930623f4a57
(1) 0xf40063c41978799ff6fa4b85d678b0f42ed6c774c35fa883a289fdc7fa0b65cb
(2) 0x5228a5e30d1be11885cd7d44d4a47b1dfa22db4033cd758a1c3677a3a0cb5383
(3) 0x3520c609b830538bd8c5d05c8f53338322411deb477308c5543f20a420fea5ec
(4) 0xa7728cbc1eee41d696cb1d252157fc66ab1726ff751f2132c387726b5c901c35
(5) 0xe459627dc49d59da76c393b40c36c674c8307ec52c24794a33ddc773f3c229fc
(6) 0xa65715e3bdc8236420491de88486ff301a19b624b006811a89742e74120eac50
(7) 0xc95ab6498d506f45b4b8ab2b04967d51e05af41059334df91d63097cb3254a3b
(8) 0xf0619031f2ba4319aae691ce34fe8cce136640fb715b70d5baa045c2d58f1b80
(9) 0x39a85154d16a1eba4a9f8514f187bcb6c8b867b790035afa9f92bf2731aebc5b
HD Wallet
==================

```
## File hashing
We cannot store the database as a whole in blockchain. The blocks have a size limit. So the database have to be splitted into distributed files and each file has to be hashed using IPFS (Interplanetary file system).

## Solidity file
The solidity code to get the hash value of file and to retrieve it is as follows:
```
pragma solidity ^0.4.23;

contract aadhaar_code
{
 string public ipfs_hash;
 
 function sendHash(string memory h) public 
 {
    ipfs_hash = h;
 }
  
 function getHash() public view returns(string memory h)
 {
  return ipfs_hash;
 }
}
```
## Compliation of Solidity code and deployment 
Web.js is used to connect to local or remote ethereum network

```
swarnali@swarnali-Lenovo-G510:/media/swarnali/8016239716238D6A/aadhar/go-ipfs$ node
> Web3 = require('web3')

> web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

> web3.eth.accounts
[ '0x25ce657a8df96023327f52789d8b6a3e267afbd5',
  '0x85b8c4a80731026986817f0ad6855aef7df5b711',
  '0xf10db7ad31318ea06e0036eba57f8a78d8a3593e',
  '0x1c9adcb844d032944447804b258a35ea27d6eb42',
  '0xfdad93f3f3c79533c16e131a173d368d2fce8117',
  '0x01c4ac96274c3f9392787c179250dd4de52554f7',
  '0xdf3ead24f9e0cf27957c74513880a7f91944aa1c',
  '0xa2c5e146b54ae0858abc1aa5eb91b7756f998e40',
  '0x525d05b1d5e3ad887116d6f07b8d94c3139aa3e5',
  '0x27ad85437c794328b6420a4cce94f8e368c373eb' ]

> solc = require('solc')

> code = fs.readFileSync('aadhaar_code.sol').toString()

> compiledCode = solc.compile(code)

> abiDefinition = JSON.parse(compiledCode.contracts[':aadhaar_code'].interface)

> AadhaarContract = web3.eth.contract(abiDefinition)

> byteCode = compiledCode.contracts[':aadhaar_code'].bytecode

> deployedContract =AadhaarContract.new({data: byteCode, from: web3.eth.accounts[0], gas: 4700000})

>  contractInstance = AadhaarContract.at(deployedContract.address)

> contractInstance.sendHash.call(GIVE THE HASH VALUE OF THE FILE AS PARAMETER)

```
## Using Remix
Remix IDE can be accessed using http://remix.ethereum.org


