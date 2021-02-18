(* $Id: complex-nrs.ml,v 1.1 2021-02-08 11:40:57-08 - - $ *)

(*
* Euler example from other languages.
* Uses module Complex.
*)

open Printf;;

let ( +: ) = Complex.add;;
let ( -: ) = Complex.sub;;
let ( *: ) = Complex.mul;;
let ( /: ) = Complex.div;;
let ( ~-: ) = Complex.neg;;

let ( +:+ ) x y = {Complex.re = x; im = y};;
let ( ?: ) x = x +:+ 0.0;;
let string_of_complex (x : Complex.t)
            = "(" ^ string_of_float x.re
            ^ "," ^ string_of_float x.im ^ ")";;

let ( **: ) = Complex.pow;;
let cexp = Complex.exp;;
let clog = Complex.log;;
let csqrt = Complex.sqrt;;

let ci = csqrt (?: ~-.1.0);;
let cpi = ?: (acos ~-.1.0);;

let csin x = (cexp (ci *: x) -: cexp (~-: ci *: x)) /: (?: 2.0 *: ci);;
let ccos x = (cexp (ci *: x) +: cexp (~-: ci *: x)) /: (?: 2.0);;

let euler_exp x = cexp (ci *: x);;
let euler_trig x = ccos x +: ci *: csin x;;

euler_exp cpi;;
euler_trig cpi;;

euler_exp (?: 0.0);;
euler_trig (?: 0.0);;

let rec digits fraction =
    let sum = 1.0 +. fraction
    in (printf "%.16g +. %.16g = %.16g\n%!"
               1.0 fraction (1.0 +. fraction);
        if sum > 1.0 then digits (fraction /. 10.0)
                     else ());;

printf "What is epsilon?\n%!";
digits 0.0000001;;

