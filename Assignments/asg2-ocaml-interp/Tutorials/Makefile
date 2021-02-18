# $Id: Makefile,v 1.1 2008-02-21 16:49:11-08 - - $

MK_HREFS =      perl -pe 'print "<PRE>\n" if $$.==1; \
                s/\&/\&amp;/g; s/\</\&lt;/g; s/\>/\&gt;/g; \
                s{(http|ftp)://\S+}{<A HREF=$$&\n       >$$&</A>}g;'

README.html: README.text
	cid README.text
	${MK_HREFS} <README.text >README.html
