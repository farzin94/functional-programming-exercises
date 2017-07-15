;; Using closures


(define empty-env-closure
	(lambda ()
		(lambda()
			'()
		)
	)
)

(define make-empty-env 
	(empty-env)
)

(define extend-env-closure
	(lambda (env)
		(lambda (v val) (cons (cons v val) env))
	)
)

(define extend-env
	(lambda (v val env)
		(define func (extend-env-closure env))
		(func v val)
	)
)

(define apply-env-closure
	(lambda (env)
		(lambda (v)
			(cond
				((null? env) (display "apply-env: empty environment"))
				((equal? (car (car env)) v) (cdr (car env)))
				(else (apply-env (cdr env) v))
			)
		)
	)
)

(define apply-env
	(lambda (env v)
		(define func (apply-env-closure env))
		(func v)
	)
)