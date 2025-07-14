;; ProofOfPayment - Publicly Verifiable Payment Receipts

(define-constant contract-owner tx-sender)

(define-map receipts
  {sender: principal}
  {amount: uint, timestamp: uint})

(define-data-var total-received uint u0)

;; Send STX and receive a receipt
(define-public (send-payment)
  (let ((payment-amount (stx-transfer? u100000 tx-sender (as-contract tx-sender))))
    (match payment-amount
      success
        (let ((timestamp stacks-block-height))
          (map-set receipts {sender: tx-sender} 
                   {amount: u100000, timestamp: timestamp})
          (var-set total-received (+ (var-get total-received) u100000))
          (ok { receipt: true, at: timestamp }))
      error (err error))))

;; Admin refunds a specific payer
(define-public (refund (payer principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u100))
    (let ((record (unwrap! (map-get? receipts {sender: payer}) (err u101))))
      (try! (stx-transfer? (get amount record) (as-contract tx-sender) payer))
      (map-delete receipts {sender: payer})
      (ok { refunded: payer, amount: (get amount record) }))))

;; Check a payment receipt
(define-read-only (get-receipt (payer principal))
  (ok (map-get? receipts {sender: payer})))
