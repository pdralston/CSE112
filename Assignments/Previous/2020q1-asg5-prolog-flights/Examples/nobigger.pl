% $Id: nobigger.pl,v 1.5 2020-02-26 16:09:45-08 - - $ */

%
% Sample of the use of tracing.
% Find the biggest number in a list.
%

mynumber( 3 ).
mynumber( 6 ).
mynumber( 9 ).

biggest( Number ) :- mynumber( Number ), nobigger( Number ).

nobigger( Number ) :- mynumber( Other ), Other > Number, !, fail.

nobigger( _ ).

% TEST: biggest(N).
