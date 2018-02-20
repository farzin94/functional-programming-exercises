;; Scheme Problem Set - Assignment 3

;; returns the last element of lst
(define my-last 
	(lambda (lst)
		(cond
			((null? lst) (error "my-last: empty list"))
			((null? (cdr lst)) (car lst))
			(else (my-last (cdr lst)))
		)
	)
)

;; returns a list that is the same as lst except x has been added to the right end of the list.
(define snoc
	(lambda (a lst)
		(append lst (cons a '()))
	)
)

;; helper for range
(define backwards-range
	(lambda (n)
		(if (> n 0) 
			(cons (- n 1) (backwards-range (- n 1)) )
			'()
		)
	)
)
;; returns the list (0 1 2 ... n-1)
(define range 
	(lambda (n) 
		(reverse (backwards-range n))
	)
)

;; returns the sum of all the numbers in lst, including numbers within lists.
;; Took deep-count from the scheme class notes and modified to make a sum 
;; instead of count
(define deep-sum
    (lambda (lst)
        (cond
            ((null? lst) 0)
            ((list? (car lst)) (+ (deep-sum (car lst)) (deep-sum (cdr lst))))
            ((number? (car lst)) (+ (car lst) (deep-sum (cdr lst))))
            (else (deep-sum (cdr lst)))
        )
    )
)

;; https://stackoverflow.com/questions/13791047/scheme-prime-numbers
;; Used prime-helper and is-prime from this post but simplified most of it
;; and modified to fit requirements for questions
(define prime-helper 
	(lambda (x k)
		(cond 
			((= x k) #t)
			((= (remainder x k) 0) #f)
			(else (prime-helper x (+ k 1)))
		)
	)
)
(define is-prime? 
	(lambda (x)
		(cond
			((equal? x 1 ) #f)
			((equal? x 2 ) #t)
			(else (prime-helper x 2 ))
		)
	)
)
;; returns the number of primes less than, or equal to, n
(define count-primes
	(lambda (n)
		(cond
 			((equal? n 0) 0)
 			((is-prime? n) (+ 1 (count-primes (- n 1)) ))
 			(else (count-primes (- n 1)) )
		)
	)
)

;; returns #t when x is the number 0 or 1, and #f otherwise
(define is-bit?
	(lambda (x)
		(and (integer? x) (or (equal? x 0) (equal? x 1)))
	)
)

;; returns true if lst is the empty list, or if it contains only bits
(define is-bit-seq?
	(lambda (lst)
		(or 
			(null? lst)
			(if (not (is-bit? (car lst)))
				#f
				( is-bit-seq? (cdr lst) )
			)
		)
	)
)

;; Decimal to binary converter
(define dec-bin
	(lambda (n)
		(if (zero? n) 
			'()
			(snoc (remainder n 2) (dec-bin (quotient n 2)) )
        )
	)
)

;; Generate n number of zeros
(define zeros 
	(lambda (n)
		(if (> n 0)
			(cons 0 (zeros (- n 1)))
			'()
		)
	)
)

;; Add zeros to binary number to make it length n
(define zero-padder
	(lambda (ex n)
		(if (equal? (length (dec-bin ex)) n)
			(dec-bin ex)
			(append (zeros (- n (length (dec-bin ex)))) (dec-bin ex))
		)
	)
)

(define generate-bit-seqs
	(lambda (ex n) 
		(cond
			((>= ex 0)
				(cons (zero-padder ex n) (generate-bit-seqs(- ex 1) n) ))
			(else 
				'())
		)
	)
)

;; returns a list of all the bit sequences of length n
(define all-bit-seqs 
	(lambda (n)
		(if (< n 1)
			'()
			(generate-bit-seqs (- (expt 2 n) 1 ) n)
		)
	)
)

