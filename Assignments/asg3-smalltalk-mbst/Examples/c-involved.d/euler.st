#!/afs/cats.ucsc.edu/courses/cse112-wm/usr/smalltalk/bin/gst -f
"$Id: euler.st,v 1.1 2021-02-10 18:23:58-08 - - $"

endl := Character nl.

i := -1 sqrt.
pi := -1 arcCos.

euler_exp := [:x| (i * x) exp].
euler_trig := [:x| x cos + (i * x sin)].

stdout << 'i = ' << i << endl.
stdout << 'pi = ' << pi << endl.

stdout << 'euler_exp value: pi = ' << (euler_exp value: pi) << endl.
stdout << 'euler_trig value: pi = ' << (euler_trig value: pi) << endl.

stdout << 'euler_exp value: 0 = ' << (euler_exp value: 0) << endl.
stdout << 'euler_trig value: 0 = ' << (euler_trig value: 0) << endl.

