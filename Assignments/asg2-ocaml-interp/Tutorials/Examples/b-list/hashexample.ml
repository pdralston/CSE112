#!/bin/env ocaml
(* $Id: hashexample.ml,v 1.3 2021-01-26 13:24:09-08 - - $ *)

open Printf;;

type variable_table_t = (string, float) Hashtbl.t;;

let variable_table : variable_table_t = Hashtbl.create 16;;
let _ = List.iter (fun (label, value) ->
                  Hashtbl.add variable_table label value)
                 ["e"  , exp 1.0;
                  "eof", 0.0;
                  "pi" , acos ~-.1.0;
                  "nan", nan];;

let printvalue_raise var =
    try let value = Hashtbl.find variable_table var
        in printf "%s = %.16g\n%!" var value
    with Not_found -> printf "%s: Not_found\n%!" var;;

let printvalue_opt var =
    let result = Hashtbl.find_opt variable_table var
    in (match result with
       | None -> printf "%s = None\n%!" var
       | Some value -> printf "%s = Some %.16g\n%!" var value);;

let vars = ["e"; "none"; "pi"; "foo"; "eof"; "nan"];;

printf  "\nprintvalue_raise...\n%!";;
List.iter printvalue_raise vars;;

printf  "\nprintvalue_opt...\n%!";;
List.iter printvalue_opt vars;;

