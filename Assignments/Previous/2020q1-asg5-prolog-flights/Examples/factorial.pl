% $Id: factorial.pl,v 1.4 2020-02-26 16:16:53-08 - - $ */

%
% Factorial, the old intro to recursion standby.
%

factorial( 0, 1).

factorial( N, Nfac) :-
	M is N - 1,
	factorial( M, Mfac),
	Nfac is N * Mfac.

