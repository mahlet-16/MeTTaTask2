(: List type)
(: Nil ListNil)
(: Cons(-> Number List List))

(= (length ())0)
(= (length (:: $x $xs)) (+ 1 (length $xs)))

!(length (:: 4(:: 8(:: 7 ()))))

(=(is-member $x Nil)False)
(=(is-member $x(:: $x $xs))True)
(=(is-member $x(:: $y $ys))(is-member $x $ys))

!(is-member 5 (:: 6(:: 4(:: 9 Nil))))

(=(append Nil $x)$x)
(=(append (:: $y $ys)$x)(:: $y(append $ys $x)))

!(append (:: 4(:: 6(:: 2 Nil)))(:: 2(:: 8 Nil)))

(=(max-value(:: $x Nil))$x)
(=(max-value (:: $x $xs))(if (> $x(max-value $xs)) $x(max-value $xs)))
!(max-value(:: 4(:: 6(:: 2(:: 8 Nil)))))

(=(min-value (:: $x Nil))$x)
(=(min-value (:: $x $xs))(if (< $x (min-value $xs)) $x (min-value $xs)))
!(min-value(:: 4(:: 6(:: 2(:: 8 Nil)))))

(=(push $x $xs)(:: $x $xs))
!(push 6(:: 8(:: 5(:: 9 Nil))))

(=(pop Nil)Nil)
(=(pop (:: $x $xs))$xs)

!(pop (:: 7(:: 9(:: 4 Nil))))

(=(remove-elementNil)Nil)
(=(remove-element $x(:: $x $xs))(remove-element $x $xs))
(=(remove-element $x(:: $y $xs))(:: $y (remove-element $x $xs)))
!(remove-element 4(:: 7(:: 4(:: 4(:: 9 Nil)))))

(=(remove-duplicate Nil)Nil)
(=(remove-duplicate (:: $x $xs))(if (is-member $x $xs)(remove-duplicate $xs)(:: $x(remove-duplicate $xs))))
!(remove-duplicate(:: 4(:: 7(:: 4(:: 7(:: 9 Nil))))))