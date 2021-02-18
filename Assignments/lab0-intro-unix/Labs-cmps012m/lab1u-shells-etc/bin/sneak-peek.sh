#!/bin/sh
# $Id: sneak-peek.sh,v 1.1 2020-11-14 20:11:27-08 - - $
cat $0
cat $* | tr A-Z a-z | tr -c a-z '\n' | sort | uniq | fmt -65
