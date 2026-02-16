# Test Plan — Cryptonino (CTN)

## 1. General Information

**Contract name:** Cryptonino
**Symbol:** CTN
**Standard:** ERC-20
**Network:** Arbitrum
**Status:** Deployed on mainnet
**Initial supply:** 9,000,000 CTN (18 decimals)
**Mint:** Single mint in the constructor
**Owner / Roles:** None
**Base library:** OpenZeppelin ERC20

---

## 2. Test Plan Objective

Validate that the Cryptonino contract:

* Strictly complies with the ERC-20 standard.
* Respects the declared design decisions (fixed supply, no owner, no post-deploy mint).
* Is traceable, verifiable, and auditable on-chain.
* Does not expose implicit or undocumented functionality.
* Has a minimal attack surface.

---

## 3. Scope

### Included

* Deployment and on-chain verification.
* Supply and mint-related events.
* ERC-20 transfers.
* Approve / transferFrom flows.
* Negative test cases.
* Applicable security analysis.
* Evidence and traceability.

### Excluded

* Frontend or UX.
* Wallet security.
* Phishing, social engineering, or user mistakes.
* External integrations (DEXs, bridges, etc.).

---

## 4. Test Strategy

* **Type:** Functional + Basic security + On-chain evidence.
* **Level:** Smart contract.
* **Source of truth:** Blockchain (Arbiscan, receipts, logs).
* **Criteria:** Direct verification by reading contract state and events.

---

## 5. Deployment Tests

**Objective:**
Confirm that the contract was deployed correctly and is operational.

**Covered cases:**

* The contract has a valid address on Arbitrum.
* The deployment transaction was mined (status = success).
* Bytecode exists at the contract address.
* totalSupply() returns 9_000_000 * 1e18.
* balanceOf(deployer) == totalSupply.

---

## 6. Supply Tests

**Objective:**
Validate supply immutability and correct initial allocation.

**Covered cases:**

* The supply is defined only once in the constructor.
* The Transfer(address(0), deployer, totalSupply) event exists.
* The supply does not change after transfers.
* There is no public function that allows additional minting.
* The ABI does not contain mint, burn, owner, pause, or role-based functions.

---

## 7. Transfer Tests

**Objective:**
Validate standard ERC-20 transfer behavior.

**Covered cases:**

* Valid transfer between two accounts.
* Correct balance updates.
* Emission of the Transfer event.
* Transfer of value 0 (standard edge case).
* Transfer greater than balance (revert).
* Transfer to address(0) (revert).

---

## 8. Approve / transferFrom Tests

**Objective:**
Validate the allowance system according to ERC-20.

**Covered cases:**

* approve correctly sets the allowance.
* Emission of the Approval event.
* transferFrom respects balances and allowance.
* Correct allowance decrement.
* transferFrom without allowance (revert).
* Allowance overwrite behavior (OpenZeppelin standard).
* Documentation of the safe pattern against race conditions.

---

## 9. Negative Tests

**Objective:**
Confirm that the contract fails correctly on invalid usage.

**Covered cases:**

* Transfer with insufficient balance.
* transferFrom without allowance.
* Transfer to 0x0.
* Calls to non-existent functions (mint, burn, pause).
* Confirmation of complete absence of owner or roles.

---

## 10. Security Tests

**Objective:**
Evaluate applicable risks for the contract.

**Evaluations:**

* Reentrancy: Not applicable (no external calls).
* Overflow / Underflow: Not applicable (Solidity ≥ 0.8.x).
* Malicious inflation: Not applicable (mint only in constructor).
* Privilege escalation: Not applicable (no owner).
* Front-running / phishing: Out of contract scope (documented as UX risk).

---

## 11. On-Chain Verification

**Objective:**
Ensure transparency and auditability.

**Covered cases:**

* The contract is verified on Arbiscan.
* The verified code matches the GitHub repository.
* Solidity version and imports match the declared configuration.
* Constructor parameters are correct.

---

## 12. Required Evidence

The repository must include:

* Contract address.
* Deployment transaction hash.
* Arbiscan verification link.
* Relevant receipts (deployment, transfers).
* Event logs (Transfer, Approval).
* Updated docs/deployment.md.
* docs/design-decisions.md.
* This test-plan.md.

---

## 13. Acceptance Criteria (QA Sign-off)

The Cryptonino (CTN) contract is considered APPROVED if:

* The supply is fixed and verifiable on-chain.
* The contract has no hidden administrative functions.
* All ERC-20 operations work according to the standard.
* The code is fully traceable on-chain.
* The documentation allows understanding the project without external context.

---

## Notes

This project demonstrates:

* Defensive design criteria.
* Conscious removal of privileges.
* Testing focused on real risks.
* Understanding of the ERC-20 standard and its attack surface.
* Ability to document and audit contracts deployed on a live network.
