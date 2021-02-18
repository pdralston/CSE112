#!/bin/env ocaml
(* $Id: eval2-symbols.ml,v 1.2 2021-01-26 13:16:36-08 - - $ *)


type binop = float -> float -> float;;
type unop = float -> float;;

type expr = Binary of binop * expr * expr
          | Unary of unop * expr
          | Num of float
          | Ident of string;;

let vartable : (string, float) Hashtbl.t = Hashtbl.create 16;;
let _ = List.iter
        (fun (ident, value) -> Hashtbl.replace vartable ident value)
        ["pi"   , acos ~-. 1.;
         "e"    , exp 1.;
         "x"    , 8.;
         "y"    , 10.;
        ];;
let varfind ident = match Hashtbl.find_opt vartable ident with
    | None -> 0.0
    | Some value -> value;;

let rec eval_expr expr = match expr with
    | Num value -> value
    | Ident ident -> varfind ident
    | Binary (binop, e1, e2) -> binop (eval_expr e1) (eval_expr e2)
    | Unary (unop, e1) -> unop (eval_expr e1);;

eval_expr (Num 6.02e23);;

eval_expr (Ident "foobar");;

List.map eval_expr [Ident "pi"; Ident "e"];;

eval_expr (Binary ((+.), Ident "x", Ident "y"));;

eval_expr (Binary ((+.),
      Binary ((/.), Num 3., Num 4.),
      Binary ((/.), Num 7., Num 8.)));;


