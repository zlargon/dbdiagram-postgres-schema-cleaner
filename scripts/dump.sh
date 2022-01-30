#!/bin/bash
set -e
POSTGRS_PORT=${ENV_POSTGRES_PORT:-5432}

# remove schema.sql
rm -rf dvdrental_schema.sql

# dump schema
pg_dump -h localhost -p $POSTGRS_PORT -U postgres -d dvdrental \
  --schema=public \
  --schema-only \
  --no-owner \
  --no-comments \
  --file=dvdrental_schema.sql
