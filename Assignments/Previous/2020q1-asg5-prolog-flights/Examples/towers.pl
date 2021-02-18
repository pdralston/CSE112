% $Id: towers.pl,v 1.4 2020-02-26 16:15:46-08 - - $ */

%
% Towers problem.
%

towers( N ) :-
   move( N, source, spare, target ).

move( 0, _, _, _ ) :-
   !.

move( N, Source, Spare, Target ) :-
   M is N - 1,
   move( M, Source, Target, Spare ),
   report( Source, Target ),
   move( M, Spare, Source, Target ).

report( Source, Target ) :-
   write( 'Move a disk from the ' ),
   write( Source ),
   write( ' peg to the ' ),
   write( Target ),
   write( ' peg.'),
   nl.

