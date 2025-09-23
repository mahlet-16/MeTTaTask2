;Question one
(: Leaf (Tree $t))
(: Node (-> $t (Tree $t) (Tree $t) (Tree $t)))

(Node "grandParent"
  (Node "Parent1"
    (Node "child1" (Leaf) (Leaf))
    (Node "child2" (Leaf) (Leaf)))
  (Node "Parent2" (Leaf) (Leaf))
)

;Question two
(: Nil (List $t))
(: :: (-> $t (List $t) (List $t)))


(= (length Nil) 0)
(= (length (:: $x $xs)) (+ 1 (length $xs)))

! (length (:: 1 (:: 2 (:: 3 Nil)))) 

(= (is-member $x Nil) False)
(= (is-member $x (:: $y $ys)) (if (== $x $y) True (is-member $x $ys)))

! (is-member 2 (:: 1 (:: 2 (:: 3 Nil)))) 
! (is-member 5 (:: 1 (:: 2 (:: 3 Nil)))) 

(= (append Nil $ys) $ys)
(= (append (:: $x $xs) $ys) (:: $x (append $xs $ys)))

! (append (:: 1 (:: 2 Nil)) (:: 3 (:: 4 Nil))) 

(= (max-value (:: $x Nil)) $x)
(= (max-value (:: $x (:: $y $ys)))
   (bind! $max-rest (max-value (:: $y $ys)))
   (if (> $x $max-rest) $x $max-rest))

! (max-value (:: 3 (:: 7 (:: 2 Nil))))



(= (min-value (:: $x Nil)) $x)
(= (min-value (:: $x (:: $y $ys)))
   (bind! $min-rest (min-value (:: $y $ys)))
   (if (< $x $min-rest) $x $min-rest))
! (min-value (:: 3 (:: 7 (:: 2 Nil))))


(= (push $x $list) (:: $x $list))

! (push 0 (:: 1 (:: 2 Nil))) 

(= (pop Nil) Nil)
(= (pop (:: $x $xs)) $xs)

! (pop (:: 1 (:: 2 (:: 3 Nil)))) 


(= (remove-element $x Nil) Nil)
(= (remove-element $x (:: $y $ys)) 
   (if (== $x $y) (remove-element $x $ys) (:: $y (remove-element $x $ys))))

! (remove-element 2 (:: 1 (:: 2 (:: 3 Nil)))) 


(= (remove-duplicate Nil) Nil)
(= (remove-duplicate (:: $x $xs)) 
   (:: $x (remove-duplicate (remove-element $x $xs))))

! (remove-duplicate (:: 1 (:: 2 (:: 1 (:: 3 Nil))))) 


(: map (-> (-> $t $u) (List $t) (List $u)))
(= (map $f Nil) Nil)
(= (map $f (:: $x $xs)) (:: ($f $x) (map $f $xs)))

(: double (-> Number Number))
(= (double $x) (* $x 2))

! (map double (:: 1 (:: 2 (:: 3 Nil)))) 


(: filter (-> (-> $t Bool) (List $t) (List $t)))
(= (filter $pred Nil) Nil)
(= (filter $pred (:: $x $xs)) 
   (if ($pred $x) (:: $x (filter $pred $xs)) (filter $pred $xs)))

(: is-even (-> Number Bool))
(= (is-even $x) (== (% $x 2) 0))

! (filter is-even (:: 1 (:: 2 (:: 3 (:: 4 Nil))))) 


(: foldl (-> (-> $acc $t $acc) $acc (List $t) $acc))
(= (foldl $f $acc Nil) $acc)
(= (foldl $f $acc (:: $x $xs)) (foldl $f ($f $acc $x) $xs))

(: add (-> Number Number Number))
(= (add $x $y) (+ $x $y))

! (foldl add 0 (:: 1 (:: 2 (:: 3 Nil)))) 


(: foldr (-> (-> $t $acc $acc) (List $t) $acc $acc))
(= (foldr $f Nil $acc) $acc)
(= (foldr $f (:: $x $xs) $acc) ($f $x (foldr $f $xs $acc)))

! (foldr add (:: 1 (:: 2 (:: 3 Nil))) 0) 
(= (reverse Nil) Nil)
(= (reverse (:: $x $xs)) (append (reverse $xs) (:: $x Nil)))

! (reverse (:: 1 (:: 2 (:: 3 Nil)))) 


(= (insert $x Nil) (:: $x Nil))
(= (insert $x (:: $y $ys)) 
   (if (< $x $y) (:: $x (:: $y $ys)) (:: $y (insert $x $ys))))

(= (sort Nil) Nil)
(= (sort (:: $x $xs)) (insert $x (sort $xs)))

! (sort (:: 3 (:: 1 (:: 2 Nil)))) 
(: compose ->(-> $B $C)(-> $A $B)(->$A $B))
(=(compose $f $g $x)($f ($g $x)))
(: add1 (-> Number Number))
(=(add1 $x)(+ $x 1))
(: square (-> Number Number))
(=(square $x)(* $x $x))
!(compose square add1 4)

(: curry (-> (-> $A $B $C)(->$A(-> $B $C))))
(=(((curry $f)$x)$y)($f $x $y))

(: curry2 (->(-> $A $B $C $D) $A (-> $B $C $D)))
(=((curry2 $f $x)$y $z)($f $x $y $z))
(: add3(-> Number Number Number Number))
(=(add3 $x $y $z)(+ $x (+ $y $z)))

!(((curry add) 6) 7)
!((curry2 add3 7) 9 8)

(: until (-> (-> $a Bool) (-> $a $a) $a $a))
(= (until $pred $f $x)
   (if ($pred $x)
       $x
       (until $pred $f ($f $x))))
(: greater-than-10 (-> Number Bool))
(= (greater-than-10 $x) (> $x 10))

(: add2 (-> Number Number))
(= (add2 $x) (+ $x 2))

! (until greater-than-10 add2 2) 

(= (sum Nil)0)
(=(sum (:: $x $xs))(+ $x (sum $xs)))
!(sum (:: 4(:: 9(:: 5 Nil))))


(=(product Nil)1)
(=(product (:: $x $xs ))(* $x (product $xs)))
!(product (:: 4(:: 9(:: 5 Nil))))

(: count(-> $t (List $t)Number))
(=(count $x Nil)0)
(=(count $x(:: $y $ys))(if (== $x $y)(+ 1 (count $x $ys))(count $x $ys)))
!(count 6 (:: 6(:: 4(:: 6(:: 8(:: 3 Nil))))))