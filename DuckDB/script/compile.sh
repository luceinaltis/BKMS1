#!/bin/bash
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}

# Variables used in the script
BASE_DIR="${DIR}/../duckdb"
BUILD=RELEASE
#BUILD=DEBUG
PLATFORM=linux_amd64

# Remove the existing object files
cd ${BASE_DIR}
make clean -j

# Install prerequisites
sudo apt-get update
sudo apt-get install -y git g++ cmake ninja-build libssl-dev

# Compile the DuckDB
if [ ${BUILD} == "DEBUG" ]
then
	BUILD_TPCH=1 DUCKDB_PLATFORM=${PLATFORM} GEN=ninja make debug -j
else
	BUILD_TPCH=1 DUCKDB_PLATFORM=${PLATFORM} GEN=ninja make release -j
fi
