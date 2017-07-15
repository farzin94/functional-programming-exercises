;; Taken from Scheme notes from class 
(define nlist
    (lambda (n lst)
        (and (list? lst)
             (= n (length lst))
        )
    )
)

(define is-literal?
    (lambda (expr)
        (or (symbol? expr) (number? expr))
    )
)

(define is-add?
    (lambda (expr)
       (and (nlist 3 expr)
             (equal? '+ (cadr expr))
       )
    )
)

(define is-sub?
    (lambda (expr)
       (and (nlist 3 expr)
             (equal? '- (cadr expr))
       )
    )
)

(define is-multiply?
    (lambda (expr)
       (and (nlist 3 expr)
             (equal? '* (cadr expr))
       )
    )
)

(define is-expt?
    (lambda (expr)
       (and (nlist 3 expr)
             (equal? '** (cadr expr))
       )
    )
)

(define is-inc?
    (lambda (expr)
       (and (nlist 2 expr)
             (equal? 'inc (car expr))
       )
    )
)

(define is-dec?
    (lambda (expr)
       (and (nlist 2 expr)
             (equal? 'dec (car expr))
       )
    )
)

(define simplify
	(lambda (e)
		(cond
			((is-literal? e) e)
			(else 
				(let ((left (simplify (first e)))
                      (right (simplify (last e)))
                     )
				(cond 
					;; addition
					((and (is-add? e) (equal? 0 left)) right)
					((and (is-add? e) (equal? 0 right)) left) 
					((is-add? e) (list left '+ right))
					;; multiplication
					((and (is-multiply? e) (equal? 0 left)) 0)
					((and (is-multiply? e) (equal? 0 right)) 0)
					((and (is-multiply? e) (equal? 1 left)) right)
					((and (is-multiply? e) (equal? 1 right)) left)
					((is-multiply? e) (list left '* right))
					;; subtraction
					((and (is-sub? e) (equal? 0 right)) left)
					((and (is-sub? e) (equal? left right)) 0)
					((is-sub? e) (list left '- right))
					;; exponent
					((and (is-expt? e) (equal? 0 right)) 1)
					((and (is-expt? e) (equal? 1 right)) left)
					((and (is-expt? e) (equal? 1 left)) 1)
					((is-expt? e) (list left '** right))
					;; inc & dec
					((and (is-inc? e) (number? right) (simplify (list right '+ 1))))
					((and (is-dec? e) (number? right) (simplify (list right '- 1))))
				))
			)
		)
	)
)
