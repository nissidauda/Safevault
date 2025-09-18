SafeVault Smart Contract

**SafeVault** is a Clarity smart contract for the Stacks blockchain that enables secure custody of STX.  
It allows users to deposit, manage, and withdraw funds from their own vaults in a trustless and controlled manner.

---

Features
- **Secure Deposits** – Users can deposit STX into their personal vault.
- **Owner-Only Withdrawals** – Funds can only be withdrawn by the vault owner.
- **Balance Tracking** – Each user’s vault balance is tracked individually.
- **Error Handling** – Prevents unauthorized withdrawals, zero-value deposits, or invalid operations.
- **Read-Only Access** – Query balances and vault details without altering contract state.

---

Use Cases
- Personal savings vault for STX.
- Secure escrow for long-term storage.
- Controlled fund management in decentralized applications.
- Building blocks for advanced custody or savings protocols.

---

Functions

Public Functions
- `deposit (amount uint)` → Deposit STX into your SafeVault.
- `withdraw (amount uint)` → Withdraw STX (only by vault owner).

Read-Only Functions
- `get-balance (owner principal)` → Returns the STX balance for a given owner.
- `get-vault (owner principal)` → Returns vault details for a given owner.

---

Deployment
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/safevault.git
   cd safevault
