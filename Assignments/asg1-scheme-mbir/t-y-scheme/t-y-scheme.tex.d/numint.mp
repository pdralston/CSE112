
% File: t-y-scheme.mp
beginfig(1);

u = 1mm;

x.max = 120u;
y.max = 70u;

% draw x- and y-axes
drawarrow (-5u,0) -- (x.max,0);
drawarrow (0,-5u) -- (0,y.max);

% label the axes
label.rt(btex $x$ etex, (x.max,0) shifted (5,0));
label.top(btex $y$ etex, (0,y.max) shifted (0,5));

x0 = 25u;

% interval between x[i] and x[i+1] is h
h = 5u;

% number of intervals (minus 1)
n = 14;

% calculate all the x[i]
for i = 1 upto n:
  x[i] = x0 + i*h;
%  drawdot(x[i],0);
endfor;

% specify a function f(x) that is defined
% for all x in [ x0, x[n] ]
path f;
f = (x0-5u,40u) .. (x0+2h,55u) .. (x0+4h,65u) ..
(x0+6h,55u) .. (x0+7h,55u) .. (x[n]+10u,50u);
draw f;

% label f(x)
label.rt(btex $f(x)$ etex, point infinity of f);

% x[i] is a good-looking abcissa in the middle
% of [ x0, x[n] ]
%i = 8;
i = n div 2;

path ord[];

% calculate (and draw) the ordinates for f(x)
% at x0, x[i], x[i+1], x[n]
for j = 0,i,i+1,n:
z[j]f = ( (x[j],0)--(x[j],y.max) ) intersectionpoint f;
ord[j] = (x[j],0) -- (x[j],y[j]f);
draw ord[j];
endfor;

%% gray the integral area
%path integ;
%integ = buildcycle(((x0-5,0)--(x[n]+5,0)),
%          ( (x0,-1) .. ord0 .. (x0,y0f+1)), f,
%((x[n],-1) ..  ord[n] .. (x[n], y[n]f+1))) ;
%fill integ withcolor .8white;

% identify x[i]--x[i+1] distance as h
path hline;
hline = (x[i],2h)--(x[i+1],2h);

drawdblarrow hline;
label.top(btex $h$ etex, point .5 of hline);

% label the abcissae x0, x[i], x[i+1], x[n]

dotlabel.bot(btex $\strut x_0 = a$ etex, (x0,0));
dotlabel.bot(btex $\strut x_i$ etex, (x[i],0));
dotlabel.lrt(btex $\strut x_{i+1}$ etex, (x[i+1],0));
dotlabel.bot(btex $\strut x_n = b$ etex, (x[n],0));

% label the corresponding ordinates
label.lft(btex $y_0$ etex, point .5 of ord0);
label.lft(btex $y_i$ etex, point .5 of ord[i]);
label.rt(btex $y_{i+1}$ etex, point .5 of ord[i+1]);
label.rt(btex $y_n$ etex, point .5 of ord[n]);


endfig;
end.

