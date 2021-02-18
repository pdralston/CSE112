% $Id: euclid.pl,v 1.3 2020-02-26 16:12:01-08 - - $

% Euclid's algorithm for greatest common divisor.
% The C version:
% int gcd (int x, int y) {
%    while (x != y) if (x > y) x -= y; else y -= x;
%    return x;
% }

gcd( X, Y, Z ) :- X > Y, T is X - Y, gcd( T, Y, Z ).
gcd( X, Y, Z ) :- X < Y, T is Y - X, gcd( X, T, Z ).
gcd( X, X, X ).

trace( gcd ).

% TEST: gcd( 111, 259, Z ).
