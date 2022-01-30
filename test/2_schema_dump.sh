#!/bin/bash
set -e
cd ${0%/*}

# dump schema
pg_dump -h localhost -p 5432 -U postgres \
  --schema=auth_sender \
  --schema-only \
  --exclude-table="\w+.(\w+_audr|flyway_schema_history)" \
  --no-owner \
  --no-comments \
  --file=2_schema_input.sql

# show diff
git diff 2_schema_input.sql
