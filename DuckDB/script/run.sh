#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}

# Default
BASE_DIR="${DIR}/../duckdb"
BUILD=RELEASE
#BUILD=DEBUG

LD_PRELOAD=$(gcc -print-file-name=libasan.so)

# Compile the DuckDB
if [ ${BUILD} == "DEBUG" ]
then
	${BASE_DIR}/build/debug/duckdb db.duckdb
else
	${BASE_DIR}/build/release/duckdb db.duckdb
fi
