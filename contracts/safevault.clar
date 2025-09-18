;; -----------------------------------------
;; Contract: safe-vault
;; Trustless STX Vault
;; -----------------------------------------

(define-constant ERR_NOT_ENOUGH_FUNDS (err u100))
(define-constant ERR_ZERO_AMOUNT (err u101))

;; Data map to store user balances
(define-map vaults 
  { user: principal } 
  { balance: uint })

;; -----------------------------
;; Public Functions
;; -----------------------------

;; Deposit STX into vault
(define-public (deposit (amount uint))
  (begin
    (if (is-eq amount u0) 
        ERR_ZERO_AMOUNT
        (let ((transfer-result (stx-transfer? amount tx-sender (as-contract tx-sender))))
          (match transfer-result
            success 
              (let ((current-balance (default-to u0 (get balance (map-get? vaults { user: tx-sender })))))
                (map-set vaults { user: tx-sender } { balance: (+ current-balance amount) })
                (ok true))
            error transfer-result)))))

;; Withdraw STX from vault
(define-public (withdraw (amount uint))
  (let ((current-balance (default-to u0 (get balance (map-get? vaults { user: tx-sender })))))
    (if (>= current-balance amount)
        (begin
          (map-set vaults { user: tx-sender } { balance: (- current-balance amount) })
          (let ((transfer-result (stx-transfer? amount (as-contract tx-sender) tx-sender)))
            (match transfer-result
              success (ok true)
              error transfer-result)))
        ERR_NOT_ENOUGH_FUNDS)))

;; -----------------------------
;; Read-Only Functions
;; -----------------------------

;; Check user balance
(define-read-only (get-balance (owner principal))
  (default-to u0 (get balance (map-get? vaults { user: owner }))))
