
(define op? 
	(lambda (op)
		(or 
			(equal? op '+)
			(equal? op '-)
			(equal? op '*)
			(equal? op '/)
			(equal? op '**)
		)
	)

)

;; Taken from Scheme class notes
;; http://www.cs.sfu.ca/CourseCentral/383/tjd/scheme-intro.html
(define infix->prefix-generator
    (lambda (e)
        (if (number? e)
			e
			(let ((left (infix->prefix-generator (first e)))
				(op (second e))
				(right (infix->prefix-generator (last e)))
				)
				(cond
					((and (equal? op '/) (equal? right 0)) (error "Cannot divide by zero"))
					((equal? op '+) (+ left right))
					((equal? op '-) (- left right))
					((equal? op '*) (* left right))
					((equal? op '/) (/ left right))
					((equal? op '**) (expt left right))
)))))


(define infix->prefix 
	(lambda (expr)
		(if (op? (second expr))
			(infix->prefix-generator expr)
			(error "Incorrect grammar in expression")
		)
	)
)
(define in-env?
	(lambda (val env)
		(cond
			((null? env) #f)
			((equal? (car (car env)) val ) #t)
			(else (in-env? val (cdr env)))
		)
	)
)


;; TODO: Throw error if 
;; 	-expression does not follow grammar
;; Replaces any variable that exists in the env with its value
(define deep-replace 
	(lambda (expr env)
		(cond
			((null? expr) 
				'())
			((list? (car expr))
				(cons (deep-replace (car expr) env) (deep-replace (cdr expr) env)))
			((in-env? (car expr) env)
				(cons (apply-env env (car expr)) (deep-replace (cdr expr) env)))
			((or (number? (car expr)) (op? (car expr)))
				(cons (car expr) (deep-replace (cdr expr) env)))
			((equal? (car expr) 'inc)
				(cons '1 (cons '+ (deep-replace (cdr expr) env))))
			((equal? (car expr) 'dec)
				(append (deep-replace (cdr expr) env) (cons '- (cons '1 '()))) )
			(else 
				(error "variable not found in environment" ))
		)
	)
)

(define myeval
	(lambda (expr env)
		(infix->prefix (deep-replace expr env))
	)
)