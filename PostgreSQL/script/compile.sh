#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/

# Variables used in the script
BASE_DIR=$DIR"../../PostgreSQL/"
LIB_DIR=$BASE_DIR"pgsql/lib/"
#LIB_HEADER_DIR="usr/include/"
CONFIGURE=YES
GDB=NO 
COMPILE_OPTION=""

# Parse parameters.
for i in "$@"
do
case $i in
	-b=*|--base-dir=*)
	BASE_DIR="${i#*=}"
	shift
	;;

	-c=*|--compile-option=*)
	COMPILE_OPTION="${i#*=}"
	shift
	;;

	--no-configure)
	CONFIGURE=NO
	shift
	;;

	--gdb)
	GDB=YES
	shift
	;;

	*)
		# unknown option
	;;
esac
done

# Install prerequisites
sudo apt-get update
sudo apt-get install -y libreadline-dev

# Set compiler to clang
export CXX=gcc

SOURCE_DIR=$BASE_DIR"postgres/"
TARGET_DIR=$BASE_DIR"pgsql/"

cd $SOURCE_DIR

./configure --silent
make clean -j --silent

# gdb
if [ "$GDB" == "YES" ]
then
COMPILE_OPTION+=" -ggdb -O0 -g3 -fno-omit-frame-pointer"
else
COMPILE_OPTION+=" -O3"
fi

# configure
if [ "$CONFIGURE" == "YES" ]
then
	echo "configure start"
	./configure --silent --prefix=$TARGET_DIR --enable-cassert \
		CFLAGS="$COMPILE_OPTION" --with-libs="$LIB_DIR"
fi

echo "make start"
make -j$(nproc) --silent

echo "make install start"
make install -j$(nproc) --silent
