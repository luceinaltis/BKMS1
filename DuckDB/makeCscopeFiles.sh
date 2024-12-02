#!/bin/bash

# cscope
find ./ \( -path ./test -prune -o \
 		   -path ./sql-common -prune -o \
		   -path ./build -prune -o \
		   -path ./testclients -prune -o \
		   -path ./plugin -prune -o \
		   -path ./extra -prune -o \
		   -path ./unittest -prune -o \
		   -path ./router -prune -o \
		   -path ./utilities -prune -o \
		   -path ./client -prune -o \
		   -path ./components -prune -o \
		   -path ./pgsql -prune -o \
		   \) -o -regextype posix-extended -regex '.*\.(h|c|cc|hpp|cpp|pl|tcc)$' -print > cscope.files

cscope -q -i cscope.files 

# ctags
ctags -R ./
