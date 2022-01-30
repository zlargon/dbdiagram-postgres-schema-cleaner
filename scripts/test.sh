#!/bin/bash
set -e
cd ${0%/*}/..

# yarn db
# yarn dump
# mv dvdrental_schema.sql test/1_schema_input.sql

src/clean_schema test/1_schema_input.sql > test/1_result.sql

expect_checksum=$(md5sum test/1_schema_expect.sql | awk '{ print $1 }')
actual_checksum=$(md5sum test/1_result.sql        | awk '{ print $1 }')

if [[ "$expect_checksum" != "$actual_checksum" ]]; then
  echo "Test failed"
  diff -u test/1_schema_expect.sql test/1_result.sql | diff-so-fancy | less --tabs=4 -RFX
  exit -1
fi

echo "Test Pass"
rm test/1_result.sql
