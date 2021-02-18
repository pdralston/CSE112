#!/bin/env ocaml
(* $Id: factorial.ml,v 1.1 2021-01-26 00:11:28-08 - - $ *)
(* Factorial example. *)

open Printf;;

let rec fac'nt = function
    | 0 -> 1
    | n when n > 0 -> n * fac'nt (n - 1)
    | n -> invalid_arg ("fac'nt (" ^ (string_of_int n) ^ ")");;

(* Should be nested, but leave it global so can trace. *)
let rec fac' n' r' = match n' with
    | 0 -> r'
    | n -> fac' (n' - 1) (n' * r')

let fac n =
    if n < 0 then invalid_arg ("fac (" ^ (string_of_int n) ^ ")")
             else fac' n 1;;

let printfac n = (printf "fac %d = %d\n" n (fac n);
                  flush stdout);;

printfac 0;;
printfac 1;;
printfac 2;;
printfac 5;;
printfac 10;;
printfac 20;;
printfac (-5);;

