# Design Decisions - Cryptonino (CTN)

## 1. Project Goal
Create an ERC20 token called **Cryptonino (CTN)** deployed on the **Arbitrum** network to minimize transaction costs, and send all the initial supply to my own **Metamask** wallet, ensuring exclusive and decentralized control.

## 2. Network Choice: Arbitrum
- **Reason:** Arbitrum is a Layer 2 solution on Ethereum that offers much lower gas fees than the main network, while keeping Ethereum's security.
- **Advantage:** It allows deploying and transferring the token with minimal costs, ideal for a personal or test project.

## 3. Wallet: Metamask
- **Reason:** Metamask is one of the most decentralized and widely used wallets. It gives full control over private keys, ensuring that only I have access to the funds.
- **Use:** It will be used to deploy the contract, receive the initially minted tokens, and later manage and transfer the CTN.

## 4. Solidity Version: 0.8.30
- **Reason:** The latest stable Solidity version (0.8.30) is chosen to benefit from the newest security improvements, bug fixes, and compiler optimizations.
- **Impact:** It reduces the chance of known vulnerabilities from older versions and ensures compatibility with modern development practices.

## 5. OpenZeppelin Library: ERC20
- **Reason:** OpenZeppelin is the industry standard for secure and audited contracts. Its ERC20 implementation is used by projects like Uniswap, Aave, etc.
- **Advantages:**
  - Code is production-tested and audited.
  - Saves time and effort by not having to rewrite standard functions.
  - Minimizes the risk of bugs or manual errors.
- **Implementation:** The contract imports `@openzeppelin/contracts/token/ERC20/ERC20.sol` and inherits from it in `Cryptonino`.

## 6. Initial Supply and Automatic Mint
- **Amount:** 9,000,000 CTN (expressed as `9000000 * 1e18` to handle the standard 18 decimals).

- **Receiver:** The constructor uses `_mint(msg.sender, ...)`, which assigns all minted tokens to the address that deploys the contract.

- **Advantage:** There is no need to explicitly write the wallet address; the contract automatically detects the deployer (my MetaMask wallet), simplifying the process and avoiding errors when copying addresses.

## 7. Security and Best Practices

- The latest Solidity version and official audited libraries are used.
- The contract is simple and inherits the full functionality from OpenZeppelin, reducing the attack surface.
- Custom modifications that could introduce vulnerabilities are avoided.

## 8. Deployment Process

1. Set up MetaMask with the Arbitrum network.
2. Fund the wallet with ETH on Arbitrum to pay for gas.
3. Compile and deploy the contract using tools like Remix, Hardhat, or Truffle.
4. Verify the contract on the Arbitrum block explorer (Arbiscan) for transparency.

## 9. After Deployment

- The 9 million CTN will automatically be in my MetaMask wallet.
- I can then make transfers, approvals, and any standard ERC20 operations.

# Design Decisions (Plain Text)

1) **Why the supply is fixed**

The total supply is defined in the constructor and 9,000,000 tokens are minted to the deploying account. We chose a fixed supply for economic predictability, to avoid inflation from later minting, and to simplify auditing and reasoning about the initial distribution.

2) **Why minting only happens in the constructor**  

Limiting minting to the constructor removes later minting functions and reduces the attack surface (no public/external functions can create new tokens). Also, it makes the total amount immutable from the moment of deployment.

3) **Why there is no owner**

No `owner` or administrative controls are included: this is a deliberate choice to minimize powerful privileges and avoid risks of centralization and errors in admin logic. This simplifies security and makes the contract more predictable.

4) **Why use OpenZeppelin**

We use the well-tested and widely audited `ERC20` implementation from :contentReference[oaicite:0]{index=0} because of its robustness, compatibility, and community maintenance. Reusing standard code reduces the risk of bugs and vulnerabilities in critical ERC-20 functions.

5) **What the contract cannot do**
  
- Cannot mint outside the constructor (no public `mint` function exists).  
- Has no explicit burn mechanism.  
- Has no pause functionality or administrative roles.  
- Does not support advanced features (taxes, staking, snapshots, ERC-777, ERC-4626).  
- Does not manage whitelists/blacklists of accounts.