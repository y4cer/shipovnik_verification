require import Bool Int IntDiv DInterval.

(* reserved for future redefinition of the encryption scheme

module type Scheme = {
  proc genKey() : int
  proc en
}.

  *)


require (****) Group.

clone Group.CyclicGroup as G.

axiom prime_p : IntDiv.prime G.order.

clone G.PowZMod as GP with
  lemma prime_order <- prime_p.

clone GP.FDistr as FD.

import G GP FD GP.ZModE.

type gdouble =  (group * group).

  (*
Here we define the module Simple, which represents simple encryption/decryption scheme we will use later
  *)

module Simple = {
  proc keygen() : gdouble = {
    var x: exp;
    x <$ FD.dt;
    return (g ^ x, g ^ (-x));
  }

  proc encrypt(msg: group, pub_key: group) : group = {
    return msg * pub_key;
  }

  proc decrypt(ct: group, priv_key: group) : group = {
    return ct * priv_key;
  }
}.

