#!/bin/bash
set -e
cd ${0%/*}
function echo_y { echo -e "\n\033[1;33m$@\033[0m"; } # yellow

echo "POSTGRES_PORT = ${POSTGRES_PORT:=5432}"

# 1. download .zip
echo_y "1. download dvdrental.zip"
if [[ ! -e "dvdrental.zip" ]]; then
  # https://www.postgresqltutorial.com/postgresql-sample-database/
  wget --quiet --user-agent="user" https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
fi

# 2. unzip .zip
echo_y "2. unzip dvdrental.zip => dvdrental.tar"
if [[ ! -e "dvdrental.tar" ]]; then
  unzip dvdrental.zip
fi

# 3. run postgres docker container
echo_y "3. run postgres container"
docker compose -f docker-compose.yml -p dvdrental down
docker compose -f docker-compose.yml -p dvdrental up -d
echo_y "wait for postgres container ready..."
sleep 7

# 4. import .tar to postgres
echo_y "4. import dvdrental.tar to postgres"

echo_y " Before insert data:"
psql -h localhost -p ${POSTGRES_PORT} -U postgres -d dvdrental -c '\dt'

pg_restore -h localhost -p ${POSTGRES_PORT} -U postgres -d dvdrental dvdrental.tar

echo_y " After insert data:"
psql -h localhost -p ${POSTGRES_PORT} -U postgres -d dvdrental -c '\dt'

# 5. dump schema and clean the schema
echo_y "5. Dump and clean the schema"
dump_option="-h localhost -p ${POSTGRES_PORT} -U postgres -d dvdrental"
dump_option+=" --schema=public --schema-only --no-owner --no-comments"
echo "pg_dump ${dump_option} | ../../src/clean_schema > dvdrental_schema.sql"
pg_dump ${dump_option} | ../../src/clean_schema > dvdrental_schema.sql

# 6. check md5 checksum
echo_y "6. check md5 checksum: dvdrental_schema.sql & unit/1_schema_expect.sql"
expect_checksum=$(md5sum dvdrental_schema.sql        | awk '{ print $1 }')
actual_checksum=$(md5sum ../unit/1_schema_expect.sql | awk '{ print $1 }')
if [[ "$expect_checksum" == "$actual_checksum" ]]; then
  echo "Test Pass"
else
  echo "Test Failed"
  diff -u  dvdrental_schema.sql ../unit/1_schema_expect.sql | diff-so-fancy
  exit -1
fi

# 7. cleanup test resource and data
echo_y "7. shutdown the docker and cleanup test data"
docker compose -f docker-compose.yml -p dvdrental down
rm -rvf dvdrental*
