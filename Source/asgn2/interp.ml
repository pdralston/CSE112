(* $Id: interp.ml,v 1.18 2021-01-29 11:08:27-08 - - $ *)

open Absyn
open Tables
open Printf
open Dumper
open Etc

let want_dump = ref false

let source_filename = ref ""

let rec eval_expr (expr : Absyn.expr) : float = match expr with
    | Number number -> number
    | Memref memref -> eval_memref memref
    | Unary (oper, expr) -> (eval_unop  oper) (eval_expr expr)
    | Binary (oper, expr1, expr2) -> (eval_binop oper) (eval_expr expr1) (eval_expr expr2)

and eval_binop op = 
    let result = try (Hashtbl.find binary_fn_table op)
                     with Not_found -> die ["Binop not found"]; (+.)
    in result

and eval_unop op =
    let result = try (Hashtbl.find unary_fn_table op)
                     with Not_found -> die ["Unop not found"]; (~+.)
    in result

and eval_memref (memref : Absyn.memref) : float = match memref with
    | Arrayref (ident, expr) -> 
        (let index = int_of_round_float (eval_expr expr)
        and array = try (Hashtbl.find array_table ident)
                    with Not_found -> (die ["Undefined Array Access"]); [|0.0|]
        in try Array.get array index
           with Invalid_argument _-> die ["Invalid Index argument"]; 0.0)
    | Variable ident -> try Hashtbl.find Tables.variable_table ident
                        with Not_found -> 0.0

and eval_STUB reason = (
    print_string ("(" ^ reason ^ ")");
    nan)

let rec interpret (program : Absyn.program) = match program with
    | [] -> ()
    | firstline::continue -> match firstline with
       | _, _, None -> interpret continue
       | _, _, Some stmt -> (interp_stmt stmt continue)

and interp_stmt (stmt : Absyn.stmt) (continue : Absyn.program) =
    match stmt with
    | Dim (ident, expr) -> interp_dim ident expr continue
    | Let (memref, expr) -> interp_let memref expr continue
    | Goto label -> interp_STUB "Goto label" continue
    | If (expr, label) -> interp_STUB "If (expr, label)" continue
    | Print print_list -> interp_print print_list continue
    | Input memref_list -> interp_input memref_list continue

and interp_dim (ident : Absyn.ident) (expr : Absyn.expr) (continue : Absyn.program) = 
    let len = int_of_round_float (eval_expr expr)
    in let array = (Array.make len 0.0)
    in Hashtbl.add Tables.array_table ident array;
    interpret continue

and interp_let (memref : Absyn.memref) (expr : Absyn.expr) (continue : Absyn.program) =
    interp_let_helper memref expr;
    interpret continue

and interp_let_helper (memref : Absyn.memref) (expr : Absyn.expr) =
    match memref with
    | Variable label ->
        let value = eval_expr expr
        in Hashtbl.replace Tables.variable_table label value;
    | Arrayref (arr, indexExpr)-> 
        let value = eval_expr expr
        and index = int_of_round_float (eval_expr indexExpr)
        and array = Hashtbl.find Tables.array_table arr
        in try array.(index)<-value;
            Hashtbl.replace Tables.array_table arr array;
            with Not_found -> printf "%s: Not_found\n%!" arr;

and interp_print (print_list : Absyn.printable list)
                 (continue : Absyn.program) =
    let print_item item = match item with
        | String string ->
          let regex = Str.regexp "\"\\(.*\\)\""
          in print_string (Str.replace_first regex "\\1" string)
        | Printexpr expr ->
          print_string " "; print_float (eval_expr expr)
    in (List.iter print_item print_list; print_newline ());
    interpret continue

and interp_input (memref_list : Absyn.memref list)
                 (continue : Absyn.program)  =
    let input_number memref =
        try 
            let eof = Hashtbl.find Tables.variable_table "eof"
            in if eof = 0.0
                then
                    let number = Etc.read_number ()
                    in interp_let_helper memref (Number number)
                else 
                    interp_let_helper memref (Number 0.0)
        with End_of_file -> 
             interp_let_helper (Variable "eof") (Number 1.0)
    in List.iter input_number memref_list;
    interpret continue

and interp_STUB reason continue = (
    print_string "Unimplemented: ";
    print_string reason;
    print_newline();
    interpret continue)

let interpret_program program =
    (Tables.init_label_table program; 
     if !want_dump then Tables.dump_label_table ();
     if !want_dump then Dumper.dump_program program;
     interpret program;
     if !want_dump then Tables.dump_label_table ())
