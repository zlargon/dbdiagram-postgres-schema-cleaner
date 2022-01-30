#!/bin/bash
set -e
cd ${0%/*}

for i in {1..2}; do
  # run clean_schema
  ../../src/clean_schema ${i}_schema_input.sql > ${i}_result.sql

  # check the checksum
  expect_checksum=$(md5sum ${i}_schema_expect.sql | awk '{ print $1 }')
  actual_checksum=$(md5sum ${i}_result.sql        | awk '{ print $1 }')

  if [[ "$expect_checksum" != "$actual_checksum" ]]; then
    echo "${i} - Test Failed"
    if [[ "$CI" == "1" ]]; then
      diff -u ${i}_schema_expect.sql ${i}_result.sql | diff-so-fancy
      exit -1
    fi

    # show diff
    diff -u ${i}_schema_expect.sql ${i}_result.sql | diff-so-fancy | less --tabs=4 -RFX

    # ask for update test case
    echo ""
    read -p "Do you want to update the test case? [Y/N] " ans
    if [[ $ans == "Y" || $ans == "y" ]]; then
      cp ${i}_result.sql ${i}_schema_expect.sql
    else
      exit -1
    fi
  fi

  echo "${i} - Test Pass"
  rm ${i}_result.sql
done
