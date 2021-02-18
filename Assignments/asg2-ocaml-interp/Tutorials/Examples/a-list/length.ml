#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/ocaml/bin/ocaml
(* $Id: length.ml,v 1.1 2021-01-26 00:11:28-08 - - $ *)

open Printf;;

let length1 list = 
    let rec len list' n = match list' with
        | [] -> n
        | _::tail -> len tail (n + 1)
    in len list 0;;

let length2 list =
    List.fold_left (fun n _ -> n + 1) 0 list;;

printf "%d\n%!" (length1 [1;2;3;4]);;
printf "%d\n%!" (length1 []);;

printf "%d\n%!" (length2 [1;2;3;4]);;
printf "%d\n%!" (length2 []);;

