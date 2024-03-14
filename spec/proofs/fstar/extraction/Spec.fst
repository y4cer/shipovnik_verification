module Spec
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core
open FStar.Mul

let main (_: Prims.unit) : Prims.unit = ()

let xor (x_inp y_inp: u64) : u64 =
  let (x: u64):u64 = x_inp in
  let (y: u64):u64 = y_inp in
  let (r: u64):u64 = x ^. y in
  r
