#!/bin/bash
set -e
cd ${0%/*}

# dump schema
pg_dump -h localhost -p ${ENV_POSTGRES_PORT:=5432} -U postgres -d dvdrental \
  --schema=public \
  --schema-only \
  --no-owner \
  --no-comments \
  --file=1_schema_input.sql

# show diff
git diff 1_schema_input.sql
