(load "env2.scm")

(define test-env
    (extend-env 'a 1
        (extend-env 'b 2
            (extend-env 'c 3
                (extend-env 'b 4
                    (make-empty-env)))))
)

(load "myeval.scm")

(define env1
    (extend-env 'x -1
        (extend-env 'y 4
            (extend-env 'x 1
                (make-empty-env))))
)

(define env2
    (extend-env 'm -1
        (extend-env 'a 4
            (make-empty-env)))
)

(define env3
    (extend-env 'q -1
        (extend-env 'r 4
            (make-empty-env)))
)


(myeval '(2 ** q) env3)
(myeval '(1 + a) env2)
(myeval '(4 * (dec x)) env1)

;; (apply-env env1 'x)
;; (apply-env env2 'm)
;; (load "simplify.scm")
;; (simplify '(((a + b) - (a + b)) * ((1 + (0 * 0)) * (1 + 0))))
;; (simplify '(z ** (b * (dec 1))))
;; (simplify '(((a + 0) + (0 + 0)) + (0 + b)))


