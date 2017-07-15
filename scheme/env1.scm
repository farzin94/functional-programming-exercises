;; List based implementations 

(define make-empty-env
	(lambda ()
		'()
	)
)

(define apply-env 
	(lambda (env v)
		(cond
			((null? env) (display "apply-env: empty environment"))
			((equal? (car (car env)) v ) (cdr (car env)))
			(else (apply-env (cdr env) v))
		)
	)
)

(define extend-env 
	(lambda (v val env)
		(cons (cons v val) env)
	)
)

