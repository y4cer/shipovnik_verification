require import AllCore IntDiv Int CoreMap.

module M = {
    var x, y : int
    proc f() : unit = {
        if (0 <= x) {
            while (0 < x) {
                x <- x - 1;
                y <- y + 1;
            }
        }
        else {
            while (x < 0) {
                x <- x + 1;
                y <- y - 1;
            }
        }
    }
}.

search "ler_subr_addr".


lemma correct (x_ y_ : int) :
hoare[M.f : M.x = x_ /\ M.y = y_ ==> M.y = x_ + y_].
proof.
    
proc.
if.
while (0 <= M.x /\ M.x + M.y = x_ + y_).
wp.
simplify.
skip.
(* This tactic immediately solves the goal. 
  smt.
  *)
move => &hr.
move => /= [] [].
move => ge0_Mx invariant gt0_Mx.
split.
rewrite ler_subr_addr /=.

qed.
