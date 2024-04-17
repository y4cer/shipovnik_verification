(* logic-examp.ec *)

require import AllCore.

lemma negb_or (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
    proof.
  split.

move => not_or.
split.
case a.
move =>  a_t.
simplify.
have a_or_b : a \/ b.
  left.
  trivial.
  trivial.
move => a_false.
trivial.
case b.
move => b_true.
simplify.
have contradict : a \/ b.
right.
trivial.
trivial.
trivial.

move => not_a_not_b.
case (a \/ b).
    move => a_or_b.
      elim a_or_b.
  qed.

lemma foo (x y z : int) :
  !(x < y \/ y < z) <=> ! x < y /\ ! y < z.
proof.

qed.

lemma negb_or' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

lemma negb_or'' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

lemma negb_or''' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.
