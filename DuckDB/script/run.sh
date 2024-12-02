#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}

# Default
BASE_DIR="${DIR}/../duckdb"

LD_PRELOAD=$(gcc -print-file-name=libasan.so)

${BASE_DIR}/build/debug/duckdb test.duckdb
