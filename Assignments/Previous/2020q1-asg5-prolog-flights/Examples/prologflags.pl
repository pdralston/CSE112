#!/usr/local/bin/swipl
% $Id: prologflags.pl,v 1.1 2020-12-02 19:37:03-08 - - $ */

show( Flag) :-
    current_prolog_flag( Flag, Value),
    write( Flag), write( ': '), write( Value), nl.

all :-
    show( arch),
    show( argv),
    show( c_cc),
    show( color_term),
    show( compiled_at),
    show( cpu_count),
    show( executable),
    show( home),
    show( os_argv),
    show( posix_shell),
    show( timezone),
    show( tmp_dir),
    show( unix),
    nl.

