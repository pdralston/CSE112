#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/ocaml/bin/ocaml

#load "str.cma";;

open Printf;;

let buffer : string list ref = ref [];;

let rec read_number () = match !buffer with
    | head::tail -> (buffer := tail;
                     try float_of_string head
                     with Failure _ -> nan)
    | [] -> let line = input_line stdin
            in (buffer := Str.split (Str.regexp "[ \\t]+") line;
                read_number ());;

let rec main () =
    try let number = read_number()
        in (printf "%.16g\n%!" number;
            main ())
    with End_of_file -> print_endline "End_file";;

main ();;

