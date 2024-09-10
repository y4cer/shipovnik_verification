require import AllCore List Distr.

type key, ptxt, nonce.

type ctxt = ptxt.

op (+) : ptxt -> ptxt -> ptxt.

op f : key -> nonce -> ptxt.

op dkey : key distr.

axiom addpA (x y z : ptxt) : x + y + z = x + (y + z).
axiom addpC (x y : ptxt) : x + y = y + x.
axiom addKp (x y : ptxt) : x + x + y = y.

(* 
  Module type for (symmetric) nonce-based encryption schemes.
  Intuitively, this specifies the interface that such 
  encryption schemes are expected to implement.
*)
module type NBEncScheme = {
  proc kgen(): key
  proc enc(k : key, n : nonce, m : ptxt): ctxt
  proc dec(k : key, n : nonce, c : ctxt): ptxt
}.

(* 
  Specification of the considered nonce-based encryption scheme.
  Because the module implements all the procedures specified in the NBEncScheme
  module type, the module has this type (making it valid to give it this type).  
*)
module E : NBEncScheme = {
  proc kgen() : key = {
    var k;

    k <$ dkey;
    
    return k;
  }

  proc enc(k : key, n : nonce, m : ptxt) : ctxt = {
    return (f k n) + m;
  }

  proc dec(k : key, n : nonce, c : ctxt) : ptxt = {
    return (f k n) + c;
  }
}.

module type Oraclei = {
  proc init(): unit
  proc enc(n: nonce, m: ptxt): ctxt option
}.


