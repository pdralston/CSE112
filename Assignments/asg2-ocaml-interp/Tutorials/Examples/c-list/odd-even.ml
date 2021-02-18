(* $Id: odd-even.ml,v 1.1 2021-01-26 00:12:08-08 - - $ *)

(*
* Example of mutually recursive functions
*)

let rec oddlen list = match list with
    | [] -> false
    | _::tail -> evenlen tail

and evenlen list = match list with
    | [] -> true
    | _::tail -> oddlen tail
;;

(*
* Similar example but not mutually recursive.
*)

let rec oddlen' list = match list with
    | [] -> false
    | [_] -> true
    | _::_::tail -> oddlen' tail;;
