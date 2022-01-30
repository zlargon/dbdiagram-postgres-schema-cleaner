# Postgres Schema Cleaner for dbdiagram.io

Clean up non-supported SQL syntax before importing PostgreSQL schema to https://dbdiagram.io/

Only keep the CREATE statements which are in the below list:

- CREATE GLOBAL
- CREATE LOCAL
- CREATE SCHEMA
- CREATE SEQUENCE
- CREATE TABLE
- CREATE TEMP
- CREATE TEMPORARY
- CREATE TYPE
- CREATE UNIQUE
- CREATE UNLOGGED
- CREATE VIEW

Drop other CREATE statements, such as:

- CREATE FUNCTION
- CREATE DOMAIN
- CREATE AGGREGATE
- CREATE INDEX
- CREATE TRIGGER
- ...

## Usage

```bash
./clean_schema schema.sql # show in the console

./clean_schema schema.sql > schema_new.sql # write into a file

cat schema.sql | ./clean_schema > schema_new.sql
```
