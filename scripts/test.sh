#!/bin/bash
set -e
cd ${0%/*}/..

# yarn db
# yarn dump
# mv dvdrental_schema.sql test/1_schema_input.sql

for i in {1..2}; do
  # run clean_schema
  src/clean_schema test/${i}_schema_input.sql > test/${i}_result.sql

  expect_checksum=$(md5sum test/${i}_schema_expect.sql | awk '{ print $1 }')
  actual_checksum=$(md5sum test/${i}_result.sql        | awk '{ print $1 }')

  if [[ "$expect_checksum" != "$actual_checksum" ]]; then
    echo "Test failed"
    diff -u test/${i}_schema_expect.sql test/${i}_result.sql | diff-so-fancy | less --tabs=4 -RFX
    exit -1
  fi

  echo "${i} - Test Pass"
  rm test/${i}_result.sql
done
