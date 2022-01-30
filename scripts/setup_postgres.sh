#!/bin/bash
set -e
cd ${0%/*}/..
function echo_y { echo -e "\n\033[1;33m$@\033[0m"; } # yellow

POSTGRS_PORT=${ENV_POSTGRES_PORT:-5432}

echo_y "1. download dvdrental.zip"
if [[ ! -e "dvdrental.zip" ]]; then
  # https://www.postgresqltutorial.com/postgresql-sample-database/
  wget --quiet --user-agent="user" https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
fi

echo_y "2. unzip dvdrental.zip => dvdrental.tar"
if [[ ! -e "dvdrental.tar" ]]; then
  unzip dvdrental.zip
fi

echo_y "3. run postgres container"
docker compose -f docker-compose.yml -p dvdrental down
docker compose -f docker-compose.yml -p dvdrental up -d

echo_y "4. wait for postgres container ready"
sleep 7

echo_y "5. import dvdrental.tar to postgres"

echo_y " Before insert data:"
psql -h localhost -p ${POSTGRS_PORT} -U postgres -d dvdrental -c '\dt'

pg_restore -h localhost -p ${POSTGRS_PORT} -U postgres -d dvdrental dvdrental.tar

echo_y " After insert data:"
psql -h localhost -p ${POSTGRS_PORT} -U postgres -d dvdrental -c '\dt'

echo_y "6. Delete dvdrental.zip and dvdrental.tar"
rm -rf dvdrental*
