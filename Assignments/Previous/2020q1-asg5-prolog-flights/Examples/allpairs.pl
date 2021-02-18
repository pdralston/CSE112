% $Id: allpairs.pl,v 1.3 2020-12-02 16:29:53-08 - - $ */

%
% Query pair will return all pairs.
%

positive(red).
positive(green).
positive(blue).
negative(cyan).
negative(magenta).
negative(yellow).

pair(Pos,Neg) :- positive(Pos), negative(Neg).

allpairs :- pair(Pos,Neg), print( pair(Pos,Neg) ), nl, fail.


