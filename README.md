 Proof of Payment - Clarity Smart Contract

**Proof of Payment** is a Clarity smart contract on the Stacks blockchain that enables users to submit, store, and verify immutable proofs of payment. This contract is designed to create verifiable, on-chain receipts for transactions, useful for marketplaces, services, and audits.

---

 Features

-  **Submit Payment Proof:** Users can log a unique proof of payment referencing a transaction ID.
-  **Immutable Records:** Once submitted, proofs are securely stored and cannot be altered.
-  **Verify Payments:** Anyone can verify if a specific transaction reference has a valid payment proof.
-  **Timestamped Proofs:** Each proof includes a block timestamp for reliable audit trails.

---

 Contract Functions

 Public Functions

| Function          | Parameters                               | Description                        |
|-------------------|------------------------------------------|------------------------------------|
| `submit-proof`    | `reference-id (buff 32)`, `payee principal`, `amount uint` | Submit a new payment proof        |
| `verify-proof`    | `reference-id (buff 32)`                 | Check if proof exists             |

 Read-Only Functions

| Function             | Parameters                | Description                        |
|----------------------|---------------------------|------------------------------------|
| `get-proof-details`  | `reference-id (buff 32)`  | Retrieve full details of a proof  |

---

 Use Cases

-  Verifying freelance and service payments
-  Marketplace transaction validation
-  Transparent audit trails for financial transactions
-  Secure receipts in decentralized apps

---

 Example Usage

```clarity
;; Submit proof of payment
(submit-proof 0xabc123... 'SP2...ABC' u1000)

;; Verify if a proof exists
(verify-proof 0xabc123...)

;; Retrieve proof details
(get-proof-details 0xabc123...)
